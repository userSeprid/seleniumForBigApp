package com.siriuscrm.account.vo;

import lombok.Data;

@Data
public class PPKPersonVO {

    private Long ppkId;

    private Long personId;

    private String name;

    private String phone;

    private String email;

    private String fax;

    private String skype;

    private String note;

    private Boolean owner;

    private Boolean payer;

    private Boolean alarm;

    private Boolean advisor;

}


