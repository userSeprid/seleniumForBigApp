package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.ManagerNameDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class ManagerNameCB extends Combobox {

    public ManagerNameCB(ManagerNameDict managerName) {
        super("manager-dictionary-id");
        this.value = managerName.getName();
    }
}
