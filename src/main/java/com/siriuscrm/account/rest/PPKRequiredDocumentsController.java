package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.entity.PPKRequiredDocumentEntity;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import com.siriuscrm.account.db.repository.PPKRequiredDocumentRepository;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.vo.PPKRequiredDocumentVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ppkRequiresDocuments")
public class PPKRequiredDocumentsController {

    @Autowired
    private PPKRequiredDocumentRepository ppkRequiredDocumentRepository;

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @RequestMapping("/items")
    public ListDTO loadByPpkId(@RequestParam(value = "ppkId") Long ppkId) {
        return new ListDTO(ppkRequiredDocumentRepository.findByPpkIdOrderByTitle(ppkId));
    }

    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public ResponseEntity createPPKRequiresDocument(@RequestBody PPKRequiredDocumentVO requiredDocumentVO) {
        PPKRequiredDocumentEntity requiredDocumentEntity = new PPKRequiredDocumentEntity();
        BeanUtils.copyProperties(requiredDocumentVO, requiredDocumentEntity, "id");
        requiredDocumentEntity.setStatus(dictionaryRepository.findOne(requiredDocumentVO.getStatusId()));
        ppkRequiredDocumentRepository.save(requiredDocumentEntity);
        return new ResponseEntity<>("{success: true}", HttpStatus.OK);
    }

    @RequestMapping(value = "/item", method = RequestMethod.PUT)
    public ResponseEntity updatePPKRequiresDocument(@RequestBody PPKRequiredDocumentVO requiredDocumentVO) {
        PPKRequiredDocumentEntity requiredDocumentEntity = ppkRequiredDocumentRepository.getOne(requiredDocumentVO.getId());
        BeanUtils.copyProperties(requiredDocumentVO, requiredDocumentEntity);
        requiredDocumentEntity.setStatus(dictionaryRepository.findOne(requiredDocumentVO.getStatusId()));
        ppkRequiredDocumentRepository.save(requiredDocumentEntity);
        return new ResponseEntity<>("{success: true}", HttpStatus.OK);
    }

    @RequestMapping(value = "/item/{id}", method = RequestMethod.DELETE)
    public ResponseEntity deletePPKRequiresDocument(@PathVariable(value = "id") Long id) {
        ppkRequiredDocumentRepository.delete(id);
        return new ResponseEntity<>("{success: true}", HttpStatus.OK);
    }
}
