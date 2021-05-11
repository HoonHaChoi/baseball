package web.mj.baseballGameApi.domain.game;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Random;

public class Pitching {
    private Logger logger = LoggerFactory.getLogger(Pitching.class);

    private final Double hittingAverage;
    private final Double strikeAverage;
    private final Double ballAverage;
    private String result = "strike";

    public Pitching() {
        this.hittingAverage = 0.2;
        this.strikeAverage = 0.35;
        this.ballAverage = 0.45;
        this.result = calculateResult();
    }

    public Pitching(Double hittingAverage, Double strikeAverage) {
        this.hittingAverage = hittingAverage;
        this.strikeAverage = 1 - hittingAverage;
        this.ballAverage = 1 - strikeAverage;
        this.result = calculateResult();
    }

    public String calculateResult() {
        Random random = new Random();
        double result = random.nextDouble();

        logger.info("result {}: ", result);
        if (result <= hittingAverage) {
            return this.result = "hit";
        }

        if (result > hittingAverage && result <= strikeAverage + hittingAverage) {
            return this.result = "strike";
        }

        return this.result = "ball";
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
