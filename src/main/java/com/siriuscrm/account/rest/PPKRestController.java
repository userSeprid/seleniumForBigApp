package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.dao.*;
import com.siriuscrm.account.db.entity.DBConstants;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.db.mapper.PPKSaldoMapper;
import com.siriuscrm.account.db.repository.DashboardCellRepository;
import com.siriuscrm.account.db.repository.DictionaryRepository;
import com.siriuscrm.account.dto.SingleItemDTO;
import com.siriuscrm.account.dto.common.ForwardToItemId;
import com.siriuscrm.account.dto.common.ListDTO;
import com.siriuscrm.account.dto.common.PageDTO;
import com.siriuscrm.account.vo.PPKVO;
import com.siriuscrm.account.vo.extjs.FilterVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@RestController
@RequestMapping(value = "/api/ppk")
public class PPKRestController {

    @Autowired
    private PPKViewDAO ppkViewDAO;

    @Autowired
    private PPKDAO ppkDAO;

    @Autowired
    private DashboardCellRepository dashboardCellRepository;

    @Autowired
    private DictionaryRepository dictionaryRepository;

    @Autowired
    private DictionaryDAO dictionaryDAO;

    @Autowired
    private ContractDAO contractDAO;

    @Autowired
    private PPKPaymentDAO ppkPaymentDAO;

    @Autowired
    private PPKSaldoMapper ppkSaldoMapper;

    public static final SimpleDateFormat SIMPLE_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

    private void copyDictionaryFields(PPKEntity ppk, PPKVO ppkVO) {
        ppk.setManager(dictionaryDAO.getOneOrNull(ppkVO.getManagerId()));
        ppk.setManagerCompany(dictionaryDAO.getOneOrNull(ppkVO.getManagerCompanyId()));
        ppk.setCompany(dictionaryDAO.getOneOrNull(ppkVO.getCompanyId()));
        ppk.setObjectType(dictionaryDAO.getOneOrNull(ppkVO.getObjectTypeId()));
        ppk.setDashboardType(dictionaryDAO.getOneOrNull(ppkVO.getDashboardTypeId()));
        ppk.setRegion(dictionaryDAO.getOneOrNull(ppkVO.getRegionId()));
        ppk.setDashboardSubtype(dictionaryDAO.getOneOrNull(ppkVO.getDashboardSubtypeId()));
        ppk.setCameFrom(dictionaryDAO.getOneOrNull(ppkVO.getCameFromId()));
    }

    private PPKEntity updatePPK(PPKVO ppkVO) {
        PPKEntity ppk = ppkDAO.getRepository().findOne(ppkVO.getId());
        copyDictionaryFields(ppk, ppkVO);
        BeanUtils.copyProperties(ppkVO, ppk, "id", "persons");
        if (DBConstants.PPK_DASHBOARD_TYPES.WITHOUT_CONNECTION.getTypeId().equals(ppkVO.getDashboardTypeId())) { // without connection to PPKEntity
            ppk.setDashboardCell("000");
        }
        ppkDAO.getRepository().save(ppk);
        ppkPaymentDAO.mergePayment(ppk, DBConstants.PaymentType.Z_PAYMENT.getTypeId(), ppkVO.getBalance(), ppkVO.getBalanceDescription());
        return ppk;
    }

    @RequestMapping(value = "/items")
    public PageDTO loadList(
            @RequestParam(value = "filter", defaultValue = "", required = false) String filter,
            @RequestParam(value = "start", defaultValue = "0") Long offset,
            @RequestParam(value = "limit", defaultValue = "50") Long limit
    ) throws IOException {
        FilterVO filterVO = new FilterVO(filter);
        if (filterVO.isEmpty()) {
            return new PageDTO(ppkViewDAO.getRepository().findAllCount(), ppkViewDAO.getRepository().findAll(limit, offset));
        }
        return new PageDTO(ppkViewDAO.getRepository().findByStringCountTotal(filterVO.getValue()), ppkViewDAO.getRepository().findByString(filterVO.getValue()));
    }

    @RequestMapping(value = "/items/sameOwner")
    public ListDTO loadListSameOwner(@RequestParam("ppkId") Long ppkId) {
        return new ListDTO(ppkViewDAO.getRepository().findAllSameOwner(ppkId));
    }

    @RequestMapping(value = "/items/byAdvisor")
    public ListDTO loadListByAdvisor(@RequestParam("ppkId") Long ppkId) {
        return new ListDTO(ppkViewDAO.getRepository().loadListByAdvisor(ppkId));
    }

    @RequestMapping(value = "/item", method = RequestMethod.GET)
    public SingleItemDTO loadById(@RequestParam(value = "id") Long id) {
        return new SingleItemDTO(ppkViewDAO.getRepository().getOne(id));
    }


    @RequestMapping(value = "/item", method = RequestMethod.PUT, produces = {MediaType.APPLICATION_JSON_VALUE})
    public Object update(@RequestBody PPKVO ppkVO) throws IOException, ParseException {
        return new ForwardToItemId(updatePPK(ppkVO).getId());
    }

    @RequestMapping(value = "/item/disable/{ppkId}", method = RequestMethod.PUT, produces = {MediaType.APPLICATION_JSON_VALUE})
    public void disable(@PathVariable Long ppkId) {
        PPKEntity ppkEntityEntity = ppkDAO.getRepository().getOne(ppkId);
        ppkEntityEntity.setStatusId(DBConstants.PPKState.DISABLED.getTypeId());
        ppkDAO.getRepository().save(ppkEntityEntity);
    }


}
