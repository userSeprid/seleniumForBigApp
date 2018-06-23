package com.siriuscrm.account.db.model;

import lombok.Data;

@Data
public class ContractFeeModel {
    private Long contractId;
    private Integer year;
    private Integer monthNumber;
    private String monthName;
    private Integer amount;
}
