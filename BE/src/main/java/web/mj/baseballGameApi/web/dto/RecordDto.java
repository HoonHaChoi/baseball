package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.record.Record;

import java.util.ArrayList;
import java.util.List;

public class RecordDto {

    private final Long recordId;
    private final String name;
    private final String status;
    private final Integer numOfStrike;
    private final Integer numOfBall;

    private final String charactersOfPitchings;

    public RecordDto(Record record) {
        this.recordId = record.getId();
        this.name = record.getBatterName();
        this.status = record.getStatus();
        this.numOfStrike = record.getNumOfStrike();
        this.numOfBall = record.getNumOfBall();
        this.charactersOfPitchings = record.getResultOfCharacters();
    }

    public Long getRecordId() {
        return recordId;
    }

    public String getName() {
        return name;
    }

    public String getStatus() {
        return status;
    }

    public Integer getNumOfStrike() {
        return numOfStrike;
    }

    public Integer getNumOfBall() {
        return numOfBall;
    }

    public String getCharactersOfPitchings() {
        return charactersOfPitchings;
    }

}
