package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.ManagerCompanyDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class ManagerCompanyCB extends Combobox {

    public ManagerCompanyCB(ManagerCompanyDict managerCompanyName) {
        super("manager-company-dictionary-id");
        this.value = managerCompanyName.getName();
    }
}
