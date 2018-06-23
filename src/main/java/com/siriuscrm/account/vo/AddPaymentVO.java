package com.siriuscrm.account.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AddPaymentVO {

    Long contractID;
    Date createDate;
    Double amount;

}
