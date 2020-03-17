package com.hixqz.store.pojo;

public class User {
	private int id;
	private String name;
	private String password;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAnonymousName() {
		if(name.length()==1)
			return "*";
		else if(name.length()==2)
			return name.substring(0, 1)+"*";
		else if(name.length()==3){
			return name.substring(0, 1)+"*"+name.substring(2,3);
		}else {
			return name.substring(0, 1)+"**"+name.substring(name.length()-1,name.length());
		}
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", password=" + password + "]";
	}
}
