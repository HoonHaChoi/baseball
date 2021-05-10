package web.mj.baseballGameApi.web;

import org.springframework.web.bind.annotation.*;
import web.mj.baseballGameApi.domain.chat.ChatRoom;
import web.mj.baseballGameApi.service.ChatService;

import java.util.List;

@RestController
@RequestMapping("/chat")
public class ChatController {

    private final ChatService chatService;

    public ChatController(ChatService chatService){
        this.chatService = chatService;
    }

    @PostMapping
    public ChatRoom createRoom(@RequestParam String name) {
        return chatService.createRoom(name);
    }

    @GetMapping
    public List<ChatRoom> findAllRoom() {
        return chatService.findAllRoom();
    }
}
