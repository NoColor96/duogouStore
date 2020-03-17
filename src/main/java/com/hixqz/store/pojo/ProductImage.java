package com.hixqz.store.pojo;

public class ProductImage {
	private int id;
	private Product product;
	private String type;
	private int pid;
	public static final String TYPE_SINGLE = "type_single";
	public static final String TYPE_DETAIL = "type_detail"; 
	
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		if(type.equals("single"))
			type = TYPE_SINGLE;
		else if(type.equals("detail"))
			type = TYPE_DETAIL;
		this.type = type;
	}
}
