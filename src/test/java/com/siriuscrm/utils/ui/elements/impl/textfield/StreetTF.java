package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class StreetTF extends TextField {

    public StreetTF(TextFieldConfiguration textFieldConfiguration) {
        super("street-dictionary-id");
        this.value = textFieldConfiguration.getStreet();
    }
}
