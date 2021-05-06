package web.mj.baseballGameApi.domain.inning;

import org.springframework.data.annotation.Id;

public class Inning {

    @Id
    private Long id;

    private boolean isFirstBase;
    private boolean isSecondBase;
    private boolean isThirdBase;

    private Integer strike;
    private Integer ball;
    private Integer out;

    private Integer gameId;

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
}
