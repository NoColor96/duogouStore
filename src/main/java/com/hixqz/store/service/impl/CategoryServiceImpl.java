package com.hixqz.store.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.Utils.RandomUtil;
import com.hixqz.store.mapper.CategoryMapper;
import com.hixqz.store.pojo.Category;
import com.hixqz.store.pojo.OrderItem;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.service.CategoryService;
import com.hixqz.store.service.OrderItemService;
import com.hixqz.store.service.ProductService;
@Service
public class CategoryServiceImpl implements CategoryService{
	@Autowired
	CategoryMapper categoryMapper;
	@Autowired
	ProductService productService;
	@Autowired
	OrderItemService orderItemService;
	@Override
	public void add(Category category,MultipartFile imageFile,String imageFolder) {
		// TODO Auto-generated method stub
		categoryMapper.add(category);
		//图片
		File file = new File(imageFolder,category.getId()+".jpg");
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
	public void delete(int id,String imageFolder) {
		// TODO Auto-generated method stub
		categoryMapper.delete(id);
		//删除服务器图片文件
		File file = new File(imageFolder,id+".jpg");
		file.delete();
	}

	@Override
	public void update(Category category,MultipartFile imageFile,String imageFolder) {
		// TODO Auto-generated method stub
		categoryMapper.update(category);
		File file = new File(imageFolder,category.getId()+".jpg");
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
	public Category get(int id) {
		// TODO Auto-generated method stub
		Category category = categoryMapper.get(id);
		List<Product> products = category.getProducts();
		for(Product product : products) {
			productService.setSaleCountAndReviewCount(product);
		}
		return category;
	}

	@Override
	public List<Category> list() {
		// TODO Auto-generated method stub
		return categoryMapper.list();
	}
	/**
	 * 获取随机分类
	 * size为数组长度
	 */
	@Override
	public List<Category> getRandomCategorys(int size) {
		// TODO Auto-generated method stub
		List<Category> randomCategorys = new ArrayList<Category>();
		List<Category> categories = categoryMapper.listPure();
		int[] randomArray = RandomUtil.RandomArray(size, 16);//最大值为17
		for(int i = 0;i < randomArray.length;i++) {
			randomCategorys.add(categories.get(randomArray[i]));
		}
		return randomCategorys;
	}

	@Override
	public List<Category> listByPage(Page page) {
		// TODO Auto-generated method stub
		page.setTotal(categoryMapper.getTotal());
		List<Category> categories = categoryMapper.listPure(page);
		for(Category category : categories) {
			hasChild(category);
		}
		return categories;
	}

	//分类底下是否有产品
	public void hasChild(Category category) {
		if(categoryMapper.getChildCount(category.getId())==0) 
			category.setHasChild(false);
		else {
			category.setHasChild(true);
		}
	}
	@Override
	public void uploadImage(InputStream is,Category category,String folderPath) {
		// TODO Auto-generated method stub
	/*	File folderImage = new File(folderPath);
		File file = new File(folderImage, category.getId()+".jpg");
		try {
			if(null!=is || is.available()!=-1) {
				FileOutputStream fos = new FileOutputStream(file);
				byte[] bs = new byte[1024*1024];
				int length = 0;
				while(-1 != (length = is.read(bs))) {
					fos.write(bs, 0, length);
				}
				fos.flush();
				fos.close();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}

	@Override
	public Category getPure(int cid) {
		// TODO Auto-generated method stub
		return categoryMapper.getPure(cid);
	}

	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return categoryMapper.getTotal();
	}

}
