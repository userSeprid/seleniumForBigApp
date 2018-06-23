package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.contract.ContractEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ContractRepository extends JpaRepository<ContractEntity, Long> {

}
