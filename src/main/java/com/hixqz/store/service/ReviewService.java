package com.hixqz.store.service;

import java.util.List;

import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.Review;


public interface ReviewService {
	void add(Review review);
	void delete(int id);
	void update(Review review);
	Review get(int id);
	List<Review> list(int pid);
	int getCountByProduct(Product product);
}
