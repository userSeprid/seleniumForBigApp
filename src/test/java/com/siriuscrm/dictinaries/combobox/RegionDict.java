package com.siriuscrm.dictinaries.combobox;

public enum RegionDict {
    KIEV("Київська область"), VINNITSA("Вінницька область"), VOLIN("Волинська область"), DNEPROPETROVSK("Дніпропетровська область"),
    DONETSK("Донецька область"), ZHYTOMYR("Житомирська область"), ZAKARPATA("Закарпатська область"), ZAPORIZHIA("Запорізька область"),
    IVANO_FRANKIVSK("Івано-Франківська область"), KIROVOGRAD("Кіровоградська область"), LUGANSK("Луганська область"), LVIV("Львівська область"),
    MYKOLAIV("Миколаївська область"), ODESSA("Одеська область"), POLTAVA("Полтавська область"), RIVNE("Рівненська область"),
    SUMY("Сумська область"), TERNOPIL("Тернопільська область"), KHARKIV("Харківська область"), KHERSON("Херсонська область"),
    KHMELNITSKIY("Хмельницька область"), CHERKASSY("Черкаська область"), CHERNIVTSI("Чернівецька область"),
    CHERNIGOV("Чернігівська область"), KRIM("Крим");


    RegionDict(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private final String name;

    }
