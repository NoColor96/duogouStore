package com.hixqz.store.chat;

import java.util.Base64;

import com.alibaba.fastjson.JSONObject;
public class ChatUtil {
	
	public static Chat jsonToChat(String json) {
		Chat chat = JSONObject.parseObject(json, Chat.class);
		return chat; 
	}
	//º”√‹
    public static String encrypt_Base64(String str) throws Exception {
        String result = Base64.getEncoder().encodeToString(str.getBytes("UTF-8"));
        return result;
    }
    //Ω‚√‹
    public static String decrypt_Base64(String str) throws Exception {
        byte[] asBytes = Base64.getDecoder().decode(str);
        String result = new String(asBytes,"UTF-8");
        return result;
    }
}