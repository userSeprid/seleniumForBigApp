package com.siriuscrm.account.db.dao;

import com.siriuscrm.account.db.repository.PPKViewRepository;
import com.siriuscrm.account.db.service.PPKViewService;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Data
public class PPKViewDAO {

    @Autowired
    private PPKViewRepository repository;

    @Autowired
    private PPKViewService service;

}
