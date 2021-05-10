package web.mj.baseballGameApi.domain.game;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Random;

public class Pitching {
    private Logger logger = LoggerFactory.getLogger(Pitching.class);

    private final Double battingAverage;
    private final Double strikeAverage;
    private final Double ballAverage;

    public Pitching() {
        this.battingAverage = 0.35;
        this.strikeAverage = 0.35;
        this.ballAverage = 0.3;
    }

    public Pitching(Double battingAverage, Double strikeAverage) {
        this.battingAverage = battingAverage;
        this.strikeAverage = 1 - battingAverage;
        this.ballAverage = 1 - strikeAverage;
    }

    public String result() {
        Random random = new Random();
        double result = random.nextDouble();

        logger.info("result {}: ", result);

        if (result <= battingAverage) {
            return "hit";
        }

        if (result > battingAverage && result <= strikeAverage + battingAverage) {
            return "strike";
        }

        return "ball";
    }
}
