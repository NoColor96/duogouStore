package com.hixqz.store.chat;

import com.hixqz.store.pojo.User;

public class Chat{
	private User adverse;
	Message message;
	public User getAdverse() {
		return adverse;
	}
	public void setAdverse(User adverse) {
		this.adverse = adverse;
	}
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "Chat [adverse=" + adverse + ", message=" + message + "]";
	}
}
