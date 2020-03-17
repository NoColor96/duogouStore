package com.hixqz.store.interceptor;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.pojo.Category;
import com.hixqz.store.service.CategoryService;

public class OtherInterceptor implements HandlerInterceptor{
	@Autowired
	CategoryService categoryService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		return true;
	}
	//执行完控制器后进入视图之前
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String contextPath = session.getServletContext().getContextPath();
		String[] include = new String[] {
				"cart",
				"category",
				"confirmReceive",
				"home",
				"myOrder",
				"orderConfirmed",
				"payed",
				"product",
				"register",
				"registerSuccess",
				"review",
				"search"
		};
		String uri = request.getRequestURI();
		uri = StringUtils.remove(uri, contextPath);
		uri = StringUtils.substringAfterLast(uri, "/");
		if(Arrays.asList(include).contains(uri)) {
			List<Category> categories = categoryService.getRandomCategorys(4);
			request.setAttribute("randomCategorys", categories);
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
