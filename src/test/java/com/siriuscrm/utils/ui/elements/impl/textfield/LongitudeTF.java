package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class LongitudeTF extends TextField {

    public LongitudeTF(TextFieldConfiguration textFieldConfiguration) {
        super("longitude-dictionary-id");
        this.value = String.valueOf(textFieldConfiguration.getLongitude());
    }
}
