package com.hixqz.store.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.ProductImage;

public interface ProductImageService {
	void add(ProductImage productImage,MultipartFile imageFile,HttpServletRequest request);
	void delete(int id,HttpServletRequest request);
	void deleteByPid(int pid);
	void update(ProductImage productImage);
	ProductImage get(int id);
	List<ProductImage> list(int pid);
	Product listToProduct(int pid);
	List<ProductImage> getBySingle(Product product);
	
	List<ProductImage> getByDetail(Product product);
}
