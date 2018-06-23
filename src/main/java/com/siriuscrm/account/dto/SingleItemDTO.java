package com.siriuscrm.account.dto;

import lombok.Data;

@Data
public class SingleItemDTO {

    private Object item;

    public SingleItemDTO(Object item) {
        this.item = item;
    }
}
