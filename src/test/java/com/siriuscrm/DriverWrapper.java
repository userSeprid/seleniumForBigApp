package com.siriuscrm;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.io.File;

public class DriverWrapper {

    static public WebDriver DRIVER;

    static {
        System.out.println(new File(".").getAbsoluteFile());
        System.setProperty("webdriver.chrome.driver", ".\\src\\test\\resources\\chromedriver.exe");
        DRIVER = new ChromeDriver();
    }

}
