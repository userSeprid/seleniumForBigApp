package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.contract.ContractStateEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ContractStateRepository extends JpaRepository<ContractStateEntity, Long> {

    ContractStateEntity getOneByIdOrderByStartDateDesc(Long contractId);

    @Query(value = "INSERT INTO contract_state_report (contract_state_id, title, template) " +
            "    SELECT :contractStateId, title, template " +
            "    FROM contract_reports_settings crs WHERE crs.contract_type_id = (SELECT type_id FROM contract c WHERE c.id = :contractId) " +
            " RETURNING id", nativeQuery = true)
    List<Long> copyReposrts(@Param("contractId") Long contractId, @Param("contractStateId") Long contractStateId);

    @Query(value = "SELECT count(*) FROM " +
            "( " +
            "SELECT " +
            "  cs1.start_date AS cs1start_date, cs1.end_date AS cs1end_date, " +
            "  cs2.start_date AS cs2start_date, cs2.end_date AS cs2end_date " +
            "FROM contract_state cs1, contract_state cs2 " +
            "WHERE cs1.contract_id = :contractId AND cs2.contract_id = :contractId AND cs1.id <> cs2.id" +
            ") AS muliple " +
            "WHERE cs1start_date > cs1end_date OR (cs1start_date, cs1end_date) OVERLAPS (cs2start_date, cs2end_date) ", nativeQuery = true)
    Integer getWrongStatesQty(@Param("contractId") Long contractId);

}
