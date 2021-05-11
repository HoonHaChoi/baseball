package web.mj.baseballGameApi.web.dto;

import org.springframework.data.annotation.Id;
import web.mj.baseballGameApi.domain.record.Record;

import java.util.ArrayList;
import java.util.List;

public class RecordDto {

    private final Long recordId;
    private final String name;
    private final String status;
    private final Integer numOfStrike;
    private final Integer numOfBall;

    private List<String> charactersOfPitchings;

    public RecordDto(Record record) {
        this.recordId = record.getId();
        this.name = record.getBatterName();
        this.status = record.getStatus();
        this.numOfStrike = record.getNumOfStrike();
        this.numOfBall = record.getNumOfBall();
        this.charactersOfPitchings = new ArrayList<>();
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

    public List<String> getCharactersOfPitchings() {
        return charactersOfPitchings;
    }

    public void setCharactersOfPitchings(List<String> charactersOfPitchings) {
        this.charactersOfPitchings = charactersOfPitchings;
    }

    public void addCharacter(String result){
        charactersOfPitchings.add(result);
    }
}
