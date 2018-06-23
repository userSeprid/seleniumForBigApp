package com.siriuscrm.utils.ui.core;

import com.siriuscrm.DriverWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import static org.junit.Assert.assertEquals;

public abstract class AbstractUIElement {

    protected final WebDriver driver;
    protected String id;
    protected String value;

    public AbstractUIElement(String id) {
        this.driver = DriverWrapper.DRIVER;
        this.id = id;
    }

    protected WebElement waitVisibilityByCss(String cssSelector) {
        WebDriverWait wait = new WebDriverWait(driver, 15);
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(cssSelector)));
        return driver.findElement(By.cssSelector(cssSelector));
    }

    public abstract String readValueFromForm();

    public abstract void writeValueToForm();

    public void verifyValueOnForm() {
        assertEquals(this.readValueFromForm(), this.value);
    }
}
