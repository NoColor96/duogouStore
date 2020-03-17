package com.hixqz.store.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.hixqz.store.pojo.OrderItem;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.User;

public interface OrderItemService {
	void add(OrderItem orderItem);
	void delete(int id);
	void update(OrderItem orderItem);
	OrderItem get(int id);
	List<OrderItem> listByUser(User user);
	String getCartNumber(User user);
	
	void setOrder(ArrayList<OrderItem> orderItems,int oid);
	Map<String, Object> getTotal(ArrayList<OrderItem> orderItems);
}
