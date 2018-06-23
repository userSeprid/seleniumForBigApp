package com.siriuscrm.account.db.dao;

import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.entity.payment.PPKPaymentEntity;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import com.siriuscrm.account.db.repository.PPKPaymentRepository;
import com.siriuscrm.account.db.repository.PPKViewRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.transaction.Transactional;

@Component
@Data
public class PPKPaymentDAO {

    @Autowired
    private PPKPaymentRepository repository;

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @Autowired
    private PPKViewRepository ppkViewRepository;

    @Transactional
    public void mergePayment(PPKEntity ppkEntity, Long typeId, Integer amount, String description) {
        DictionaryItem type = dictionaryRepository.getOne(typeId);
        PPKPaymentEntity paymentEntity = repository.findByPpkIdAndTypeId(ppkEntity.getId(), typeId);
        if (paymentEntity == null) {
            paymentEntity = new PPKPaymentEntity();
            paymentEntity.setPpk(ppkEntity);
            paymentEntity.setType(type);
        }
        paymentEntity.setAmount(amount);
        paymentEntity.setDescription(description);
        repository.save(paymentEntity);
    }

    @Transactional
    public void createPayment(PPKEntity ppkEntity, Long typeId, Integer amount) {
        DictionaryItem type = dictionaryRepository.getOne(typeId);
        PPKPaymentEntity paymentEntity = new PPKPaymentEntity();
        paymentEntity.setPpk(ppkEntity);
        paymentEntity.setType(type);
        paymentEntity.setAmount(amount);
        repository.save(paymentEntity);
    }

    @Transactional
    public void deletePayment(PPKEntity ppkEntity, Long typeId) {
        repository.deleteByPpkIdAndTypeId(ppkEntity.getId(), typeId);
    }


}
