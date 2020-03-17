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
	//��ҳר��
	List<Category> listByPage(Page page);
	List<Category> getRandomCategorys(int size);
	//ͼƬ�ϴ�--������
	void uploadImage(InputStream is,Category category,String folderPath);
	//��������Ƿ��в�Ʒ
	void hasChild(Category category);
	
	Category getPure(int cid);
	int getTotal();
}
