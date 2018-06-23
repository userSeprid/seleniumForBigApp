package com.siriuscrm.account.dto.common;

import lombok.Data;

import java.util.List;

@Data
public class ListDTO {

    private List items;

    public ListDTO(List items) {
        this.items = items;
    }
}
