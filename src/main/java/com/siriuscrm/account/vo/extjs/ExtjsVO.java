package com.siriuscrm.account.vo.extjs;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.collections.map.HashedMap;

import java.io.IOException;
import java.util.Map;

public abstract class ExtjsVO {

    static final ObjectMapper mapper = new ObjectMapper();

    protected Map<String, String> parameters;

    public ExtjsVO(String sortParameter) {
        try {
            this.parameters = mapper.readValue(sortParameter.substring(1, sortParameter.length() - 1), HashedMap.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
