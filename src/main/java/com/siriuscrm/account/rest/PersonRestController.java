package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.dao.PersonDAO;
import com.siriuscrm.account.db.entity.PPKPersonEntity;
import com.siriuscrm.account.db.entity.PersonEntity;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import com.siriuscrm.account.db.repository.PPKPersonRepository;
import com.siriuscrm.account.db.repository.PPKPersonViewRepository;
import com.siriuscrm.account.db.repository.PPKRequiredDocumentRepository;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.dto.common.PageDTO;
import com.siriuscrm.account.vo.PPKPersonVO;
import com.siriuscrm.account.vo.PersonVO;
import com.siriuscrm.account.vo.extjs.FilterVO;
import com.siriuscrm.account.vo.extjs.SortVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class PersonRestController {

    @Autowired
    private PersonDAO personDAO;

    @Autowired
    private PPKPersonRepository ppkPersonRepository;

    @Autowired
    private PPKPersonViewRepository ppkPersonViewRepository;

    @Autowired
    private PPKRequiredDocumentRepository ppkRequiredDocumentRepository;

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @RequestMapping(value = "/person/items", method = RequestMethod.GET)
    public PageDTO loadList(@RequestParam(value = "start") Integer offset,
                            @RequestParam(value = "limit") Integer limit,
                            @RequestParam("sort") String sortObject,
                            @RequestParam("filter") String filterObject) {
        SortVO sortVO = new SortVO(sortObject);
        FilterVO filterVO = new FilterVO(filterObject);
        return new PageDTO(personDAO.getRepository().findCount(filterVO.getValue()), personDAO.findPage(sortVO, filterVO, offset, limit));
    }

    @RequestMapping(value = "/person/item", method = RequestMethod.POST)
    public ResponseEntity createPerson(@RequestBody PersonVO personVO) {
        PersonEntity personEntity = new PersonEntity();
        BeanUtils.copyProperties(personVO, personEntity, "id");
        personEntity.setType(dictionaryRepository.getOne(personVO.getTypeId()));
        personDAO.getRepository().save(personEntity);
        return new ResponseEntity<>("{success: true}", HttpStatus.OK);
    }

    @RequestMapping(value = "/person/item", method = RequestMethod.PUT)
    public ResponseEntity updatePerson(@RequestBody PersonVO personVO) {
        PersonEntity personEntity = personDAO.getRepository().getOne(personVO.getId());
        BeanUtils.copyProperties(personVO, personEntity, "id");
        personDAO.getRepository().save(personEntity);
        return new ResponseEntity<>("{success: true}", HttpStatus.OK);
    }

    @RequestMapping(value = "/ppkperson/items", method = RequestMethod.GET)
    public ListDTO loadList(@RequestParam("ppkId") Long ppkId) {
        return new ListDTO(ppkPersonViewRepository.findByPpkId(ppkId));
    }

    @RequestMapping(value = "/ppkperson/item", method = RequestMethod.POST)
    public ResponseEntity addPPKPerson(@RequestBody PPKPersonVO ppkPersonVO) {
        PPKPersonEntity ppkPersonEntity = new PPKPersonEntity();
        ppkPersonEntity.setPpkId(ppkPersonVO.getPpkId());
        ppkPersonEntity.setPersonId(ppkPersonVO.getPersonId());
        ppkPersonRepository.save(ppkPersonEntity);
        return new ResponseEntity<>("{success: true}", HttpStatus.OK);
    }

    @RequestMapping(value = "/ppkperson/item", method = RequestMethod.PUT)
    public ResponseEntity updatePPKPerson(@RequestBody PPKPersonVO ppkPersonVO) {
        PersonEntity personEntity = personDAO.getRepository().getOne(ppkPersonVO.getPersonId());
        BeanUtils.copyProperties(ppkPersonVO, personEntity);
        personDAO.getRepository().save(personEntity);
        PPKPersonEntity ppkPersonEntity = ppkPersonRepository.getOne(new PPKPersonEntity.PPKPersonEntityId(ppkPersonVO.getPpkId(), ppkPersonVO.getPersonId()));
        BeanUtils.copyProperties(ppkPersonVO, ppkPersonEntity);
        if (personEntity.getType().getId() == 98) {
            ppkPersonEntity.setOwner(false);
            ppkPersonEntity.setPayer(false);
        }
        ppkPersonRepository.save(ppkPersonEntity);
        return new ResponseEntity<>("{success: true}", HttpStatus.OK);
    }

}
