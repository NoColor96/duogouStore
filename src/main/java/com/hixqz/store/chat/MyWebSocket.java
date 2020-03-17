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
	//�����ͼ���
	private static Hashtable<Integer, List<Chat>> sendPools = new Hashtable<>();
	private List<Chat> sendPool = null;
	private Session session;
	private User user = null;
	public static int ServerId = -215;
	
	@OnOpen
	public void onOpen(Session session) throws EncodeException, IOException, InterruptedException {
		this.session = session;
		Integer uid = null;
		//��ʱ3�룬ģ�µȴ�����
		Thread.sleep(3000);
		try {
			//����û���������uid����ȷ���͹ر�����
			String secret = ChatUtil.decrypt_Base64(session.getPathParameters().get("uid"));
			uid = Integer.parseInt(secret.split("=")[1]);
			//����˺����������ط���¼������ʾ�����ر�����
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
			//���ͷ�������ʱ�Ͽ��ͻ�������
			if(webSockets.get(ServerId)==null) {
				sendMessage("role:notOnline");
				session.close();
				return;
			}
			//�����ݿ���ȡ���û���Ϣ
			user = userService.getPureUserById(uid);
		}
		//������ݿ���û������û����͹ر�����
		if(null == user) {
			sendMessage("role:error");
			session.close();
			return;
		}
		//���͵�ǰ��ɫ���ͻ���
		sendMessage("role:"+user.getName());
		//������ͳ����и�uid�û��Ĵ�������Ϣ��������
		if(null != (sendPool = sendPools.get(uid))) {
			for(Chat chat : sendPool) {
				sendObjectMessage(this, chat);
				System.out.println("ִ����");
			}
			sendPools.remove(uid);
		}
		//�ѵ�ǰ��websocket�����webSockets����
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
	//ת����Ϣ��Ŀ��
	public void transpond(Chat chat) {
		User targetUser = chat.getAdverse();
		MyWebSocket myWebSocket = webSockets.get(targetUser.getId());
		chat.setAdverse(user);
		chat.getMessage().setType("received");
		chat.getMessage().setRead(false);
		//��Ŀ���û�������ʱ������Ϣ���뷢�ͳأ��ȴ��û�����ʱ����
		if(null == myWebSocket) {
			List<Chat> sendPool = sendPools.get(targetUser.getId());
			if(null == sendPool) {
				sendPool = new ArrayList<>();
			}
			sendPool.add(chat);
			sendPools.put(targetUser.getId(), sendPool);
			//Ŀ���û������ߣ�ϵͳ�Զ��ظ�
			autoResponse(targetUser);
		}else sendObjectMessage(myWebSocket, chat);
	}
	
	public void onError(Session session,Throwable error) {
		System.out.println("��������");
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
		message.setBody("��ã��˿��Ҳ��������ϣ���������ԣ��������ߺ�ظ�");
		message.setRead(false);
		message.setTime(new Date().toGMTString());
		message.setType("received");
		chat.setMessage(message);
		sendObjectMessage(this, chat);
	}
}
