package com.siriuscrm.account.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/dictionary")
public class DictionaryWebController {

    @RequestMapping(value = "/editor", method = RequestMethod.GET)
    public String view() {
        return "dictionaryEditor";
    }

}
