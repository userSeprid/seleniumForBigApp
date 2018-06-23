package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class ReactTimeTF extends TextField {

    public ReactTimeTF(TextFieldConfiguration textFieldConfiguration) {
        super("react-time-dictionary-id");
        this.value = String.valueOf(textFieldConfiguration.getReactTime());
    }
}
