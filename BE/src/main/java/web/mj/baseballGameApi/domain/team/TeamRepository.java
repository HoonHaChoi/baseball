package web.mj.baseballGameApi.domain.team;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TeamRepository extends CrudRepository<Team, Long> {

    List<Team> findAllByGameId(Long gameId);

    Optional<Team> findByGameIdAndIsHittingTrue(Long gameId);

    Optional<Team> findByGameIdAndIsHittingFalse(Long gameId);
}
