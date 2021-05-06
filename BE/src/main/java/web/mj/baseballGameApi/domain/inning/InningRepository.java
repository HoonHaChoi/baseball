package web.mj.baseballGameApi.domain.inning;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import web.mj.baseballGameApi.domain.team.Team;

import java.util.List;
import java.util.Optional;

@Repository
public interface InningRepository extends CrudRepository<Inning, Long> {

    List<Inning> findAllByGameId(Long gameId);
}
