package web.mj.baseballGameApi.domain.record;

import org.springframework.data.annotation.Id;

public class Record {

    @Id
    private Long id;

    private String name;
    private Integer numOfStrike;
    private Integer numOfBall;

    private String status;
    private Long inningId;
    private Long inningGameId;

    public Record() {
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Integer getNumOfStrike() {
        return numOfStrike;
    }

    public Integer getNumOfBall() {
        return numOfBall;
    }

    public String getStatus() {
        return status;
    }

    public Long getInningId() {
        return inningId;
    }

    public Long getInningGameId() {
        return inningGameId;
    }
}
