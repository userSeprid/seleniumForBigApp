package com.siriuscrm.dictinaries.combobox;

public enum CompanyNameDict {

    SIRIUS("Сіріус"), SIRIUS_CONSOLE("Сіріус Пульт");

    CompanyNameDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
