package com.siriuscrm.dictinaries.combobox;

public enum CameFromDict {

    CAME_FROM("Прийшов від");

    private final String name;

    CameFromDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
