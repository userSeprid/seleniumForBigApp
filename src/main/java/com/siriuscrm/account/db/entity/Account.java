package com.siriuscrm.account.db.entity;


import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "account")
public class Account {
    private Long id;
    private String login;
    private String password;
    private String passwordConfirm;
    private Set<AccessLevel> accessLevels;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Transient
    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    @ManyToMany
    @JoinTable(name = "account_access_level", joinColumns = @JoinColumn(name = "account_id"), inverseJoinColumns = @JoinColumn(name = "access_level_id"))
    public Set<AccessLevel> getAccessLevels() {
        return accessLevels;
    }

    public void setAccessLevels(Set<AccessLevel> accessLevels) {
        this.accessLevels = accessLevels;
    }
}
