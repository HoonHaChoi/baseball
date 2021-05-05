package web.mj.baseballGameApi.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class EntityNotFoundException extends RuntimeException {

    private String errorMessage;

    public EntityNotFoundException(String errorMessage) {
        super(errorMessage);
    }

    public EntityNotFoundException(ErrorMessage errorMessage) {
        super(errorMessage.getErrorMessage());
    }
}
