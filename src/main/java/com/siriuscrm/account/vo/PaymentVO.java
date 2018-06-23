package com.siriuscrm.account.vo;


import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.siriuscrm.account.dto.CustomJsonDateDeserializerFromInt;
import lombok.Data;

import java.util.Date;

@Data
public class PaymentVO {

    private Long id;

    private Long ppkId;

    private Long typeId;

    @JsonDeserialize(using = CustomJsonDateDeserializerFromInt.class)
    private Date createDate;

    private Integer amount;

    private String comments;
}
