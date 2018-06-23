package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.ppk.PPKReminderEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PPKReminderRepository extends JpaRepository<PPKReminderEntity, Long> {

    List<PPKReminderEntity> findByPpkId(Long ppkId);
}
