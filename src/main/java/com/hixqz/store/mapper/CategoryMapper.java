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
	//��������ж��ٲ�Ʒ
	int getChildCount(int cid);
	int getTotal();
	//ȡ��������category(����products)
	Category getPure(int cid);
}
