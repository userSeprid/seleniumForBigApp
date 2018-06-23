package com.siriuscrm.account.dto.common;

import lombok.Data;

import java.util.List;

@Data
public class PageDTO {

    private int total;

    private List items;

    public PageDTO(int total, List items) {
        this.total = total;
        this.items = items;
    }
}
