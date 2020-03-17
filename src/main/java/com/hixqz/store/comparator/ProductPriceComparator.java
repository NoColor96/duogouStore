package com.hixqz.store.comparator;

import java.util.Comparator;

import com.hixqz.store.pojo.Product;

public class ProductPriceComparator implements Comparator<Product>{

	@Override
	public int compare(Product o1, Product o2) {
		// TODO Auto-generated method stub
		if(o2.getPromotePrice()>o1.getPromotePrice())
			return -1;
		else return 1;
	}
	
}
