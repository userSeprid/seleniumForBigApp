package com.siriuscrm.account.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/map")
public class MapWebController {

    @RequestMapping(value = "/tracking", method = RequestMethod.GET)
    public String view() {
        return "mapTracking";
    }

}
