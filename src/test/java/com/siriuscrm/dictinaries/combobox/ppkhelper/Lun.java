package com.siriuscrm.dictinaries.combobox.ppkhelper;

public enum Lun {
    LUN1("Lun1");

    Lun(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
