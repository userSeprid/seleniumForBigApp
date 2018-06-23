package com.siriuscrm.dictinaries.combobox.managerhelper;

public enum SiriusManagersDict {

    MUKOLENKO("Миколенко"), KHRUSTITSKA("Хрустицька"), KUTSENKO("Куценко"),
    DOMANSKIY("Доманський"), BONDAR("Бондар"), REUS("Реус");

    public String getName() {
        return name;
    }

    SiriusManagersDict(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    private final String name;
}
