package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class SimCard1TF extends TextField {

    public SimCard1TF(TextFieldConfiguration textFieldConfiguration) {
        super("sim-card1-dictionary-id");
        this.value = textFieldConfiguration.getSimCard1();
    }
}
