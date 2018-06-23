package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.PPKFiles;
import org.springframework.data.jpa.repository.JpaRepository;

public interface
PPKFilesRepository extends JpaRepository<PPKFiles, Long> {

    PPKFiles findByPpkId(Long ppkId);
}
