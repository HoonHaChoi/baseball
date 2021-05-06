package web.mj.baseballGameApi.domain.record;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecordRepository extends CrudRepository<Record, Long> {

    List<Record> findAllByInningGameId(Long gameId);
}
