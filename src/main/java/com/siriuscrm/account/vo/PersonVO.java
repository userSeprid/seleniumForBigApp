package com.siriuscrm.account.vo;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.siriuscrm.account.dto.CustomJsonDateDeserializerFromInt;
import lombok.Data;

import java.util.Date;

@Data
public class PersonVO {
    private Long id;
    private Long typeId;
    private String name;
    private String phone;
    private String email;
    private String fax;
    private String skype;
    private String note;
    private String inn;
    private String passportNumber;
    private String passportInstitute;
    private String registration;
    private String factAddress;
    private String edrpo;
    @JsonDeserialize(using = CustomJsonDateDeserializerFromInt.class)
    private Date registrationDate;
    private String ipn;
    private String vat;
    private String account;
    private String bank;
    private String mfo;
    private String cto;

}


