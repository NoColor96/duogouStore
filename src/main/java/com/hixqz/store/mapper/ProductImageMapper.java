package com.hixqz.store.mapper;

import java.util.List;
import java.util.Map;

import com.hixqz.store.pojo.ProductImage;


public interface ProductImageMapper {
	void add(ProductImage productImage);
	void delete(int id);
	void deleteByPid(int pid);
	void update(ProductImage productImage);
	ProductImage get(int id);
	List<ProductImage> list(int pid);
	
	List<ProductImage> getByCondition(Map<String, Object> map);
	/*List<ProductImage> listBySingle(int pid);*/
}
