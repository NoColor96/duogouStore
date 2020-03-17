package com.hixqz.store.mapper;

import java.util.List;
import java.util.Map;

import com.hixqz.store.pojo.Product;

public interface ProductMapper {
	void add(Product product);
	void delete(int id);
	void update(Product product);
	Product get(int id);
	List<Product> list();
	List<Product> search(String name);
	List<Product> list(Map<String, Object> map);
	void sysStock(Product product);
	int getTotal(int cid);
}
