package com.siriuscrm.account.dto;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CustomJsonDateDeserializerFromString extends JsonDeserializer<Date> {

    public static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

    @Override
    public Date deserialize(JsonParser jsonparser,
                            DeserializationContext deserializationcontext) throws IOException {
        try {
            return formatter.parse(jsonparser.getText());
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

}
