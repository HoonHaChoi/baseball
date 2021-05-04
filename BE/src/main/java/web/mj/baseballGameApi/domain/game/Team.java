package web.mj.baseballGameApi.domain.game;

import org.springframework.data.annotation.Id;

public class Team {

    @Id
    private Long id;
    private String name;
    private boolean isOccupied;

    public Team(){}

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean isOccupied() {
        return isOccupied;
    }
}
