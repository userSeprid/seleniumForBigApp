package com.siriuscrm.account.db.service;

import com.siriuscrm.account.db.repository.PPKRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PPKServiceImpl implements PPKService {

    @Autowired
    private PPKRepository ppkRepository;

}
