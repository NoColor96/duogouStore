package com.hixqz.store.service;

import java.util.List;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Category;
import com.hixqz.store.pojo.Product;


public interface ProductService {
	void add(Product product);
	void delete(int id);
	void update(Product product);
	Product get(int id);
	List<Product> list();
	List<Product> search(String name);
	
	List<Product> listByPage(int cid,Page page);
	
	void fillByRow(List<Category> categories);
	
	void setProductSingleImages(Product product);
	void setProductDetailImages(Product product);
	
	void setSaleCountAndReviewCount(Product product);
	void sysStock(Product product);
	void sort(List<Product> products,String sort);
	int getTotal(int cid);
}
