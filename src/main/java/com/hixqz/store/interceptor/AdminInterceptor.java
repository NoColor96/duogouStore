package com.hixqz.store.interceptor;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.pojo.User;

public class AdminInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User adminUser = (User) session.getAttribute("adminUser");
		String contextPath = session.getServletContext().getContextPath();
		String uri = request.getRequestURI();
		String[] excepts =  new String[] {
				"/admin",
				"/admin/login"
		};
		if(Arrays.asList(excepts).contains(uri)) {
			if(null==adminUser)
				return true;
			else {
				response.sendRedirect("/admin/categorys");
				return false;
			}
		}
	
		if(null!=adminUser) {
			session.setAttribute("errorMsg", "");
			return true;
		}
		session.setAttribute("errorMsg", "«Îµ«¬ºπ‹¿Ì‘±’À∫≈");
		response.sendRedirect("/admin");
		return false;
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
