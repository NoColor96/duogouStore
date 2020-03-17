package com.hixqz.store.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hixqz.store.Utils.DateUtil;
import com.hixqz.store.mapper.ReviewMapper;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.Review;
import com.hixqz.store.service.ReviewService;
@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	ReviewMapper reviewMapper;
	@Override
	public void add(Review review) {
		// TODO Auto-generated method stub
		review.setCreateDate(DateUtil.DateTurnTimestamp(new Date()));
		reviewMapper.add(review);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		reviewMapper.delete(id);
	}

	@Override
	public void update(Review review) {
		// TODO Auto-generated method stub
		reviewMapper.update(review);
	}

	@Override
	public Review get(int id) {
		// TODO Auto-generated method stub
		return reviewMapper.get(id);
	}

	@Override
	public List<Review> list(int pid) {
		// TODO Auto-generated method stub
		return reviewMapper.list(pid);
	}

	@Override
	public int getCountByProduct(Product product) {
		// TODO Auto-generated method stub
		return reviewMapper.getCountByProduct(product);
	}

}
