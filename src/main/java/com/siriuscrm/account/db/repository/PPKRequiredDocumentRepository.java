package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.PPKRequiredDocumentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.List;

public interface PPKRequiredDocumentRepository extends JpaRepository<PPKRequiredDocumentEntity, Long> {

    @Query(value = "INSERT INTO ppk_required_documents (ppk_id, title, status_id) " +
            "  SELECT :ppkId, title, :initStatus " +
            "  FROM dictionaries WHERE parent_id =:dictionaryId RETURNING id", nativeQuery = true)
    List<Long> copyRequiredDocuments(@Param("ppkId") Long ppkId, @Param("dictionaryId") Long dictionaryId, @Param("initStatus") Long initStatus);

    @Transactional
    void deleteByPpkId(Long ppkId);

    @Transactional
    List<PPKRequiredDocumentEntity> findByPpkIdOrderByTitle(Long ppkId);
}
