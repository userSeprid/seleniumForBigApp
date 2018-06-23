package com.siriuscrm.utils.ui.elements.impl.combobox;

import com.siriuscrm.dictinaries.combobox.ObjectTypeDict;
import com.siriuscrm.utils.ui.elements.Combobox;

public class ObjectTypeCB extends Combobox {

    public ObjectTypeCB(ObjectTypeDict objectTypeName) {
        super("object-dictionary-id");
        this.value = objectTypeName.getName();
    }
}
