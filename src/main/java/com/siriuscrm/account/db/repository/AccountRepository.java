package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepository extends JpaRepository<Account, Long> {

    Account findByLogin(String login);

}
