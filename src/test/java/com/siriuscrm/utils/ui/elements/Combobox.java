package com.siriuscrm.utils.ui.elements;

import com.siriuscrm.utils.ui.core.AbstractUIElement;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

public abstract class Combobox extends AbstractUIElement {

    public Combobox(String id) {
        super(id);
    }

    protected WebElement getPicker() {
        return waitVisibilityByCss("div#" + id + "-trigger-picker");
    }

    @Override
    public String readValueFromForm() {
        //WebElement value = driver.findElement(By.cssSelector("#" + id + "-inputEl"));
        WebElement value = waitVisibilityByCss("#" + id + "-inputEl");
        return value.getAttribute("value");
    }

    @Override
    public void writeValueToForm() {
        this.getPicker().click();
        List<WebElement> comboItems = driver.findElements(By.cssSelector(".x-boundlist-item"));
        for (WebElement item : comboItems) {
            if (item.getText().equals(this.value)) {
                item.click();
                break;
            }
        }
    }
}
