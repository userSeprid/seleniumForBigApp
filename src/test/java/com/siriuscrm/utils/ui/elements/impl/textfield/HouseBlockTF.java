package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class HouseBlockTF extends TextField {

    public HouseBlockTF(TextFieldConfiguration textFieldConfiguration) {
        super("house-block-dictionary-id");
        this.value = textFieldConfiguration.getHouseBlock();
    }
}
