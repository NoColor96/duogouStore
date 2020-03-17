package com.hixqz.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hixqz.store.mapper.PropertyValueMapper;
import com.hixqz.store.pojo.Property;
import com.hixqz.store.pojo.PropertyValue;
import com.hixqz.store.service.PropertyService;
import com.hixqz.store.service.PropertyValueService;
@Service
public class PropertyValueServiceImpl implements PropertyValueService{
	@Autowired
	PropertyValueMapper propertyValueMapper;
	@Autowired
	PropertyService propertyService;
	@Override
	public void add(PropertyValue propertyValue) {
		// TODO Auto-generated method stub
		propertyValueMapper.add(propertyValue);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		propertyValueMapper.delete(id);
	}

	@Override
	public void update(PropertyValue propertyValue) {
		// TODO Auto-generated method stub
		propertyValueMapper.update(propertyValue);
	}

	@Override
	public PropertyValue get(int id) {
		// TODO Auto-generated method stub
		return propertyValueMapper.get(id);
	}

	@Override
	public List<PropertyValue> list(int pid) {
		// TODO Auto-generated method stub
		return propertyValueMapper.list(pid);
	}
	//将属性值装配给属性
	@Override
	public List<Property> listFillProperty(int pid,int cid) {
		// TODO Auto-generated method stub
		List<PropertyValue> propertyValues = list(pid);
		List<Property> properties = propertyService.list(cid, null);
		if(propertyValues.size()==0) return properties;
		int i = 0;
		for(Property property : properties) {
			for(int j = 0;j < propertyValues.size();j++) {
				if(property.getId()==propertyValues.get(j).getProperty().getId()) {
					property.setPropertyValue(propertyValues.get(j));
					break;
				}
			}
			i++;
		}
		return properties;
	}

	@Override
	public void deleteByPid(int pid) {
		// TODO Auto-generated method stub
		propertyValueMapper.deleteByPid(pid);
	}

}
