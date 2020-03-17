package com.hixqz.store.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.User;
import com.hixqz.store.service.UserService;

@Controller
@RequestMapping("admin/users")
public class UserController extends BaseBackController{
	@Autowired
	UserService userService;
	@RequestMapping(value = "",method = RequestMethod.GET)
	public ModelAndView list(Page page) {
		ModelAndView mav = new ModelAndView();
		List<User> users = userService.list(page);
		mav.addObject("users",users);
		mav.setViewName("admin/listUser");
		return mav;
	}
}
