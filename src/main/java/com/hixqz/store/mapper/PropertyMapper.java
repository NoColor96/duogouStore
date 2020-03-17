package com.hixqz.store.mapper;

import java.util.List;
import java.util.Map;

import com.hixqz.store.pojo.Property;


public interface PropertyMapper {
	void add(Property property);
	void delete(int id);
	void deleteByCid(int cid);
	void update(Property property);
	Property get(int id);
	List<Property> list(int cid);
	List<Property> listByPage(Map<String, Object> map);
	int getTotal(int cid);
}
