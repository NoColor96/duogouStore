package com.hixqz.store.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.mapper.PropertyMapper;
import com.hixqz.store.pojo.Property;
import com.hixqz.store.service.PropertyService;
@Service
public class PropertyServiceImpl implements PropertyService{
	@Autowired
	PropertyMapper propertyMapper;
	@Override
	public void add(Property property) {
		// TODO Auto-generated method stub
		propertyMapper.add(property);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		propertyMapper.delete(id);
	}

	@Override
	public void update(Property property) {
		// TODO Auto-generated method stub
		propertyMapper.update(property);
	}

	@Override
	public Property get(int id) {
		// TODO Auto-generated method stub
		return propertyMapper.get(id);
	}
	@Override
	public List<Property> list(int cid,Page page) {
		// TODO Auto-generated method stub
		if(null==page) return propertyMapper.list(cid);
		page.setTotal(getTotal(cid));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cid", cid);
		map.put("page", page);
		return propertyMapper.listByPage(map);
	}

	@Override
	public int getTotal(int cid) {
		// TODO Auto-generated method stub
		return propertyMapper.getTotal(cid);
	}

	@Override
	public void deleteByCid(int cid) {
		// TODO Auto-generated method stub
		propertyMapper.deleteByCid(cid);
	}

}
