package web.mj.baseballGameApi.domain.game;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Random;

public class Pitching {
    private Logger logger = LoggerFactory.getLogger(Pitching.class);

    private final Double hittingAverage;
    private final Double strikeAverage;
    private final Double ballAverage;

    public Pitching() {
        this.hittingAverage = 0.35;
        this.strikeAverage = 0.35;
        this.ballAverage = 0.3;
    }

    public Pitching(Double hittingAverage, Double strikeAverage) {
        this.hittingAverage = hittingAverage;
        this.strikeAverage = 1 - hittingAverage;
        this.ballAverage = 1 - strikeAverage;
    }

    public String result() {
        Random random = new Random();
        double result = random.nextDouble();

        logger.info("result {}: ", result);

        if (result <= hittingAverage) {
            return "hit";
        }

        if (result > hittingAverage && result <= strikeAverage + hittingAverage) {
            return "strike";
        }

        return "ball";
    }
}
