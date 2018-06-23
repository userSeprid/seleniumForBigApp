package com.siriuscrm.account.web;


import com.siriuscrm.account.db.service.ContractService;
import com.siriuscrm.account.db.service.DictionaryService;
import com.siriuscrm.account.validator.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.text.SimpleDateFormat;

@Controller
public class ContractWebController {

    @Autowired
    private ContractService contractService;
    @Autowired
    private DictionaryService dictionaryService;

    @Autowired
    private Validator validator;

    public static final SimpleDateFormat SIMPLE_DATE_FORMAT = new SimpleDateFormat("MM dd yyyy");

/*
    @RequestMapping(value = "/contract", method = RequestMethod.GET)
    public String create(Model model, @RequestParam(value = "parent_id", required = false) Long parentID) {

        Contract contract = new Contract();

        model.addAttribute("contract", contract);
        return "contract";
    }
*/

    @RequestMapping(value = "/viewContract", method = RequestMethod.GET)
    public String view() {
        return "viewContract";
    }

    @RequestMapping(value = "/link", method = RequestMethod.GET)
    public String link() {
        return "viewContract";
    }

}
