package web.mj.baseballGameApi.domain.team;

import org.springframework.data.annotation.Id;

public class Team {

    @Id
    private Long id;
    private String name;
    private boolean isOccupied;
    private boolean isHitting;
    private boolean isSelected;
    private Integer score;
    private Long gameId;

    private Integer nowBatter;

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

    public boolean isSelected() {
        return isSelected;
    }

    public Long getGameId() {
        return gameId;
    }

    public Integer getNowBatter() {
        return nowBatter;
    }

    public boolean occupy() {
        if (isOccupied) {
            return false;
        }

        return isOccupied = true;
    }

    public boolean select() {
        return isSelected = true;
    }

    @Override
    public String toString() {
        return "Team{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", isOccupied=" + isOccupied +
                ", isHitting=" + isHitting +
                ", isSelected=" + isSelected +
                ", score=" + score +
                ", gameId=" + gameId +
                ", nowBatter=" + nowBatter +
                '}';
    }
}
