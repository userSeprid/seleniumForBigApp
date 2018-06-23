package com.siriuscrm.utils.ui.elements;

import com.siriuscrm.utils.ui.core.AbstractUIElement;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

public class Button extends AbstractUIElement {

    protected String id;
    protected WebElement webElement;

    public Button(String id) {
        super(id);
        this.id = id;
        webElement = waitVisibilityByCss("span#" + id + "-btnInnerEl");
    }

    @Override
    public String readValueFromForm() {
        return null;
    }

    @Override
    public void writeValueToForm() {

    }

    public void clickButton() {
        webElement.click();
    }
}
