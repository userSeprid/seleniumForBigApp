package com.siriuscrm.account.rest;

import com.siriuscrm.account.db.entity.DBConstants;
import com.siriuscrm.account.db.entity.contract.ContractEntity;
import com.siriuscrm.account.db.entity.contract.ContractStateEntity;
import com.siriuscrm.account.db.repository.*;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.vo.ContractStateVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.io.IOException;

@RestController
@RequestMapping(value = "/api/contractState")
public class ContactStateController {

    @Autowired
    private ContractRepository contractRepository;

    @Autowired
    private ContractStateRepository contractStateRepository;

    @Autowired
    private ContractStateViewRepository contractStateViewRepository;

    @Autowired
    private ContractStateReportRepository contractStateReportRepository;

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @RequestMapping(value = "/items", method = RequestMethod.GET)
    public ListDTO loadList(@RequestParam(value = "ppkId") Long ppkId) throws IOException {
        return new ListDTO((contractStateViewRepository.findByPpkIdOrderByContractNumberAscStartDate(ppkId)));
    }

/*    @RequestMapping(value = "/report/items", method = RequestMethod.GET)
    public ListDTO loadList(@RequestParam(value = "contractStateId") Long contractStateId) throws IOException {
        return new ListDTO(contractStateReportRepository.findByContractStateId(contractStateId));
    }*/

    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public ListDTO create(@RequestBody ContractStateVO contractStateVO) throws IOException {
        ContractEntity contractEntity = contractRepository.getOne(contractStateVO.getContractId());
        contractEntity.setDeposit(contractStateVO.getDeposit());
        contractEntity.setSocialProject(contractStateVO.getSocialProject());
        contractEntity.setSmsGuardSwitch(contractStateVO.getSmsGuardSwitch());
        contractEntity.setSmsAlarm(contractStateVO.getSmsAlarm());
        contractEntity = contractRepository.save(contractEntity);

        ContractStateEntity contractStateEntity = new ContractStateEntity();
        BeanUtils.copyProperties(contractStateVO, contractStateEntity, "id");
        contractStateEntity.setContract(contractEntity);
        contractStateRepository.save(contractStateEntity);
        return null;
    }

    @RequestMapping(value = "/item", method = RequestMethod.PUT)
    @Transactional
    public ResponseEntity<Object> updateContractState(@RequestBody ContractStateVO contractStateVO) throws IOException {
        ContractEntity contractEntity = contractRepository.getOne(contractStateVO.getContractId());
        contractEntity.setDeposit(contractStateVO.getDeposit());
        contractEntity.setSocialProject(contractStateVO.getSocialProject());
        contractEntity.setSmsGuardSwitch(contractStateVO.getSmsGuardSwitch());
        contractEntity.setSmsAlarm(contractStateVO.getSmsAlarm());
        contractRepository.save(contractEntity);

        ContractStateEntity contractStateEntity = contractStateRepository.getOneByIdOrderByStartDateDesc(contractStateVO.getId());
        BeanUtils.copyProperties(contractStateVO, contractStateEntity, "id");
        Long stateId;
        if (contractStateVO.getStartDate() == null) {
            stateId = DBConstants.ContractState.ABSENT.getTypeId();
        } else {
            if (contractStateVO.getEndDate() == null) {
                stateId = DBConstants.ContractState.UNDER_GUARD.getTypeId();
            } else {
                stateId = DBConstants.ContractState.DISABLED.getTypeId();
            }
        }
        contractStateEntity.setState(dictionaryRepository.getOne(stateId));
        contractStateRepository.save(contractStateEntity);
        if (contractStateRepository.getWrongStatesQty(contractEntity.getId()) > 0) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);

        }
        return ResponseEntity.status(HttpStatus.OK).body(null);
    }
}
