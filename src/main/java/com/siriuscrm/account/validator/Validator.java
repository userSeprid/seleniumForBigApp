package com.siriuscrm.account.validator;

import com.siriuscrm.account.db.service.ContractService;
import com.siriuscrm.account.vo.PPKVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Validator {

    @Autowired
    ContractService contractService;

    public boolean validate(PPKVO contract) {
      /*  boolean isValidCell = contract.getObjectDashboardNumber() == null
//                || contractService.isEmptyCell(contract.getDashboardType(), contract.getDashboardNumber(), contract.getObjectDashboardNumber())
//                || contract.getContractTypeExtraRef() != null
                || contract.getId() != null;
        return isValidCell;*/
        return false;
    }

}
