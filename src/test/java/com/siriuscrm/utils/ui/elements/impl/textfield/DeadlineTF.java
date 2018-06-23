package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class DeadlineTF extends TextField {

    public DeadlineTF(TextFieldConfiguration textFieldConfiguration) {
        super("deadline-dictionary-id");
        this.value = String.valueOf(textFieldConfiguration.getDeadline());
    }
}
