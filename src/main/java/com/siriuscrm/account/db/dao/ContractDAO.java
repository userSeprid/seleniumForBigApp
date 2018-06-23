package com.siriuscrm.account.db.dao;

import com.siriuscrm.account.db.entity.DBConstants;
import com.siriuscrm.account.db.entity.contract.ContractEntity;
import com.siriuscrm.account.db.entity.contract.ContractStateEntity;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.db.repository.ContractRepository;
import com.siriuscrm.account.db.repository.ContractStateRepository;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Data
public class ContractDAO {

    @Autowired
    private ContractRepository contractRepository;

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @Autowired
    private ContractStateRepository contractStateRepository;

    public Long create(PPKEntity ppkEntityEntity, Long typeId) {
        ContractEntity contractEntity = new ContractEntity();
        contractEntity.setType(dictionaryRepository.getOne(typeId));
        contractEntity.setPpk(ppkEntityEntity);
        contractRepository.save(contractEntity);
        ContractStateEntity stateEntity = new ContractStateEntity();
        stateEntity.setContract(contractEntity);
        stateEntity.setState(dictionaryRepository.getOne(DBConstants.ContractState.ABSENT.getTypeId()));
        contractStateRepository.save(stateEntity);
        contractStateRepository.copyReposrts(contractEntity.getId(), stateEntity.getId());
        return contractEntity.getId();
    }
}
