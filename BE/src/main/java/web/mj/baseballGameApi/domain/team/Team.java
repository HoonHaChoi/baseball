package web.mj.baseballGameApi.domain.team;

import org.springframework.data.annotation.Id;

public class Team {

    @Id
    private Long id;
    private String name;
    private boolean isOccupied;
    private Long gameId;

    public Team() {
    }

    public Team(Long id, Long gameId) {
        this.id = id;
        this.gameId = gameId;
    }

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

    public void occupy() {
        if (!isOccupied) {
            isOccupied = true;
        }
    }
}
