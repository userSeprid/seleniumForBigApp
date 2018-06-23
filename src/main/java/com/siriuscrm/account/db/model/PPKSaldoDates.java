package com.siriuscrm.account.db.model;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.siriuscrm.account.dto.CustomDateSerializer;
import lombok.Data;

import java.util.Date;

@Data
public class PPKSaldoDates {

    @JsonSerialize(using = CustomDateSerializer.class)
    private Date minDate;

    @JsonSerialize(using = CustomDateSerializer.class)
    private Date maxDate;

}
