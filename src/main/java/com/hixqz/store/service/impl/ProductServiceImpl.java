package com.hixqz.store.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.comparator.ProductAllComparator;
import com.hixqz.store.comparator.ProductDateComparator;
import com.hixqz.store.comparator.ProductHeatComparator;
import com.hixqz.store.comparator.ProductPriceComparator;
import com.hixqz.store.comparator.ProductSaleCountComparator;
import com.hixqz.store.mapper.OrderItemMapper;
import com.hixqz.store.mapper.ProductMapper;
import com.hixqz.store.pojo.Category;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.ProductImage;
import com.hixqz.store.service.ProductImageService;
import com.hixqz.store.service.ProductService;
import com.hixqz.store.service.ReviewService;
@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductMapper productMapper;
	@Autowired
	ProductImageService productImageService;
	@Autowired
	OrderItemMapper orderItemMapper;
	@Autowired
	ReviewService reviewService;
	@Override
	public void add(Product product) {
		// TODO Auto-generated method stub
		productMapper.add(product);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		productMapper.delete(id);
	}

	@Override
	public void update(Product product) {
		// TODO Auto-generated method stub
		productMapper.update(product);
	}

	@Override
	public Product get(int id) {
		// TODO Auto-generated method stub
		Product product = productMapper.get(id);
		setSaleCountAndReviewCount(product);
		return product;
	}

	@Override
	public List<Product> list() {
		// TODO Auto-generated method stub
		return productMapper.list();
	}

	@Override
	public void fillByRow(List<Category> categories) {
		// TODO Auto-generated method stub
		int productNumberEachRow = 8;
		for(Category category : categories) {
			List<Product> products= category.getProducts();
			List<List<Product>> productsByRow = new ArrayList<List<Product>>();
			for(int i = 0;i < products.size();i+=productNumberEachRow) {
				int size = i + productNumberEachRow;
				size = size > products.size()?products.size():size;
				List<Product> productsByEachRow = products.subList(i, size);
				productsByRow.add(productsByEachRow);
			}
			category.setProductsByRow(productsByRow);
		}
	}

	@Override
	public void setProductSingleImages(Product product) {
		// TODO Auto-generated method stub
		List<ProductImage> productImages = productImageService.getBySingle(product);
		if(productImages.size()==0) return;
		product.setProductSingleImages(productImages);
	}

	@Override
	public void setProductDetailImages(Product product) {
		// TODO Auto-generated method stub
		List<ProductImage> productImages = productImageService.getByDetail(product);
		product.setProductDetailImages(productImages);
	}

	@Override
	public void setSaleCountAndReviewCount(Product product) {
		// TODO Auto-generated method stub
		Integer saleCount = orderItemMapper.getSaleByProduct(product);
		Integer reviewCount = reviewService.getCountByProduct(product);
		saleCount = saleCount==null?0:saleCount;
		reviewCount = reviewCount==null?0:reviewCount;
		product.setSaleCount(saleCount);
		product.setReviewCount(reviewCount);
	}

	@Override
	public List<Product> search(String name) {
		// TODO Auto-generated method stub
		List<Product> products = productMapper.search(name);
		for(Product product : products) {
			setProductSingleImages(product);
			setSaleCountAndReviewCount(product);
		}
		return products;
	}

	@Override
	public void sysStock(Product product) {
		// TODO Auto-generated method stub
		productMapper.sysStock(product);
	}

	@Override
	public void sort(List<Product> products,String sort) {
		// TODO Auto-generated method stub
		switch (sort) {
		case "all":
			Collections.sort(products, new ProductAllComparator());
			break;
		case "heat":
			Collections.sort(products,new ProductHeatComparator());
			break;
		case "date":
			Collections.sort(products,new ProductDateComparator());
			break;
		case "saleCount":
			Collections.sort(products,new ProductSaleCountComparator());
			break;
		case "price":
			Collections.sort(products,new ProductPriceComparator());
			break;
		default:
			break;
		}
	}

	@Override
	public List<Product> listByPage(int cid, Page page) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cid", cid);
		map.put("page", page);
		page.setTotal(productMapper.getTotal(cid));
		List<Product> products = productMapper.list(map);
		for(Product product : products) {
			setProductSingleImages(product);
		}
		return products;
	}

	@Override
	public int getTotal(int cid) {
		// TODO Auto-generated method stub
		return productMapper.getTotal(cid);
	}

}
