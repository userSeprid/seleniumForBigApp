package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.PPKPersonViewEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PPKPersonViewRepository extends JpaRepository<PPKPersonViewEntity, Long> {

    List findByPpkId(Long ppkId);
}
