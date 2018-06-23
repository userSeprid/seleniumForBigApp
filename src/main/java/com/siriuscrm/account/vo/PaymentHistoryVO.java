package com.siriuscrm.account.vo;

import lombok.Data;

import java.util.Date;

@Data
public class PaymentHistoryVO {

    private String contractID;
    private Date date;
    private Long amount;

}
