package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.RelocationEventEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RelocationEventRepository extends JpaRepository<RelocationEventEntity, Long> {

    @Query(nativeQuery = true,
            value = "SELECT DISTINCT ON (android_account_id) " +
                    "  id, android_account_id, event_time, lat, lng FROM relocation_event " +
                    "ORDER BY android_account_id, event_time DESC ")
    List<RelocationEventEntity> getLatestLocations();


}
