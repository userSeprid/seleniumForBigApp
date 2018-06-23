package com.siriuscrm.account.db.dao;

import com.siriuscrm.account.db.repository.PersonRepository;
import com.siriuscrm.account.vo.extjs.FilterVO;
import com.siriuscrm.account.vo.extjs.SortVO;
import lombok.Data;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.List;

@Component
@Data
public class PersonDAO {

    @Autowired
    private PersonRepository repository;

    @Autowired
    private EntityManager entityManager;

    @Transactional
    public List findPage(SortVO sortVO, FilterVO filterVO, Integer offset, Integer limit) {
        List list = entityManager.unwrap(Session.class)
                .createQuery("from PersonEntity where name like " + filterVO.getValue() + " or phone like " + filterVO.getValue() + "  order by " + sortVO.getProperty() + " " + sortVO.getDirection())
                .setFirstResult(offset).setMaxResults(limit).list();
        return list;
    }

}
