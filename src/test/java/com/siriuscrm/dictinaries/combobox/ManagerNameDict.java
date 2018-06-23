package com.siriuscrm.dictinaries.combobox;

import com.siriuscrm.dictinaries.combobox.managerhelper.SiriusManagersDict;

public enum ManagerNameDict {
    SIRIUS_MANAGER_CASE(SiriusManagersDict.KHRUSTITSKA.getName());

    ManagerNameDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
