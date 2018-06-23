package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.RegionDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class RegionCB extends Combobox {

    public RegionCB(RegionDict regionName) {
        super("region-dictionary-id");
        this.value = regionName.getName();
    }
}
