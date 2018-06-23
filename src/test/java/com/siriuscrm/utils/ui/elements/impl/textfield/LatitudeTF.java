package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class LatitudeTF extends TextField {

    public LatitudeTF(TextFieldConfiguration textFieldConfiguration) {
        super("latitude-dictionary-id");
        this.value = String.valueOf(textFieldConfiguration.getLatitude());
    }
}
