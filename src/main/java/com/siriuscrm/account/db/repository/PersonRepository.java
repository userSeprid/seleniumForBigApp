package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.PersonEntity;
import com.siriuscrm.account.vo.extjs.FilterVO;
import com.siriuscrm.account.vo.extjs.SortVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PersonRepository extends JpaRepository<PersonEntity, Long> {

    @Query(value = "SELECT count(*) FROM person where name like :filter or phone like :filter"
            , nativeQuery = true)
    int findCount(@Param("filter") String filter);

}
