package com.siriuscrm.dictinaries.combobox;

public enum ConsoleDict {
    WITHOUT_CONNECTION("Без пiдключення на пульт"), MAKS("Макс"), LUN("Лунь"), GRIFFIN("Грифон"), ORION("Оріон"), DUNAI("Дунай");

    ConsoleDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;
}
