package com.hixqz.store.service;

import java.util.List;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Property;

public interface PropertyService {
	void add(Property property);
	void delete(int id);
	void deleteByCid(int cid);
	void update(Property property);
	Property get(int id);
	List<Property> list(int cid,Page page);
	int getTotal(int cid);
}
