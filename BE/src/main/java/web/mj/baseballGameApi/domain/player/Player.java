package web.mj.baseballGameApi.domain.player;

import org.springframework.data.annotation.Id;

public class Player {

    @Id
    private Long id;

    private String name;
    private Integer numOfThrowing;
    private Integer numOfHitting;
    private Integer numOfBatting;
    private Integer numOfOut;
    private Integer numOfStrike;
    private Integer numOfBall;
    private String imageUrl;

    private String position;
    private Long teamId;
    private Long teamGameId;

    public Player() {
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Integer getNumOfThrowing() {
        return numOfThrowing;
    }

    public Integer getNumOfHitting() {
        return numOfHitting;
    }

    public Integer getNumOfBatting() {
        return numOfBatting;
    }

    public Integer getNumOfOut() {
        return numOfOut;
    }

    public Integer getNumOfStrike() {
        return numOfStrike;
    }

    public Integer getNumOfBall() {
        return numOfBall;
    }

    public String getPosition() {
        return position;
    }

    public Long getTeamId() {
        return teamId;
    }

    public Long getTeamGameId() {
        return teamGameId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void increaseThrowing() {
        this.numOfThrowing++;
    }

    public void increaseStrike() {
        this.numOfStrike++;
    }

    public void increaseBall() {
        this.numOfBall++;
    }

    public void increaseBatting() {
        this.numOfBatting++;
    }

    public void increaseHitting() {
        this.numOfHitting++;
    }

    public void increaseOut() {
        this.numOfOut++;
    }


    @Override
    public String toString() {
        return "Player{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", numOfThrowing=" + numOfThrowing +
                ", numOfHitting=" + numOfHitting +
                ", numOfBatting=" + numOfBatting +
                ", numOfOut=" + numOfOut +
                ", numOfStrike=" + numOfStrike +
                ", numOfBall=" + numOfBall +
                ", position='" + position + '\'' +
                ", teamId=" + teamId +
                ", teamGameId=" + teamGameId +
                '}';
    }
}
