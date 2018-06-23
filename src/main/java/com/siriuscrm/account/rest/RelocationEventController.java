package com.siriuscrm.account.rest;

import com.siriuscrm.account.db.repository.RelocationEventRepository;
import com.siriuscrm.account.dto.common.ListDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping(value = "/api/relocation")
public class RelocationEventController {


    @Autowired
    private RelocationEventRepository relocationEventRepository;

    @RequestMapping(value = "/items", method = RequestMethod.GET)
    public ListDTO loadList() throws IOException {
        return new ListDTO(relocationEventRepository.getLatestLocations());
    }
}
