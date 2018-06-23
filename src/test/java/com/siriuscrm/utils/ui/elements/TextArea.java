package com.siriuscrm.utils.ui.elements;

import com.siriuscrm.utils.ui.core.AbstractTextElement;
import org.openqa.selenium.WebElement;

public abstract class TextArea extends AbstractTextElement {

    public TextArea(String id) {
        super(id);
    }

    @Override
    protected WebElement getElement() {
        return waitVisibilityByCss("textarea#" + id + "-inputEl");
    }
}
