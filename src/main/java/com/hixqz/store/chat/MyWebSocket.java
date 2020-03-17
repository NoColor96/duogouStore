package com.hixqz.store.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.server.standard.SpringConfigurator;

import com.hixqz.store.pojo.User;
import com.hixqz.store.service.UserService;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.sun.xml.internal.bind.v2.model.core.ID;
@Component
@ServerEndpoint(value="/chat/{uid}",configurator = SpringConfigurator.class,encoders = ServerEncoder.class)
public class MyWebSocket {
	public MyWebSocket() {}
	@Autowired
	UserService userService;
	private static Hashtable<Integer, MyWebSocket> webSockets = new Hashtable<>();
	//待发送集合
	private static Hashtable<Integer, List<Chat>> sendPools = new Hashtable<>();
	private List<Chat> sendPool = null;
	private Session session;
	private User user = null;
	public static int ServerId = -215;
	
	@OnOpen
	public void onOpen(Session session) throws EncodeException, IOException, InterruptedException {
		this.session = session;
		Integer uid = null;
		//延时3秒，模仿等待连接
		Thread.sleep(3000);
		try {
			//如果用户传过来的uid不正确，就关闭连接
			String secret = ChatUtil.decrypt_Base64(session.getPathParameters().get("uid"));
			uid = Integer.parseInt(secret.split("=")[1]);
			//如果账号已在其它地方登录，就提示，并关闭连接
			if(null != webSockets.get(uid)) {
				sendMessage("role:clash");
				session.close();
				return;
			}
		} catch (Exception e) {
			// TODO: handle exception
			sendMessage("role:error");
			session.close();
			return;
		}
		if(uid==ServerId) {
			user = new User();
			user.setId(ServerId);
			user.setName("server");
		}else {
			//当客服不在线时断开客户的连接
			if(webSockets.get(ServerId)==null) {
				sendMessage("role:notOnline");
				session.close();
				return;
			}
			//从数据库中取出用户信息
			user = userService.getPureUserById(uid);
		}
		//如果数据库中没有这个用户，就关闭连接
		if(null == user) {
			sendMessage("role:error");
			session.close();
			return;
		}
		//发送当前角色给客户端
		sendMessage("role:"+user.getName());
		//如果发送池中有该uid用户的待接收消息，则推送
		if(null != (sendPool = sendPools.get(uid))) {
			for(Chat chat : sendPool) {
				sendObjectMessage(this, chat);
				System.out.println("执行了");
			}
			sendPools.remove(uid);
		}
		//把当前的websocket添加至webSockets池中
		webSockets.put(user.getId(), this);
	}
	@OnClose
	public void onClose(){
		if(user != null)
			webSockets.remove(user.getId());
	}
	
	@OnMessage
	public void onMessage(String message,Session session){
		Chat chat = ChatUtil.jsonToChat(message);
		transpond(chat);
	}
	//转发消息给目标
	public void transpond(Chat chat) {
		User targetUser = chat.getAdverse();
		MyWebSocket myWebSocket = webSockets.get(targetUser.getId());
		chat.setAdverse(user);
		chat.getMessage().setType("received");
		chat.getMessage().setRead(false);
		//当目标用户不在线时，将消息存入发送池，等待用户上线时接收
		if(null == myWebSocket) {
			List<Chat> sendPool = sendPools.get(targetUser.getId());
			if(null == sendPool) {
				sendPool = new ArrayList<>();
			}
			sendPool.add(chat);
			sendPools.put(targetUser.getId(), sendPool);
			//目标用户不在线，系统自动回复
			autoResponse(targetUser);
		}else sendObjectMessage(myWebSocket, chat);
	}
	
	public void onError(Session session,Throwable error) {
		System.out.println("发生错误");
		error.printStackTrace();
	}
	
	public void sendMessage(String message) {
		try {
			this.session.getBasicRemote().sendText(message);
			/*this.session.getBasicRemote().sendObje*/
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void sendObjectMessage(MyWebSocket myWebSocket,Chat chat) {
		try {
			myWebSocket.session.getBasicRemote().sendObject(chat);
		} catch (IOException | EncodeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void autoResponse(User user) {
		Chat chat = new Chat();
		chat.setAdverse(user);
		Message message = new Message();
		message.setBody("你好，此刻我并不在线上，请给我留言，待我上线后回复");
		message.setRead(false);
		message.setTime(new Date().toGMTString());
		message.setType("received");
		chat.setMessage(message);
		sendObjectMessage(this, chat);
	}
}
