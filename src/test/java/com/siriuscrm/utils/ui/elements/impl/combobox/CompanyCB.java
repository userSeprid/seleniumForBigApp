package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.CompanyNameDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class CompanyCB extends Combobox {

    public CompanyCB(CompanyNameDict companyName) {
        super("company-dictionary-id");
        this.value = companyName.getName();
    }

}
