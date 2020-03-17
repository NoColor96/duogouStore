package com.hixqz.store.chat;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@Configuration
public class MyWebSocketConfig {

	@Bean
	public ServerEndpointExporter confServerEndpointExporter() {
		return new ServerEndpointExporter();
	}

}
