package com.siriuscrm.utils.ui.elements.impl.textarea;

import com.siriuscrm.dictinaries.textarea.configuration.TextAreaConfiguration;
import com.siriuscrm.utils.ui.elements.TextArea;

public class BalanceNotesTA extends TextArea {

    public BalanceNotesTA(TextAreaConfiguration textAreaConfiguration) {
        super("balance-notes-dictionary-id");
        this.value = textAreaConfiguration.getBalanceNotes();
    }
}
