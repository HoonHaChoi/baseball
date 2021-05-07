package web.mj.baseballGameApi.domain.team;

import org.springframework.data.annotation.Id;

public class Team {

    @Id
    private Long id;
    private String name;
    private boolean isOccupied;
    private Long gameId;

    public Team(){}

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean isOccupied() {
        return isOccupied;
    }

    public Long getGameId() {
        return gameId;
    }
}
