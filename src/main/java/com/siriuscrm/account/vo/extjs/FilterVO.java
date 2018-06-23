package com.siriuscrm.account.vo.extjs;

import org.apache.commons.lang.StringUtils;

public class FilterVO extends ExtjsVO {


    public static final String VALUE = "value";

    public FilterVO(String sortParameter) {
        super(sortParameter);
    }

    public String getValue() {
        return "'%" + parameters.get("value") + "%'";
    }

    public boolean isEmpty() {
        return StringUtils.isEmpty(parameters.get(VALUE));
    }
}
