package web.mj.baseballGameApi.domain.team;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import web.mj.baseballGameApi.domain.game.Game;

import java.util.List;

@Repository
public interface TeamRepository extends CrudRepository<Team, Long> {

    List<Team> findAllByGameId(Long gameId);
}
