package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class ConsoleNumberTF extends TextField {

    public ConsoleNumberTF(TextFieldConfiguration textFieldConfiguration) {
        super("console-number-dictionary-id");
        this.value = String.valueOf(textFieldConfiguration.getConsoleNumber());
    }
}
