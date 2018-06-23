package com.siriuscrm.utils.ui.core;

import com.siriuscrm.DriverWrapper;
import org.openqa.selenium.WebDriver;

import java.util.LinkedList;
import java.util.List;

import static org.junit.Assert.assertEquals;

public abstract class AbstractWebPage {

    protected WebDriver driver;
    protected String URL;

    public AbstractWebPage(String URL) {
        this.driver = DriverWrapper.DRIVER;
        this.URL = URL;
        this.driver.get(URL);
    }

    public abstract void submitForm();

    public void applyConfig(List<AbstractUIElement> uiElementList) {
        for (AbstractUIElement uiElement : uiElementList) {
            uiElement.writeValueToForm();
        }
    }

    public void verifyConfig(LinkedList<AbstractUIElement> uiElementList){
        for (AbstractUIElement uiElement : uiElementList) {
            uiElement.verifyValueOnForm();
        }
    }
}
