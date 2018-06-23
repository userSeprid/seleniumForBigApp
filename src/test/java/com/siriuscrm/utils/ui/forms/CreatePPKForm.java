package com.siriuscrm.utils.ui.forms;

import com.siriuscrm.utils.ui.core.AbstractWebPage;
import com.siriuscrm.utils.ui.elements.Button;

public class CreatePPKForm extends AbstractWebPage {

    private Button goNextB = new Button("save-changes-dictionary-id");
    public CreatePPKForm(String URL) {
        super(URL);
    }

    @Override
    public void submitForm() {
        goNextB.clickButton();
    }
}
