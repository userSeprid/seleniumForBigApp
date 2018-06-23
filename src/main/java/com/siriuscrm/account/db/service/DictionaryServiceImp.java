package com.siriuscrm.account.db.service;

import com.siriuscrm.account.db.repository.DictionaryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DictionaryServiceImp implements DictionaryService {

    @Autowired
    DictionaryRepository dictionaryRepository;

}
