package com.hixqz.store.chat;

import java.util.Date;

public class Message {
	private String body;
	private String time;
	private String type;
	private boolean read;
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public boolean isRead() {
		return read;
	}
	public void setRead(boolean read) {
		this.read = read;
	}
	@Override
	public String toString() {
		return "Message [body=" + body + ", time=" + time + ", type=" + type + ", read=" + read + "]";
	}
	
}
