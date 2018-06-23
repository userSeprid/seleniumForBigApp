package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.payment.PPKPaymentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface
PPKPaymentRepository extends JpaRepository<PPKPaymentEntity, Long> {

    void deleteByPpkIdAndTypeId(Long ppId, Long typeId);

    PPKPaymentEntity findByPpkIdAndTypeId(Long id, Long typeId);

    List<PPKPaymentEntity> findByPpkIdOrderByCreateDateAscIdAsc(Long ppkId);

    List findByPpkIdAndTypeIdInOrderByCreateDateAscIdAsc(Long ppkId, List<Long> types);
}
