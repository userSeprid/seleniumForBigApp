package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class StartCapitalTF extends TextField {

    public StartCapitalTF(TextFieldConfiguration textFieldConfiguration) {
        super("start-capital-dictionary-id");
        this.value = String.valueOf(textFieldConfiguration.getStartCapital());
    }
}
