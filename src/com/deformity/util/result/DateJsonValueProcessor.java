package com.deformity.util.result;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateJsonValueProcessor
        implements JsonValueProcessor {
    public static final String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";
    private DateFormat dateFormat;

    public DateJsonValueProcessor(String datePattern) {
        if (datePattern == null)
            this.dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        else
            this.dateFormat = new SimpleDateFormat(datePattern);
    }

    public Object processArrayValue(Object arg0, JsonConfig arg1) {
        return process(arg0);
    }

    public Object processObjectValue(String arg0, Object arg1, JsonConfig arg2) {
        return process(arg1);
    }

    private Object process(Object value) {
        if (value == null) {
            return "";
        }
        return this.dateFormat.format((Date) value);
    }
}
