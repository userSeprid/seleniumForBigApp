package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class FlatNumberTF extends TextField {

    public FlatNumberTF(TextFieldConfiguration textFieldConfiguration) {
        super("flat-number-dictionary-id");
        this.value = textFieldConfiguration.getFlatNumber();
    }
}
