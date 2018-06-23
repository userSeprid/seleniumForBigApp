package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.contract.ContractStateViewEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ContractStateViewRepository extends JpaRepository<ContractStateViewEntity, Long> {

    List<ContractStateViewEntity> findByPpkIdOrderByContractNumberAscStartDate(Long ppkId);
}
