package web.mj.baseballGameApi.exception;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class OccupyFailedException extends RuntimeException {

    public OccupyFailedException(String message){
        super(message);
    }

    public OccupyFailedException(ErrorMessage errorMessage){
        super(errorMessage.getErrorMessage());
    }
}
