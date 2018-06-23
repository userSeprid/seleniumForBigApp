package com.siriuscrm.utils.ui.elements.impl.textarea;

import com.siriuscrm.dictinaries.textarea.configuration.TextAreaConfiguration;
import com.siriuscrm.utils.ui.elements.TextArea;

public class DescriptionTA extends TextArea {

    public DescriptionTA(TextAreaConfiguration textAreaConfiguration) {
        super("description-dictionary-id");
        this.value = textAreaConfiguration.getDescription();
    }
}
