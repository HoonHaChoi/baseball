package web.mj.baseballGameApi.domain.team;

import org.springframework.data.annotation.Id;

public class Team {

    @Id
    private Long id;
    private String name;
    private boolean isOccupied;
    private boolean isHitting;
    private Integer score;
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

    public boolean isHitting() {
        return isHitting;
    }

    public Integer getScore() {
        return score;
    }

    public Long getGameId() {
        return gameId;
    }

    public boolean occupy() {
        if (isOccupied) {
            return false;
        }

        return isOccupied = true;
    }
}
