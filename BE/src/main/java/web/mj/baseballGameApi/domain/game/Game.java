package web.mj.baseballGameApi.domain.game;

import org.springframework.data.annotation.Id;
public class Game {

    @Id
    private Long id;

    public Game() {
    }
    public Game(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}

