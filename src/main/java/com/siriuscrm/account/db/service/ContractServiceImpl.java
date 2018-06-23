package com.siriuscrm.account.db.service;

import com.siriuscrm.account.db.dao.ContractDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by asolod on 8/3/2017.
 */
@Service
public class ContractServiceImpl implements ContractService {

    @Autowired
    private ContractDAO contractDAO;

 /*
    @Autowired
    private ContractFilesRepository contractFilesRepository;
*/

/*
    @Autowired
    private ContactsRepository contactsRepository;
*/

/*
    @Override
    public Contract findById(Long id) {
        Contract contract = contractRepository.findById(id);
        return contract;
    }

    @Override
    public List<Contract> findBaseContracts() {
        return null;
    }

    @Override
    public PPKFiles findFiles(Long id) {
        return contractFilesRepository.findById(id);
    }

    @Override
    public void saveFile(PPKFiles file) {
        contractFilesRepository.save(file);
    }

    @Override
    public Integer nextEmptyCell(int dashboard, int dashboardNum) {
        return contractRepository.findEmptyCell(dashboard, dashboardNum);
    }

    @Override
    public Boolean isEmptyCell(int dashboard, int dashboardNum, int cell) {
        return contractRepository.isEmptyCell(dashboard, dashboardNum, cell) == null;
    }

    @Override
    public Contract save(Contract contract) {
        return contractRepository.save(contract);
    }

    @Override
    public PersonEntity save(PersonEntity person) {
        return contactsRepository.save(person);
    }

    @Override
    public void delete(Long id) {
        contractRepository.delete(id);
    }

    @Override
    public void updateContractStatus(ContractStatus contractStatus) {
        contractStatusRepository.updateContractStatus(
                contractStatus.getContractID(),
                contractStatus.getStatus().getId(),
                contractStatus.getStatusDate());
    }


    @Override
    public ContractStatus findContractStartDate(Long id) {
        return contractStatusRepository.findContractStatus(id, 2);
    }

    @Override
    public ContractStatus findContractEndDate(Long id) {
        return null;
    }

    @Override
    public PersonEntity findPerson(Long id) {
        return contactsRepository.findById(id);
    }
*/
}
