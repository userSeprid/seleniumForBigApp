package com.siriuscrm.utils.ui.elements.impl.textfield;

import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.elements.TextField;

public class PossibilityToIncreaseApTF extends TextField {

    public PossibilityToIncreaseApTF(TextFieldConfiguration textFieldConfiguration) {
        super("possibility-to-increase-ap-dictionary-id");
        this.value = textFieldConfiguration.getPossibilityToIncreaseAp();
    }
}
