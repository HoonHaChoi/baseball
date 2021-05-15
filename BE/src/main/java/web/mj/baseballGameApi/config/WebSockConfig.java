package web.mj.baseballGameApi.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import web.mj.baseballGameApi.service.GameService;

@Configuration
@EnableWebSocket
public class WebSockConfig implements WebSocketConfigurer {
    private Logger logger = LoggerFactory.getLogger(GameService.class);

    private final WebSocketHandler webSocketHandler;

    public WebSockConfig(WebSocketHandler webSocketHandler) {
        this.webSocketHandler = webSocketHandler;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(webSocketHandler, "/ws/join").setAllowedOrigins("*");
        logger.info("web socket connected");
    }
}
