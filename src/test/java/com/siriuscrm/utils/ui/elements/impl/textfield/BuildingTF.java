package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class BuildingTF extends TextField {

    public BuildingTF(TextFieldConfiguration textFieldConfiguration) {
        super("building-dictionary-id");
        this.value = textFieldConfiguration.getBuilding();
    }
}
