package com.hixqz.store.mapper;

import java.util.List;

import com.hixqz.store.pojo.PropertyValue;


public interface PropertyValueMapper {
	void add(PropertyValue propertyValue);
	void delete(int id);
	void deleteByPid(int pid);
	void update(PropertyValue propertyValue);
	PropertyValue get(int id);
	List<PropertyValue> list(int pid);
}
