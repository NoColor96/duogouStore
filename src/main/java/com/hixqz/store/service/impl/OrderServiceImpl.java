package com.hixqz.store.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hixqz.store.Utils.DateUtil;
import com.hixqz.store.Utils.Page;
import com.hixqz.store.mapper.OrderMapper;
import com.hixqz.store.pojo.Order;
import com.hixqz.store.pojo.OrderItem;
import com.hixqz.store.pojo.User;
import com.hixqz.store.service.OrderItemService;
import com.hixqz.store.service.OrderService;
import com.hixqz.store.service.ProductService;
@Service
public class OrderServiceImpl implements OrderService{
	@Autowired
	OrderMapper orderMapper;
	@Autowired
	OrderItemService orderItemService;
	@Autowired
	ProductService productService;
	@Override
	public void add(Order order) {
		// TODO Auto-generated method stub
		orderMapper.add(order);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		orderMapper.delete(id);
	}

	@Override
	public void update(Order order) {
		// TODO Auto-generated method stub
		orderMapper.update(order);
	}

	@Override
	public Order get(int id) {
		// TODO Auto-generated method stub
		Order order = orderMapper.get(id);
		order.setTotal((String)orderItemService.getTotal(order.getOrderItems()).get("total"));
		ArrayList<OrderItem> orderItems = order.getOrderItems();
		for(OrderItem orderItem : orderItems) {
			productService.setSaleCountAndReviewCount(orderItem.getProduct());
		}
		return order;
	}

	@Override
	public List<Order> list() {
		// TODO Auto-generated method stub
		return orderMapper.list();
	}
	
	@Override
	public List<Order> listByUser(User user) {
		// TODO Auto-generated method stub
		List<Order> orders = orderMapper.listByUser(user);
		for(Order order : orders){
			ArrayList<OrderItem> orderItems = order.getOrderItems();
			String total = (String) orderItemService.getTotal(orderItems).get("total");
			order.setTotal(total);
		}
		Collections.reverse(orders);
		return orders;
	}
	//生成随机订单号
	@Override
	public String createOrderCode() {
		// TODO Auto-generated method stub
		SimpleDateFormat sf = new SimpleDateFormat("YYYYMMddHHmmssS");
		Random random = new Random();
		int rd = random.nextInt(10000);
		rd = rd < 1000?rd+1000:rd;
		String orderCode = sf.format(new Date())+rd;
		return orderCode;
	}
	//更新订单状态
	@Override
	public void updateStatus(Order order) {
		// TODO Auto-generated method stub
		switch(order.getStatus()) {
			case "waitDelivery":
				order.setPayDate(DateUtil.DateTurnTimestamp(new Date()));
			case "waitConfirm":
				order.setDeliveryDate(DateUtil.DateTurnTimestamp(new Date()));
			case "waitReview":
				order.setConfirmDate(DateUtil.DateTurnTimestamp(new Date()));
			case "delete":break;
			case "finish":break;
		}
		orderMapper.updateStatus(order);
	}

	@Override
	public List<Order> list(Page page) {
		// TODO Auto-generated method stub
		List<Order> orders = orderMapper.list(page);
		page.setTotal(orderMapper.getTotal());
		//System.out.println(orders.get(4).getOrderItems().get(0).getProduct().getName());
		for(Order order : orders){
			if(order==null) continue;
			ArrayList<OrderItem> orderItems = order.getOrderItems();
			Map<String, Object> map = orderItemService.getTotal(orderItems);
			order.setTotal((String)map.get("total"));
			order.setTotalNumber((int)map.get("totalNumber"));
		}
		Collections.reverse(orders);
		return orders;
	}

	@Override
	public Order getReceiverByUser(User user) {
		// TODO Auto-generated method stub
		return orderMapper.getReceiverByUser(user);
	}
}
