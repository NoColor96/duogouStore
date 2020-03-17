package com.hixqz.store.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hixqz.store.mapper.ProductImageMapper;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.ProductImage;
import com.hixqz.store.service.ProductImageService;
import com.hixqz.store.service.ProductService;
@Service
public class ProductImageServiceImpl implements ProductImageService{
	@Autowired
	ProductImageMapper productImageMapper;
	@Autowired
	ProductService productService;
	@Override
	public void add(ProductImage productImage,MultipartFile imageFile,HttpServletRequest request) {
		// TODO Auto-generated method stub
		productImageMapper.add(productImage);
		String imageFolder;
		if(productImage.getType()==ProductImage.TYPE_SINGLE)
			imageFolder = request.getServletContext().getRealPath("img/productSingle");
		else
			imageFolder = request.getServletContext().getRealPath("img/productDetail");
		File file = new File(imageFolder,productImage.getId()+".jpg");
		file.getParentFile().mkdirs();
		try {
			imageFile.transferTo(file);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete(int id,HttpServletRequest request) {
		// TODO Auto-generated method stub
		ProductImage productImage = get(id);
		File file = null;
		if(productImage.getType().equals(ProductImage.TYPE_SINGLE)){
			file = new File(request.getServletContext().getRealPath("img/productSingle"),id+".jpg");
		}else if(productImage.getType().equals(ProductImage.TYPE_DETAIL)){
			file = new File(request.getServletContext().getRealPath("img/productDetail"),id+".jpg");
		}
		file.delete();
		productImageMapper.delete(id);
	}

	@Override
	public void update(ProductImage productImage) {
		// TODO Auto-generated method stub
		productImageMapper.update(productImage);
	}

	@Override
	public ProductImage get(int id) {
		// TODO Auto-generated method stub
		return productImageMapper.get(id);
	}

	@Override
	public List<ProductImage> list(int pid) {
		// TODO Auto-generated method stub
		return productImageMapper.list(pid);
	}
	
	@Override
	public List<ProductImage> getBySingle(Product product) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap();
		map.put("pid", product.getId());
		map.put("type", ProductImage.TYPE_SINGLE);
		return productImageMapper.getByCondition(map);
	}

	@Override
	public List<ProductImage> getByDetail(Product product) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap();
		map.put("pid", product.getId());
		map.put("type", ProductImage.TYPE_DETAIL);
		return productImageMapper.getByCondition(map);
	}

	@Override
	public void deleteByPid(int pid) {
		// TODO Auto-generated method stub
		productImageMapper.deleteByPid(pid);
		
	}

	@Override
	public Product listToProduct(int pid) {
		// TODO Auto-generated method stub
		Product product = productService.get(pid);
		product.setProductSingleImages(getBySingle(product));
		product.setProductDetailImages(getByDetail(product));
		return product;
	}


}
