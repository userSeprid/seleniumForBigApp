package com.siriuscrm.account.db.mapper;

import com.siriuscrm.account.db.model.ContractFeeModel;
import com.siriuscrm.account.db.model.PPKSaldoDates;

import java.util.List;

public interface PPKSaldoMapper {

    PPKSaldoDates findSaldoDates(Long ppkId);

    List<ContractFeeModel> findSubscriptionFeeByContract(Long contractId);

    List<ContractFeeModel> findAdditionalFeeByPPK(Long ppkId);

    Integer findDebitByPPKId(Long ppkId);

    Integer findCreditByPPKId(Long ppkId);
}
