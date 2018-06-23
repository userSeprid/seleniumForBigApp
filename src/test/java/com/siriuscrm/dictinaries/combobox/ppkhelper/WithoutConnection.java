package com.siriuscrm.dictinaries.combobox.ppkhelper;

public enum WithoutConnection {
    NO_SELECTION("");

    WithoutConnection(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
