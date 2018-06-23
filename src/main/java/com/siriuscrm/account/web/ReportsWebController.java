package com.siriuscrm.account.web;

import com.siriuscrm.account.db.repository.ContractViewRepository;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.ooxml.JRDocxExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.export.SimpleDocxReportConfiguration;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by asolod on 8/7/2017.
 */
@Controller
@RequestMapping("/reports")
public class ReportsWebController {

    @Autowired
    private BasicDataSource dataSource;

    @Autowired
    private ContractViewRepository contractViewRepository;

    @RequestMapping(value = "/agreement/{contractStateId}", method = RequestMethod.GET, produces = "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    @ResponseBody
    public ResponseEntity getRpt1(@PathVariable("contractStateId") Long contractStateId) throws JRException, IOException, SQLException {
        String path = "/reports/Agreement.jasper";
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("content-disposition", "attachment; filename=" + encodedContractNumber(contractStateId) + ".docx");
        return new ResponseEntity(getAgreement(contractStateId, path, getDocxExporter()).toByteArray(), responseHeaders, HttpStatus.OK);
    }

    private String encodedContractNumber(Long contractStateId) {
        throw new RuntimeException("FIX IT");
/*
        String contractNumber = null; //contractViewRepository.findByContractStateId(contractStateId).getContractNumber();
        contractNumber.replace('П', 'P');
        contractNumber.replace('С', 'S');
        contractNumber.replace('Т', 'T');
        contractNumber.replace('О', 'O');
        return contractNumber;
*/
    }

    private JRAbstractExporter getDocxExporter() {
        JRDocxExporter docxExporter = new JRDocxExporter();
        SimpleDocxReportConfiguration config = new SimpleDocxReportConfiguration();
        config.setFlexibleRowHeight(true); //Set desired configuration
        docxExporter.setConfiguration(config);
        return docxExporter;
    }

    private ByteArrayOutputStream getAgreement(Long contractStateId, String path, JRAbstractExporter exporter) throws JRException, SQLException {
        InputStream jasperStream = this.getClass().getResourceAsStream(path);
        Map<String, Object> params = new HashMap<>();
        params.put("contractStateId", contractStateId);
        params.put("resourceDir", getClass().getResource("/reports/").getPath());
        JasperReport jasperReport = (JasperReport) JRLoader.loadObject(jasperStream);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource.getConnection());

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
        exporter.exportReport();
        return outputStream;
    }

/*
    @RequestMapping(value = "/card/{contractId}", method = RequestMethod.GET, produces = "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    @ResponseBody
    public byte[] getRptCard(@PathVariable("contractId") Long contractId) throws JRException, IOException, SQLException {
        String path = "/reports/receiptDashboard.jasper";
        return getRep(contractId, path, getDocxExporter()).toByteArray();
    }

    @RequestMapping(value = "/receipt/{contractId}", method = RequestMethod.GET, produces = "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    @ResponseBody
    public byte[] getRptReceipt(@PathVariable("contractId") Long contractId) throws JRException, IOException, SQLException {
        String path = "/reports/receiptDashboard.jasper";
        return getRep(contractId, path, new JRPdfExporter()).toByteArray();
    }
*/

}
