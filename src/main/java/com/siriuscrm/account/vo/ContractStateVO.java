package com.siriuscrm.account.vo;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.siriuscrm.account.dto.CustomJsonDateDeserializerFromInt;
import lombok.Data;

import java.util.Date;

@Data
public class ContractStateVO {

    private Long id;
    private Long contractId;
    private Integer payment;
    private Integer refund;
    private Boolean deposit;
    private Boolean socialProject;
    private Boolean smsGuardSwitch;
    private Boolean smsAlarm;

    @JsonDeserialize(using = CustomJsonDateDeserializerFromInt.class)
    private Date endDate;

    @JsonDeserialize(using = CustomJsonDateDeserializerFromInt.class)
    private Date startDate;
}
