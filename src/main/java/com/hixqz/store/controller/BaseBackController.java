package com.hixqz.store.controller;

import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hixqz.store.chat.ChatUtil;
import com.hixqz.store.pojo.User;
@Controller
public class BaseBackController {
	//上传文件的处理--未使用
	public InputStream parseUpload(HttpServletRequest request,Map<String, String> params) {
		InputStream is = null;
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			factory.setSizeThreshold(1024*1024);
			List<FileItem> list = upload.parseRequest(request);
			Iterator<FileItem> it = list.iterator();
			while(it.hasNext()) {
				FileItem item = it.next();
				if(!item.isFormField()) {
					is = item.getInputStream();
				}else {
					String paramName = item.getFieldName();
					String paramValue = item.getString();
					paramValue = new String(paramValue.getBytes("ISO-8859-1"),"UTF-8");
					params.put(paramName,paramValue);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return is;
	}
	@RequestMapping("admin")
	public String adminForwoard() {
		return "admin/adminLogin";
	}
	@RequestMapping(value = "admin/login",method = RequestMethod.POST)
	public String login(User adminUser,HttpSession session) {
		if(adminUser.getName().equals("admin")&&adminUser.getPassword().equals("123456")) {
			session.setAttribute("adminUser", adminUser);
			return "redirect:/admin/categorys";
		}else {
			session.setAttribute("errorMsg", "用户名或密码错误");
			return "redirect:/admin";
		}
	}
	@RequestMapping(value = "admin/logout",method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("adminUser");
		return "redirect:/admin";
	}
}
