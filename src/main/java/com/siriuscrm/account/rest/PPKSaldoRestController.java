package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.entity.contract.ContractViewEntity;
import com.siriuscrm.account.db.mapper.PPKSaldoMapper;
import com.siriuscrm.account.db.model.ContractFeeModel;
import com.siriuscrm.account.db.repository.ContractViewRepository;
import com.siriuscrm.account.db.repository.PPKViewRepository;
import com.siriuscrm.account.dto.SingleItemDTO;
import com.siriuscrm.account.dto.common.ListDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value = "/api/saldo")
public class PPKSaldoRestController {

    @Autowired
    private PPKSaldoMapper ppkSaldoMapper;

    @Autowired
    private ContractViewRepository contractViewRepository;

    @Autowired
    private PPKViewRepository ppkViewRepository;


    @RequestMapping(value = "/findSaldoByPPK", method = RequestMethod.GET)
    public SingleItemDTO findSaldoByPPK(@RequestParam(value = "id") Long id) throws IOException {
        Map<String, Object> map = new HashMap() {{
            put("ppkNumber", ppkViewRepository.getOne(id).getPpkNumber());
            put("zAmount", ppkViewRepository.getOne(id).getBalance());
            put("dates", ppkSaldoMapper.findSaldoDates(id));
            put("debit", ppkSaldoMapper.findDebitByPPKId(id));
            put("credit", ppkSaldoMapper.findCreditByPPKId(id));
        }};
        return new SingleItemDTO(map);
    }

    @RequestMapping(value = "/findAdditionalFeeByPPK", method = RequestMethod.GET)
    public ListDTO findAdditionalFeeByPPK(@RequestParam(value = "ppkId") Long ppkId) throws IOException {
        return new ListDTO(ppkSaldoMapper.findAdditionalFeeByPPK(ppkId));
    }

    @RequestMapping(value = "/contractNames", method = RequestMethod.GET)
    public ListDTO findContractNamesByPPK(@RequestParam(value = "ppkId") Long ppkId) throws IOException {
        List<String> contractNames = new LinkedList<>();
        for (ContractViewEntity contractViewEntity : contractViewRepository.findByPpkIdOrderById(ppkId)) {
            contractNames.add(contractViewEntity.getContractNumber());
        }
        contractNames.add("Доплати");
        return new ListDTO(contractNames);
    }

    @RequestMapping(value = "/ppkFees", method = RequestMethod.GET)
    public ListDTO findFeesByPPK(@RequestParam(value = "ppkId") Long ppkId) throws IOException {
        List<List<ContractFeeModel>> contractFees = new LinkedList<>();
        for (ContractViewEntity contractViewEntity : contractViewRepository.findByPpkIdOrderById(ppkId)) {
            contractFees.add(ppkSaldoMapper.findSubscriptionFeeByContract(contractViewEntity.getId()));
        }

        contractFees.add(ppkSaldoMapper.findAdditionalFeeByPPK(ppkId));

        List<Map<String, Object>> feesList = new LinkedList<>();
        for (int i = 0; i < contractFees.get(0).size(); i++) {
            Map<String, Object> fees = new HashMap<>();
            fees.put("year", contractFees.get(0).get(i).getYear());
            fees.put("monthName", contractFees.get(0).get(i).getMonthName());
            for (int j = 0; j < contractFees.size(); j++) {
                fees.put("c" + j, contractFees.get(j).get(i).getAmount());
            }
            feesList.add(fees);
        }

        return new ListDTO(feesList);
    }

}
