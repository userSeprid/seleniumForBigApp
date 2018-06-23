package com.siriuscrm.dictinaries.combobox;

public enum ObjectTypeDict {
    FLAT("Квартира"), BUILDING("Будинок"), SHOP("Магазин"), KIOSK("Кіоск"), OFFICE("Офіс");

    ObjectTypeDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
