package com.siriuscrm.account.db.dao;

import com.siriuscrm.account.db.repository.PPKRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Data
public class PPKDAO {

    @Autowired
    private PPKRepository repository;

}
