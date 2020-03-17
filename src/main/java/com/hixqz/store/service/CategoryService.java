package com.hixqz.store.service;

import java.io.InputStream;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Category;

public interface CategoryService {
	void add(Category category,MultipartFile imageFile,String imageFolder);
	void delete(int id,String imageFolder);
	void update(Category category,MultipartFile imageFile,String imageFolder);
	Category get(int id);
	List<Category> list();
	//分页专用
	List<Category> listByPage(Page page);
	List<Category> getRandomCategorys(int size);
	//图片上传--已弃用
	void uploadImage(InputStream is,Category category,String folderPath);
	//分类底下是否有产品
	void hasChild(Category category);
	
	Category getPure(int cid);
	int getTotal();
}
