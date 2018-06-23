package com.siriuscrm.dictinaries.combobox.ppkhelper;

public enum Maks {
    MAKS1("Макс1"), MAKS2("Макс2");

    Maks(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
