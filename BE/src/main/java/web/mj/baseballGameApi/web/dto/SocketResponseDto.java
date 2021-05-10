package web.mj.baseballGameApi.web.dto;

public class SocketResponseDto {
    private String result;

    public SocketResponseDto(String result) {
        this.result = result;
    }

    public String getResult() {
        return result;
    }


    public void setResult(String result) {
        this.result = result;
    }
}
