package com.deformity.demo.action;


import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.deformity.common.BaseAction;

@Results({
        @Result(name = "jsonResult", type = "json", params = {"root", "result"})
})
public class DemoAction extends BaseAction {

}