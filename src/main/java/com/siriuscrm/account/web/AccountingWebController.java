package com.siriuscrm.account.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/accounting")
public class AccountingWebController {

    @RequestMapping(value = "/report", method = RequestMethod.GET)
    public String view() {
        return "report";
    }

}
