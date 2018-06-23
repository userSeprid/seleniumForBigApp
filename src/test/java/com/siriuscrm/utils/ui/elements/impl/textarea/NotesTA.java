package com.siriuscrm.utils.ui.elements.impl.textarea;

import com.siriuscrm.dictinaries.textarea.configuration.TextAreaConfiguration;
import com.siriuscrm.utils.ui.elements.TextArea;

public class NotesTA extends TextArea {

    public NotesTA(TextAreaConfiguration textAreaConfiguration) {
        super("notes-dictionary-id");
        this.value = textAreaConfiguration.getNotes();
    }
}
