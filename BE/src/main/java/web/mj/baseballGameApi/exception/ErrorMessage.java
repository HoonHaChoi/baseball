package web.mj.baseballGameApi.exception;

public enum ErrorMessage {
    GAME_NOT_FOUND("해당 게임을 찾을 수 없습니다."),
    TEAM_NOT_FOUND("해당 팀을 찾을 수 없습니다.");

    private final String errorMessage;

    ErrorMessage(String errorMessage){
        this.errorMessage = errorMessage;
    }

    public String getErrorMessage(){
        return errorMessage;
    }
}
