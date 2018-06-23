package com.siriuscrm.account.db.service;

import com.siriuscrm.account.db.entity.AccessLevel;
import com.siriuscrm.account.db.entity.Account;
import com.siriuscrm.account.db.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

public class AccountServiceImpl implements UserDetailsService, AccountService {

    @Autowired
    private AccountRepository accountRepository;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account = accountRepository.findByLogin(username);

        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        for (AccessLevel accessLevel : account.getAccessLevels()) {
            grantedAuthorities.add(new SimpleGrantedAuthority(accessLevel.getName()));
        }

        return new org.springframework.security.core.userdetails.User(account.getLogin(), account.getPassword(), grantedAuthorities);
    }

    @Override
    public void save(Account account) {
        this.accountRepository.save(account);
    }

    @Override
    public Account findByLogin(String login) {
        return this.accountRepository.findByLogin(login);
    }
}
