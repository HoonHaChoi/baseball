package web.mj.baseballGameApi.domain.record;

import org.springframework.data.annotation.Id;

public class Record {

    @Id
    private Long id;

    private String batterName;
    private Integer numOfStrike;
    private Integer numOfBall;

    private String status;
    private Long inningId;
    private Long inningGameId;

    public Record(){

    }

    public Record(String name, Record previous) {
        this.batterName = name;
        this.numOfStrike = 0;
        this.numOfBall = 0;
        this.status = "doing";
        this.inningId = previous.inningId;
        this.inningGameId = previous.getInningGameId();
    }

    public Long getId() {
        return id;
    }

    public String getBatterName() {
        return batterName;
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

    public void setStatus(String status) {
        this.status = status;
    }

    public void setNumOfBall(Integer numOfBall) {
        this.numOfBall = numOfBall;
    }

    public void setNumOfStrike(Integer numOfStrike) {
        this.numOfStrike = numOfStrike;
    }

    public void setBatterName(String batterName) {
        this.batterName = batterName;
    }

    public void increaseBall() {
        this.numOfBall++;
    }

    public void increaseStrike() {
        this.numOfStrike++;
    }

    public void updateName(String name) {
        this.batterName = name;
    }

}


