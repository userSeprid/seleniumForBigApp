package com.siriuscrm.account.vo.extjs;

public class SortVO extends ExtjsVO {

    public SortVO(String sortParameter) {
        super(sortParameter);
    }

    public String getProperty() {
        return parameters.get("property");
    }

    public String getDirection() {
        return parameters.get("direction");
    }
}
