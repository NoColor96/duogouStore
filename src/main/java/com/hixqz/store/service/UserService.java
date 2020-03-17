package com.hixqz.store.service;

import java.util.List;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.User;
public interface UserService {
	void add(User user);
	void delete(int id);
	void update(User user);
	User get(int id);
	List<User> list();
	List<User> list(Page page);
	User checkUser(User user);
	boolean existUserName(String userName);
	User getPureUserById(int id);
}
