package com.hixqz.store.comparator;

import java.util.Comparator;

import com.hixqz.store.pojo.Product;

public class ProductDateComparator implements Comparator<Product>{

	@Override
	public int compare(Product o1, Product o2) {
		// TODO Auto-generated method stub
		return o2.getCreateDate().compareTo(o1.getCreateDate());
	}

}
