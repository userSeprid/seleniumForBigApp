package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.CameFromDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class CameFromCB extends Combobox {

    public CameFromCB(CameFromDict cameFromName) {
        super("came-from-dictionary-id");
        this.value = cameFromName.getName();
    }
}
