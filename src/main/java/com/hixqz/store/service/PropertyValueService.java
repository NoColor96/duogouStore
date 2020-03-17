package com.hixqz.store.service;

import java.util.List;

import com.hixqz.store.pojo.Property;
import com.hixqz.store.pojo.PropertyValue;

public interface PropertyValueService {
	void add(PropertyValue propertyValue);
	void delete(int id);
	void deleteByPid(int pid);
	void update(PropertyValue propertyValue);
	PropertyValue get(int id);
	List<PropertyValue> list(int pid);
	List<Property> listFillProperty(int pid,int cid);
}
