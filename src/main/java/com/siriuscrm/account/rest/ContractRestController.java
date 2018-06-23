package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.entity.contract.ContractEntity;
import com.siriuscrm.account.db.entity.contract.ContractStateEntity;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.db.repository.ContractRepository;
import com.siriuscrm.account.db.repository.ContractStateRepository;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import com.siriuscrm.account.db.repository.PPKRepository;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.vo.ContractVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping(value = "/api/contract")
public class ContractRestController {

    @Autowired
    private PPKRepository ppkRepository;

    @Autowired
    private ContractRepository contractRepository;

    @Autowired
    private ContractStateRepository contractStateRepository;

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public ListDTO create(@RequestBody ContractVO contractVO) throws IOException {
        PPKEntity ppk = ppkRepository.findOne(contractVO.getPpkId());
        ContractEntity contractEntity = new ContractEntity();
        BeanUtils.copyProperties(contractEntity, contractVO, "id");
        contractEntity.setPpk(ppk);
        contractEntity.setType(dictionaryRepository.findOne(contractVO.getTypeId()));
        contractEntity = contractRepository.save(contractEntity);

        ContractStateEntity contractStateEntity = new ContractStateEntity();
        contractStateEntity.setStartDate(ppk.getCreateDate());
        contractStateEntity.setContract(contractEntity);
        contractStateRepository.save(contractStateEntity);
        return null;
    }
}
