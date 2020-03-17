package com.hixqz.store.interceptor;


import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.pojo.User;



public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String contextPath = session.getServletContext().getContextPath();
		String errorMsg = (String) session.getAttribute("errorMsg");
		//以下路径可以未登录访问
		String[] excepts = new String[] {
			"login",
			"register",
			"existUserName",
			"home",
			"product",
			"search",
			"category",
			"admin"
		};
		String uri = request.getRequestURI();
		uri = StringUtils.remove(uri, contextPath);
		
		uri = StringUtils.substringAfterLast(uri, "/");
		if(null != errorMsg && !uri.equals("admin")) {
			session.removeAttribute("errorMsg");
		}
		if(uri.length()==0) {
			response.sendRedirect("home");
			return true;
		}
		if(!Arrays.asList(excepts).contains(uri)) {
			User user = (User) session.getAttribute("user");
			if(null==user) {	
				response.sendRedirect("login");
				return false;
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
