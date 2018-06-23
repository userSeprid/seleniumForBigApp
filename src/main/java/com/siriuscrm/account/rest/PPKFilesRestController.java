package com.siriuscrm.account.rest;

import com.siriuscrm.account.db.dao.PPKDAO;
import com.siriuscrm.account.db.dao.PPKFilesDAO;
import com.siriuscrm.account.db.entity.PPKFiles;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.vo.PPKFilesVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.xml.bind.DatatypeConverter;
import java.io.IOException;

@RestController
@RequestMapping(value = "/api/ppkFiles")
public class PPKFilesRestController {

    @Autowired
    private PPKDAO ppkDAO;

    @Autowired
    private PPKFilesDAO ppkFilesDAO;

    public static enum PPKFileType {
        SCHEME, MAP, MAP_DETAILS
    }

    @ResponseBody
    @RequestMapping(value = "/files/{ppkId}/{type}", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
    public byte[] contractFile(@PathVariable Long ppkId, @PathVariable String type) throws IOException {
        PPKFiles ppkFiles = ppkFilesDAO.getPpkFilesRepository().findByPpkId(ppkId);
        if (ppkFiles == null) {
            return null;
        }
        try {
            switch (PPKFileType.valueOf(type.toUpperCase())) {
                case SCHEME:
                    return ppkFiles.getScheme();
                case MAP:
                    return ppkFiles.getMap();
                case MAP_DETAILS:
                    return ppkFiles.getMapDetails();
            }
        } catch (IllegalArgumentException ex) {
            return null;
        }
        return null;
    }

    @RequestMapping(value = "/updateFiles")
    public ResponseEntity updateImages(@RequestBody PPKFilesVO ppkFilesVO) {
        PPKEntity ppkEntity = ppkDAO.getRepository().getOne(ppkFilesVO.getPpkId());
        PPKFiles ppkFiles = ppkEntity.getFiles();
        if (ppkFiles == null) {
            ppkFiles = new PPKFiles();
            ppkFiles.setPpk(ppkEntity);
            ppkEntity.setFiles(ppkFiles);
        }
        if (ppkFilesVO.getScheme() != null && !ppkFilesVO.getScheme().contains("/api")) {
            ppkEntity.getFiles().setScheme(DatatypeConverter.parseBase64Binary(ppkFilesVO.getScheme().split(",")[1]));
        }
        if (ppkFilesVO.getMap() != null && !ppkFilesVO.getMap().contains("/api")) {
            ppkEntity.getFiles().setMap(DatatypeConverter.parseBase64Binary(ppkFilesVO.getMap().split(",")[1]));
        }
        if (ppkFilesVO.getMapDetails() != null && !ppkFilesVO.getMapDetails().contains("/api")) {
            ppkEntity.getFiles().setMapDetails(DatatypeConverter.parseBase64Binary(ppkFilesVO.getMapDetails().split(",")[1]));
        }
        ppkFilesDAO.getPpkFilesRepository().save(ppkFiles);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
