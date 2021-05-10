package web.mj.baseballGameApi.web.dto;


import web.mj.baseballGameApi.domain.game.Pitching;

public class SocketResponseDto {
    private String result;

    public SocketResponseDto(String result){
        this.result = result;
    }
    public SocketResponseDto(Pitching pitching) {
        this.result = pitching.getResult();
    }

    public String getResult() {
        return result;
    }
}
