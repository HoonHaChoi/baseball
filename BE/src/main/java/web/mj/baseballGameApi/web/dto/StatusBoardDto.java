package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.inning.Inning;
import web.mj.baseballGameApi.domain.team.Team;

public class StatusBoardDto {
    private final boolean isFirstBase;
    private final boolean isSecondBase;
    private final boolean isThirdBase;
    private final Integer strike;
    private final Integer ball;
    private final Integer out;
    private final Integer inning;
    private final boolean isTop;
    private final boolean isHitting;
    private final PitcherDto pitcher;
    private final BatterDto batter;

    public StatusBoardDto(Game game, Team team, Inning inning, PitcherDto pitcher, BatterDto batter){
        this.isFirstBase = inning.isFirstBase();
        this.isSecondBase = inning.isSecondBase();
        this.isThirdBase = inning.isThirdBase();
        this.strike = inning.getStrike();
        this.ball = inning.getBall();
        this.out = inning.getOut();

        this.inning = game.getInning();
        this.isTop = game.isTop();

        this.isHitting = team.isHitting();
        this.pitcher = pitcher;
        this.batter = batter;
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

    public Integer getInning() {
        return inning;
    }

    public boolean isTop() {
        return isTop;
    }

    public boolean isHitting() {
        return isHitting;
    }

    public PitcherDto getPitcher() {
        return pitcher;
    }

    public BatterDto getBatter() {
        return batter;
    }
}
