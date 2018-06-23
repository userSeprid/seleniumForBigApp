package com.siriuscrm.dictinaries.combobox;

public enum
ManagerCompanyDict {
    SIRIUS("Сiрiус"), PARTNERS("Партнери");


    ManagerCompanyDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
