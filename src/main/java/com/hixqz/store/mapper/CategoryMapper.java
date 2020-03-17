package com.hixqz.store.mapper;

import java.util.List;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Category;

public interface CategoryMapper {
	void add(Category category);
	void delete(int id);
	void update(Category category);
	Category get(int id);
	List<Category> list();
	List<Category> listPure();
	List<Category> listPure(Page page);
	//分类底下有多少产品
	int getChildCount(int cid);
	int getTotal();
	//取出纯净的category(不含products)
	Category getPure(int cid);
}
