package web.mj.baseballGameApi.domain.game;

import org.springframework.data.annotation.Id;
import web.mj.baseballGameApi.domain.team.Team;

import java.util.List;

public class Game {

    @Id
    private Long id;


    public Game() {
    }

    public Long getId() {
        return id;
    }


}

