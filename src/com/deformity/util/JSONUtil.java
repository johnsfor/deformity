package com.deformity.util;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Vector;

public class JSONUtil
{
  public static Object toJSON(Object v)
    throws Exception
  {
    if ((v instanceof Object[]) || (v instanceof int[]) ||
      (v instanceof short[]) || (v instanceof boolean[]) ||
      (v instanceof long[]) || (v instanceof float[]) ||
      (v instanceof Collection) || (v instanceof Vector)) {
      JSONArray jsonArray = JSONArray.fromObject(v);
      return jsonArray.toString();
    }

    JSONObject json = JSONObject.fromObject(v);
    return json.toString();
  }

  public static Object toJSON(Object v, JsonConfig jsonConfig) throws Exception
  {
    if ((v instanceof Object[]) || (v instanceof int[]) ||
      (v instanceof short[]) || (v instanceof boolean[]) ||
      (v instanceof long[]) || (v instanceof float[]) ||
      (v instanceof Collection) || (v instanceof Vector)) {
      JSONArray jsonArray = JSONArray.fromObject(v,
        jsonConfig);
      return jsonArray.toString();
    }

    JSONObject json = JSONObject.fromObject(v, jsonConfig);
    return json.toString();
  }

  public static List toObject(String jsonString, Class clazz)
    throws Exception
  {
    throw new Exception();
  }

  public static List toList(String jsonString, Class clazz) throws Exception
  {
    JSONArray jsonArray = JSONArray.fromObject(jsonString);
    List list = new ArrayList();

    for (int i = 0; i < jsonArray.size(); ++i)
    {
      Object object = clazz.newInstance();

      JSONObject jsonObject = jsonArray.getJSONObject(i);

      object = JSONObject.toBean(jsonObject, clazz);

      list.add(object);
    }
    return list;
  }
}