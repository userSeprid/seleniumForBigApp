package com.siriuscrm.account.web;

import com.siriuscrm.account.db.dao.PPKDAO;
import com.siriuscrm.account.db.entity.DBConstants;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.db.repository.PPKRequiredDocumentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Date;

@Controller
public class PPKWebController {

    @Autowired
    private PPKDAO ppkDAO;

    @Autowired
    private PPKRequiredDocumentRepository ppkRequiredDocumentRepository;

    @RequestMapping(value = "/ppkList", method = RequestMethod.GET)
    public String contractList(Model model) {
        return "ppkList";
    }

    @RequestMapping(value = "/viewPPK", method = RequestMethod.GET)
    public String view() {
        return "viewPPK";
    }

    @RequestMapping(value = "/createPPK", method = RequestMethod.GET)
    public String createPPK(Model model) {
        PPKEntity ppk = new PPKEntity();
        ppk.setCreateDate(new Date());
        ppkDAO.getRepository().save(ppk);
        ppkRequiredDocumentRepository.copyRequiredDocuments(ppk.getId(), DBConstants.TYPES.PPK_REQUIRED_DOCUMENTS.getTypeId(),
                DBConstants.REQUIRED_DOCUMENT_STATUS.NOT_EXISTS.getTypeId());
        return "redirect:/viewPPK?id=" + ppk.getId();
    }


}
