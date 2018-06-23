package com.siriuscrm.account.dto.common;

import lombok.Data;

@Data
public class ForwardToItemId {

    private Long id;

    public ForwardToItemId(Long id) {
        this.id = id;
    }
}
