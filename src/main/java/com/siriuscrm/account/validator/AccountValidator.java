package com.siriuscrm.account.validator;

import com.siriuscrm.account.db.entity.Account;
import com.siriuscrm.account.db.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class AccountValidator implements Validator {

    @Autowired
    private AccountService accountService;

    @Override
    public boolean supports(Class<?> aClass) {
        return Account.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        Account account = (Account) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "NotEmpty");
        if (account.getLogin().length() < 6 || account.getLogin().length() > 32) {
            errors.rejectValue("username", "Size.userForm.username");
        }
        if (accountService.findByLogin(account.getLogin()) != null) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty");
        if (account.getPassword().length() < 8 || account.getPassword().length() > 32) {
            errors.rejectValue("password", "Size.userForm.password");
        }

        if (!account.getPasswordConfirm().equals(account.getPassword())) {
            errors.rejectValue("passwordConfirm", "Diff.userForm.passwordConfirm");
        }
    }
}
