package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.entity.ppk.PPKReminderEntity;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import com.siriuscrm.account.db.repository.PPKReminderRepository;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.vo.PPKReminderVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ppkReminder")
public class PPKReminderRestController {

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @Autowired
    private PPKReminderRepository ppkReminderRepository;


    @RequestMapping("/items")
    public ListDTO items(@RequestParam(value = "ppkId") Long ppkId) {
        return new ListDTO(ppkReminderRepository.findByPpkId(ppkId));
    }

    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public void create(@RequestBody PPKReminderVO ppkReminderVO) {
        PPKReminderEntity ppkReminder = new PPKReminderEntity();
        BeanUtils.copyProperties(ppkReminderVO, ppkReminder, "id");
        ppkReminder.setType(dictionaryRepository.findOne(ppkReminderVO.getTypeId()));
        ppkReminderRepository.save(ppkReminder);
    }

    @RequestMapping(value = "/item", method = RequestMethod.PUT)
    public void update(@RequestBody PPKReminderVO ppkReminderVO) {
        PPKReminderEntity ppkReminder = ppkReminderRepository.findOne(ppkReminderVO.getId());
        BeanUtils.copyProperties(ppkReminderVO, ppkReminder);
        ppkReminder.setType(dictionaryRepository.findOne(ppkReminderVO.getTypeId()));
        ppkReminderRepository.save(ppkReminder);
    }

}
