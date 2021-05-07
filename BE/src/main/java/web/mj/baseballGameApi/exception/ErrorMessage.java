package web.mj.baseballGameApi.exception;

public enum ErrorMessage {
    GAME_NOT_FOUND("해당 게임을 찾을 수 없습니다."),
    TEAM_NOT_FOUND("해당 팀을 찾을 수 없습니다."),
    OCCUPY_FAILED("해당 팀은 이미 선점되었습니다.");

    private final String message;

    ErrorMessage(String message){
        this.message = message;
    }

    public String getErrorMessage(){
        return message;
    }
}
