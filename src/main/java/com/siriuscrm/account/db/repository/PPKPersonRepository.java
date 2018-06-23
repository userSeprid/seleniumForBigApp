package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.PPKPersonEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PPKPersonRepository extends JpaRepository<PPKPersonEntity, PPKPersonEntity.PPKPersonEntityId> {

}
