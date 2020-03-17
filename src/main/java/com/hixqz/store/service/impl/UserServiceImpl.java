package com.hixqz.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.mapper.UserMapper;
import com.hixqz.store.pojo.User;
import com.hixqz.store.service.UserService;
@Service
public class UserServiceImpl implements UserService{
	@Autowired
	UserMapper userMapper;
	public void add(User user) {
		// TODO Auto-generated method stub
		userMapper.add(user);
	}

	public void delete(int id) {
		// TODO Auto-generated method stub
		userMapper.delete(id);
	}

	public void update(User user) {
		// TODO Auto-generated method stub
		userMapper.update(user);
	}

	public User get(int id) {
		// TODO Auto-generated method stub
		return userMapper.get(id);
	}

	public List<User> list() {
		// TODO Auto-generated method stub
		return userMapper.list();
	}

	@Override
	public User checkUser(User user) {
		// TODO Auto-generated method stub
		return userMapper.checkUser(user);
	}

	@Override
	public boolean existUserName(String userName) {
		// TODO Auto-generated method stub
		if(userMapper.existUserName(userName)>0) return true;
		return false;
	}

	@Override
	public List<User> list(Page page) {
		// TODO Auto-generated method stub
		page.setTotal(userMapper.getTotal());
		return userMapper.list(page);
	}

	@Override
	public User getPureUserById(int id) {
		// TODO Auto-generated method stub
		return userMapper.getPureUserById(id);
	}

}
