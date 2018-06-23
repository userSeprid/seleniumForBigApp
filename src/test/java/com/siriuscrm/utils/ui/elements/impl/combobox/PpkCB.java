package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.PpkDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class PpkCB extends Combobox {

    public PpkCB(PpkDict ppkName) {
        super("ppk-dictionary-id");
        this.value = ppkName.getName();
    }
}
