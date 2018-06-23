package com.siriuscrm.account.web;

import com.siriuscrm.account.db.entity.Account;
import com.siriuscrm.account.db.service.SecurityService;
import com.siriuscrm.account.db.service.AccountService;
import com.siriuscrm.account.validator.AccountValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserWebController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private AccountValidator accountValidator;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new Account());
        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") Account accountForm, BindingResult bindingResult, Model model) {
        accountValidator.validate(accountForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        accountService.save(accountForm);
        securityService.autologin(accountForm.getLogin(), accountForm.getPasswordConfirm());

        return "redirect:/contractList";
    }

    @RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }

}
