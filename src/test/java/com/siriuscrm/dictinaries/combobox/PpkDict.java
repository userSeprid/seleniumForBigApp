package com.siriuscrm.dictinaries.combobox;

import com.siriuscrm.dictinaries.combobox.ppkhelper.Maks;

public enum  PpkDict {
    MAKS1_CASE(Maks.MAKS1.getName());

    PpkDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private String name;
}
