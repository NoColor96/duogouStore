package com.hixqz.store.mapper;

import java.util.List;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.User;

public interface UserMapper {
	void add(User user);
	void delete(int id);
	void update(User user);
	User get(int id);
	List<User> list();
	List<User> list(Page page);
	int getTotal();
	User checkUser(User user);
	int existUserName(String userName);
	User getPureUserById(int id);
}
