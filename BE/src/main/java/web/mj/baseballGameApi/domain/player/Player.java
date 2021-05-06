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
}
