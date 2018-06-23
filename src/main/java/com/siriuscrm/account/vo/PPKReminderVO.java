package com.siriuscrm.account.vo;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.siriuscrm.account.dto.CustomJsonDateDeserializerFromInt;
import lombok.Data;

import java.util.Date;

@Data
public class PPKReminderVO {

    private Long id;

    private Long ppkId;

    @JsonDeserialize(using = CustomJsonDateDeserializerFromInt.class)
    private Date actionDate;

    private Long typeId;

    private String description;

}
