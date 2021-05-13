package web.mj.baseballGameApi.domain.player;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PlayerRepository extends CrudRepository<Player, Long> {
    Optional<Player> findByPositionAndTeamIdAndTeamGameId(String position, Long teamId, Long gameId);
    List<Player> findALLByPositionAndTeamId(String position, Long teamId);
    List<Player> findAllByTeamId(Long teamId);

    Optional<Player> findByPositionAndTeamIdAndIsNowOnTrue(String position, Long teamId);
}
