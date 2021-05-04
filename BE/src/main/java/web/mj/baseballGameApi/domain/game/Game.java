package web.mj.baseballGameApi.domain.game;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Embedded;

public class Game {

    @Id
    private Long id;

//    @Embedded.Nullable
//    private Team homeTeam;
//
//    @Embedded.Nullable
//    private Team awayTeam;

    public Game() {
    }

    public Long getId() {
        return id;
    }


    //    public Team getHomeTeam() {
//        return homeTeam;
//    }
//
//    public Team getAwayTeam() {
//        return awayTeam;
//    }
}

