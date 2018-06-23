package com.siriuscrm.utils.ui.elements;

import com.siriuscrm.utils.ui.core.AbstractTextElement;
import org.openqa.selenium.WebElement;

public abstract class TextField extends AbstractTextElement {

    public TextField(String id) {
        super(id);
    }

    @Override
    protected WebElement getElement() {
        return waitVisibilityByCss("input#" + id + "-inputEl");
    }
}
