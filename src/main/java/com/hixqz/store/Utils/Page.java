package com.hixqz.store.Utils;

public class Page {
	private int start = 0;
	private int count = 5;
	private int last;
	private int total;
	private boolean hasPreviouse;
	private boolean hasNext;
	private int totalPage = 0;
	private String param = "&i=1";
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getLast() {
		if(total%count==0) {
			last = total - count;
		}else {
			last = total - total%count;
		} 
		return last;
	}
	public void setLast(int last) {
		this.last = last;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public boolean isHasPreviouse() {
		if(start-count>=0)
			hasPreviouse = true;
		else
			hasPreviouse = false;
		return hasPreviouse;
	}
	public void setHasPreviouse(boolean hasPreviouse) {
		this.hasPreviouse = hasPreviouse;
	}
	public boolean isHasNext() {
		if(start+count<=getLast())
			hasNext = true;
		else
			hasNext = false;
		return  hasNext;
	}
	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}
	public int getTotalPage() {
		if(total%count==0) totalPage = total/count;
		else totalPage = total/count+1;
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public String toString() {
		return "[start="+start+",count="+count+",last="+getLast()+",totalPage="+getTotalPage()+"]";
	}
}
