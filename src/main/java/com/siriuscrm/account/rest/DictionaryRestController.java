package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.dao.DictionaryDAO;
import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.vo.DictionaryEditingVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/dictionary")
public class DictionaryRestController {

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @RequestMapping("/findByParentId")
    public ListDTO findById(@RequestParam(value = "parentId") Long parentId) {
        List<DictionaryItem> list = dictionaryRepository.findByParentId(parentId);
        return new ListDTO(list);
    }

    @RequestMapping("/findByParentOfParentsId")
    public ListDTO findByParentOfParentsId(@RequestParam(value = "parentId") Long parentId) {
        return new ListDTO(dictionaryRepository.findByParentOfParentsId(parentId));
    }

    @RequestMapping("/items")
    public ListDTO items(@RequestParam(value = "parentId") Long parentId) {
        return new ListDTO(dictionaryRepository.findByParentIdOrderById(parentId));
    }

    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public void create(@RequestBody DictionaryEditingVO dictionaryEditingVO) {
        DictionaryItem dictionaryItem = new DictionaryItem();
        BeanUtils.copyProperties(dictionaryEditingVO, dictionaryItem, "id");
        dictionaryRepository.save(dictionaryItem);
    }

    @RequestMapping(value = "/item", method = RequestMethod.PUT)
    public void update(@RequestBody DictionaryEditingVO dictionaryEditingVO) {
        DictionaryItem dictionaryItem = dictionaryRepository.findOne(dictionaryEditingVO.getId());
        BeanUtils.copyProperties(dictionaryEditingVO, dictionaryItem, "id");
        dictionaryRepository.save(dictionaryItem);
    }
}
