package com.hixqz.store.mapper;

import java.util.List;

import com.hixqz.store.pojo.OrderItem;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.User;


public interface OrderItemMapper {
	void add(OrderItem orderItem);
	void delete(int id);
	void update(OrderItem orderItem);
	OrderItem get(int id);
	List<OrderItem> listByUser(User user);
	int getCartNumber(User user);
	void addOrder(OrderItem orderItem);
	Integer getSaleByProduct(Product product);
}
