package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.ConsoleDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class ConsoleCB extends Combobox {

    public ConsoleCB(ConsoleDict consoleName) {
        super("console-dictionary-id");
        this.value = consoleName.getName();
    }
}
