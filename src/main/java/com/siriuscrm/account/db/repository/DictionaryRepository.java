package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.entity.DictionaryWithParentItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DictionaryRepository extends JpaRepository<DictionaryItem, Long> {

    List<DictionaryItem> findByParentId(Long id);

    List<DictionaryItem> findByParentIdOrderById(Long id);

    @Query(nativeQuery = true,
            value = "SELECT c.id, c.parent_id, c.code, c.title, p.title AS parent_title " +
                    "FROM dictionaries p, dictionaries c " +
                    "WHERE p.id = c.parent_id AND p.parent_id = :parentId ORDER BY c.id"
    )
    List<DictionaryWithParentItem> findByParentOfParentsId(@Param("parentId") Long parentId);
}
