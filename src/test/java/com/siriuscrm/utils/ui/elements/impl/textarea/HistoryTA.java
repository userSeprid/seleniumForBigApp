package com.siriuscrm.utils.ui.elements.impl.textarea;

import com.siriuscrm.dictinaries.textarea.configuration.TextAreaConfiguration;
import com.siriuscrm.utils.ui.elements.TextArea;

public class HistoryTA extends TextArea {

    public HistoryTA(TextAreaConfiguration textAreaConfiguration) {
        super("history-dictionary-id");
        this.value = textAreaConfiguration.getHistory();
    }
}
