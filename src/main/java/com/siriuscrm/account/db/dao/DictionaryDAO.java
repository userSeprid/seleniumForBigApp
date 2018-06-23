package com.siriuscrm.account.db.dao;

import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Data
public class DictionaryDAO {

    @Autowired
    DictionaryRepository dictionaryRepository;

    public DictionaryItem getOneOrNull(Long id) {
        if (id == null) {
            return null;
        } else {
            return dictionaryRepository.getOne(id);
        }
    }
}
