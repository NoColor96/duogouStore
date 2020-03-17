package com.hixqz.store.service;

import java.util.List;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Order;
import com.hixqz.store.pojo.User;

public interface OrderService {
	void add(Order order);
	void delete(int id);
	void update(Order order);
	Order get(int id);
	List<Order> list();
	List<Order> list(Page page);
	List<Order> listByUser(User user);
	void updateStatus(Order order);
	String createOrderCode();
}
