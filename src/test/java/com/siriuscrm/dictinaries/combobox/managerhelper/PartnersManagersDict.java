package com.siriuscrm.dictinaries.combobox.managerhelper;

public enum PartnersManagersDict {

    ZINOVIY("Зiновiй"), ZAHIST_12("Захист-12");

    public String getName() {
        return name;
    }

    PartnersManagersDict(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    private final String name;
}
