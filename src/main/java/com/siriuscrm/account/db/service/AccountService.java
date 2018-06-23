package com.siriuscrm.account.db.service;

import com.siriuscrm.account.db.entity.Account;

public interface AccountService {

    void save(Account account);

    Account findByLogin(String login);
}
