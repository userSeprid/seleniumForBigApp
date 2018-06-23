package com.siriuscrm.utils.ui.core;

import org.openqa.selenium.WebElement;

public abstract class AbstractTextElement extends AbstractUIElement {

    public AbstractTextElement(String id) {
        super(id);
    }

    protected abstract WebElement getElement();

    @Override
    public String readValueFromForm() {
        return this.getElement().getAttribute("value");
    }

    @Override
    public void writeValueToForm() {
        this.getElement().sendKeys(value);
    }

}
