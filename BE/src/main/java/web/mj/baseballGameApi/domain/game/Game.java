package web.mj.baseballGameApi.domain.game;

import org.springframework.data.annotation.Id;
import web.mj.baseballGameApi.domain.team.Team;

import java.util.List;

public class Game {

    @Id
    private Long id;
    private Long selectedTeamId;
    private boolean isTop;
    private Integer inning;

    public Game() {
    }

    public Game(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public Long getSelectedTeamId() {
        return selectedTeamId;
    }

    public boolean isTop() {
        return isTop;
    }

    public Integer getInning() {
        return inning;
    }

    public void selectTeam(Long teamId) {
        selectedTeamId = teamId;
    }
}

