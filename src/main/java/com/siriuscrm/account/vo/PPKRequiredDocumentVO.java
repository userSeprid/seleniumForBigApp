package com.siriuscrm.account.vo;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.siriuscrm.account.dto.CustomJsonDateDeserializerFromInt;
import lombok.Data;

import java.util.Date;

@Data
public class PPKRequiredDocumentVO {

    private Long id;
    private Long ppkId;
    private Long statusId;
    private String title;
    private String notes;

    @JsonDeserialize(using = CustomJsonDateDeserializerFromInt.class)
    private Date validTill;
}
