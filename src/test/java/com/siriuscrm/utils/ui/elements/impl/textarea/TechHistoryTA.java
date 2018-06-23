package com.siriuscrm.utils.ui.elements.impl.textarea;

import com.siriuscrm.dictinaries.textarea.configuration.TextAreaConfiguration;
import com.siriuscrm.utils.ui.elements.TextArea;

public class TechHistoryTA extends TextArea {

    public TechHistoryTA(TextAreaConfiguration textAreaConfiguration) {
        super("tech-history-dictionary-id");
        this.value = textAreaConfiguration.getTechHistory();
    }
}
