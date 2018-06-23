package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.contract.ContractViewEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ContractViewRepository extends JpaRepository<ContractViewEntity, Long> {

    List<ContractViewEntity> findByPpkIdOrderById(Long ppkId);

/*    @Query(value = "SELECT * FROM contract_view cv, contract_state cs WHERE cv.id = cs.contract_id AND cs.id = :contractStateId ", nativeQuery = true)
    ContractViewEntity findByContractStateId(@Param("contractStateId") Long contractStateId);*/
}
