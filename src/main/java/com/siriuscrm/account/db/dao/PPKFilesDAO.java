package com.siriuscrm.account.db.dao;

import com.siriuscrm.account.db.repository.PPKFilesRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Data
@Component
public class PPKFilesDAO {

    @Autowired
    private PPKFilesRepository ppkFilesRepository;

}
