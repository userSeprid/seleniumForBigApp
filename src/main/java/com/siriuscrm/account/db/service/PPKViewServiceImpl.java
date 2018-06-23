package com.siriuscrm.account.db.service;

import com.siriuscrm.account.db.repository.PPKViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PPKViewServiceImpl implements PPKViewService {

    @Autowired
    private PPKViewRepository ppkViewRepository;

}
