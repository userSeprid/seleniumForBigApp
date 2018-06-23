package com.siriuscrm.account.rest;


import com.siriuscrm.account.db.repository.DashboardCellRepository;
import com.siriuscrm.account.dto.common.ListDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping(value = "/api/dashboard")
public class DashboardRestController {

    @Autowired
    private DashboardCellRepository dashboardCellRepository;

    @RequestMapping(value = "/availableCells", method = RequestMethod.GET)
    public ListDTO loadList(@RequestParam(value = "dashboardTypeId") Integer dashboardTypeId, @RequestParam(value = "dashboardSubtypeId") Integer dashboardSubtypeId,
                            @RequestParam(value = "dashboardNumber") Integer dashboardNumber) throws IOException {
        if (dashboardSubtypeId == null || dashboardSubtypeId == null || dashboardNumber == null) {
            return new ListDTO(null);
        }
        return new ListDTO(dashboardCellRepository.getAllEmptyCells(dashboardTypeId, dashboardSubtypeId, dashboardNumber));
    }

}
