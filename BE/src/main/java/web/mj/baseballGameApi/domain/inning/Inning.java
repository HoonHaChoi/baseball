package web.mj.baseballGameApi.domain.inning;

import org.springframework.data.annotation.Id;

public class Inning {

    @Id
    private Long id;

    private boolean isFirstBase;
    private boolean isSecondBase;
    private boolean isThirdBase;
    private boolean isHomeBase;

    private Integer strike;
    private Integer ball;
    private Integer out;

    private Integer gameId;

    public Inning() {

    }

    public Long getId() {
        return id;
    }


    public boolean isFirstBase() {
        return isFirstBase;
    }

    public boolean isSecondBase() {
        return isSecondBase;
    }

    public boolean isThirdBase() {
        return isThirdBase;
    }

    public boolean isHomeBase() {
        return isHomeBase;
    }

    public Integer getStrike() {
        return strike;
    }

    public Integer getBall() {
        return ball;
    }

    public Integer getOut() {
        return out;
    }

    public Integer getGameId() {
        return gameId;
    }

    public void setFirstBaseToFalse() {
        isFirstBase = false;
    }

    public void setSecondBaseToFalse() {
        isSecondBase = false;
    }

    public void setThirdBaseToFalse() {
        isThirdBase = false;
    }

    public void setFirstBaseToTrue() {
        isFirstBase = true;
    }

    public void setSecondBaseToTrue() {
        isSecondBase = true;
    }

    public void setThirdBaseToTrue() {
        isThirdBase = true;
    }

    public void setHomeBaseToFalse() {
        isHomeBase = false;
    }

    public void setHomeBaseToTrue() {
        isHomeBase = true;
    }

    public void increaseStrike() {
        strike++;
    }

    public void increaseBall() {
        ball++;
    }

    public void increaseOut() {
        out++;
    }

    public void initializeStrike(){
        strike = 0;
    }

    public void resetStrikeAndBall() {
        strike = 0;
        ball = 0;
    }

}
