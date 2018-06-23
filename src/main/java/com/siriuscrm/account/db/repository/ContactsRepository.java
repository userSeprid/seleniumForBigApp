package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.PersonEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContactsRepository extends JpaRepository<PersonEntity, Long> {

}
