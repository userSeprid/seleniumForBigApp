package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.ContractStateReportEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ContractStateReportRepository extends JpaRepository<ContractStateReportEntity, Long> {

    List<ContractStateReportEntity> findByContractStateId(Long contractStateId);
}
