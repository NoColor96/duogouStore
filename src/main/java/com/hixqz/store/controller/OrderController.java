package com.hixqz.store.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Order;
import com.hixqz.store.service.OrderService;

@Controller
@RequestMapping("admin/orders")
public class OrderController extends BaseBackController{
	@Autowired
	OrderService orderService;
	@RequestMapping(value = "",method = RequestMethod.GET)
	public ModelAndView list(Page page) {
		ModelAndView mav = new ModelAndView();
		List<Order> orders = orderService.list(page);
		mav.addObject("orders", orders);
		mav.setViewName("admin/listOrder");
		return mav;
	}
	//更新订单，目前只有发货操作
	@ResponseBody
	@RequestMapping(value = "{id}",method = RequestMethod.PUT)
	public String update(@PathVariable int id) {
		Order order = new Order();
		order.setId(id);
		order.setStatus("waitConfirm");//待确认收货，表示已发货
		orderService.updateStatus(order);
		return "success";
	}
}
