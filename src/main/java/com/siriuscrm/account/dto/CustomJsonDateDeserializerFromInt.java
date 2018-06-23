package com.siriuscrm.account.dto;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;
import java.util.Date;

public class CustomJsonDateDeserializerFromInt extends JsonDeserializer<Date> {

    @Override
    public Date deserialize(JsonParser jsonparser,
                            DeserializationContext deserializationcontext) throws IOException {
        return new Date(Long.parseLong(jsonparser.getText()) * 1000);
    }

}
