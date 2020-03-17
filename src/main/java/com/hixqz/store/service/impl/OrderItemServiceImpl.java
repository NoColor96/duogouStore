package com.hixqz.store.service.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hixqz.store.mapper.OrderItemMapper;
import com.hixqz.store.mapper.ProductMapper;
import com.hixqz.store.pojo.OrderItem;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.User;
import com.hixqz.store.service.OrderItemService;
import com.hixqz.store.service.ProductService;
@Service
public class OrderItemServiceImpl implements OrderItemService {
	@Autowired
	OrderItemMapper orderItemMapper;
	@Autowired
	ProductService productService;
	@Autowired
	ProductMapper productMapper;
	@Override
	public void add(OrderItem orderItem) {
		// TODO Auto-generated method stub
		orderItemMapper.add(orderItem);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		orderItemMapper.delete(id);
	}

	@Override
	public void update(OrderItem orderItem) {
		// TODO Auto-generated method stub
		orderItemMapper.update(orderItem);
	}

	@Override
	public OrderItem get(int id) {
		// TODO Auto-generated method stub
		OrderItem orderItem = orderItemMapper.get(id);
		Product product = orderItem.getProduct();
		productService.setProductSingleImages(product);
		return orderItem;
	}

	@Override
	public List<OrderItem> listByUser(User user) {
		// TODO Auto-generated method stub
		List<OrderItem> orderItems = orderItemMapper.listByUser(user);
		for(OrderItem orderItem : orderItems) {
			Product product = orderItem.getProduct();
			productService.setProductSingleImages(product);
		}
		return orderItems;
	}

	@Override
	public String getCartNumber(User user) {
		// TODO Auto-generated method stub
		int number = orderItemMapper.getCartNumber(user);
		return String.valueOf(number);
	}

	@Override
	public void setOrder(ArrayList<OrderItem> orderItems, int oid) {
		// TODO Auto-generated method stub
		for(OrderItem orderItem : orderItems) {
			orderItem.setOid(oid);
			Product product = orderItem.getProduct();
			product.setStock(product.getStock()-orderItem.getNumber());
			productService.sysStock(product);
			orderItemMapper.addOrder(orderItem);
		}
	}

	@Override
	public Map<String, Object> getTotal(ArrayList<OrderItem> orderItems) {
		// TODO Auto-generated method stub
		DecimalFormat df = new DecimalFormat("#.00");//格式化total保留两位小数
		double total = 0;
		int totalNumber = 0;
		for(OrderItem orderItem : orderItems) {
			total += orderItem.getNumber()*orderItem.getProduct().getPromotePrice();
			totalNumber += orderItem.getNumber();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", df.format(total));
		map.put("totalNumber", totalNumber);
		return map;
	}
}
