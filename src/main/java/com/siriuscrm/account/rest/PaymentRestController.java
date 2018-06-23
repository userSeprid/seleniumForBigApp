package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.dao.PPKDAO;
import com.siriuscrm.account.db.dao.PPKPaymentDAO;
import com.siriuscrm.account.db.entity.payment.PPKPaymentEntity;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.vo.PaymentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Arrays;

@RestController
@RequestMapping(value = "/api/payment")
public class PaymentRestController {

    @Autowired
    private PPKDAO ppkDAO;

    @Autowired
    private PPKPaymentDAO ppkPaymentDAO;

    @RequestMapping(value = "/items", method = RequestMethod.GET)
    public ListDTO loadList(@RequestParam(value = "ppkId") Long ppkId) throws IOException {
        return new ListDTO((ppkPaymentDAO.getRepository().findByPpkIdOrderByCreateDateAscIdAsc(ppkId)));
    }

    @RequestMapping(value = "/credit/items", method = RequestMethod.GET)
    public ListDTO loadCreditList(@RequestParam(value = "ppkId") Long ppkId) throws IOException {
        return new ListDTO((ppkPaymentDAO.getRepository().findByPpkIdAndTypeIdInOrderByCreateDateAscIdAsc(ppkId, Arrays.asList(103L))));
    }

    @RequestMapping(value = "/debit/items", method = RequestMethod.GET)
    public ListDTO loadDebitList(@RequestParam(value = "ppkId") Long ppkId) throws IOException {
        return new ListDTO((ppkPaymentDAO.getRepository().findByPpkIdAndTypeIdInOrderByCreateDateAscIdAsc(ppkId, Arrays.asList(104L))));
    }

    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public ListDTO createPayment(@RequestBody PaymentVO paymentVO) throws IOException {
        ppkPaymentDAO.createPayment(ppkDAO.getRepository().getOne(paymentVO.getPpkId()), paymentVO.getTypeId(), paymentVO.getAmount());
        return null;
    }

    @RequestMapping(value = "/item", method = RequestMethod.PUT)
    public ListDTO updatePayment(@RequestBody PaymentVO paymentVO) throws IOException {
        PPKPaymentEntity ppkPaymentEntity = ppkPaymentDAO.getRepository().getOne(paymentVO.getId());
        ppkPaymentEntity.setAmount(paymentVO.getAmount());
        ppkPaymentDAO.getRepository().save(ppkPaymentEntity);
        return null;
    }

}
