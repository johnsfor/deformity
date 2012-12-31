package com.deformity.common;

import com.deformity.common.baseService.BaseService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Results({
        @Result(name = "jsonResult", type = "json", params = {"root", "result"}),
        @Result(name = "jsonUpload", type = "json", params = {"contentType", "text/html"})//文件上传返回配置
})
public class BaseAction extends ActionSupport {
    /**
     * tydic分页*
     */
    private Integer curPage = 1; //当前页
    private Integer size = 20;//最大行数
    protected String sqlName; //ibatisSQLid
    protected Long fileId; //附件id
    protected Map<String, Object> conditions; //查询条件
    protected BaseService baseService;


    /**
     * 组合分页条件
     *
     * @param par 原条件
     * @return Map
     */
    protected Map<String, Object> getConditions(Map<String, Object> par) {
        Map<String, Object> resultParams = new HashMap<String, Object>();
        if (par != null) {
            for (String conditionKey : par.keySet()) {
                if (par.get(conditionKey) == null) break;
                if (!(par.get(conditionKey) instanceof Object[]))
                    break;
                if (conditionKey.endsWith("_INT")) {
                    String t = ((Object[]) par.get(conditionKey))[0].toString();
                    resultParams.put(conditionKey.substring(0, conditionKey.length() - 4), t == null || t.equals("") ? "" : Long.parseLong(t));
                    continue;
                }
                resultParams.put(conditionKey, ((Object[]) par.get(conditionKey))[0]);

            }

        }

        if (resultParams.get("curPage") == null) {
            resultParams.put("curPage", this.curPage);
        }
        if (resultParams.get("size") == null) {
            resultParams.put("size", this.size);
        }

        resultParams.put("minSize", this.size * (this.curPage - 1) + 1);
        resultParams.put("maxSize", this.size * this.curPage);

        return resultParams;
    }

    /**
     * 包装页面传来参数
     *
     * @param par 原条件
     * @return Map
     */
    protected Map<String, Object> makeCondition(Map<String, Object> par) {
        Map<String, Object> resultParams = new HashMap<String, Object>();
        if (par != null) {
            for (String conditionKey : par.keySet()) {
                if (par.get(conditionKey) == null) break;
                if (!(par.get(conditionKey) instanceof Object[]))
                    break;
                if (conditionKey.endsWith("_INT")) {
                    String t = ((Object[]) par.get(conditionKey))[0].toString();
                    resultParams.put(conditionKey.substring(0, conditionKey.length() - 4), t == null || t.equals("") ? "" : Long.parseLong(t));
                    continue;
                }
                resultParams.put(conditionKey, (String) ((Object[]) par.get(conditionKey))[0]);
            }

        }
        return resultParams;
    }

    /**
     * jquery分页查询
     * @throws SQLException
     */
	public String findList() throws SQLException {
        List list = this.baseService.findList(sqlName, new HashMap());//注意此处方法包装了分页用到的参数
        Long totalCount = (Long) this.baseService.findListTotal(sqlName + "Count", conditions);
        Map resultMap = new HashMap();
        resultMap.put("total", totalCount);
        resultMap.put("rows", list);
        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }
    /**
     * 导出全部
     */
    public String expAll() {
        Map<String, Object> paramMap = makeCondition(conditions);
        String fileName = String.valueOf(paramMap.get("fileName"));
        HttpServletResponse response = ServletActionContext.getResponse();
        response.reset();
        //response.setContentType("application/x-download");
        response.setContentType("application/vnd.ms-excel;charset=GBK");
        response.addHeader("Content-Disposition", "attachment;filename=" + fileName + ".xls");
        try {
            OutputStream output = response.getOutputStream();

            List<LinkedHashMap> list = this.baseService.findList(sqlName, paramMap);
            StringBuffer sb = new StringBuffer();
            sb.append("<html><meta http-equiv='Content-Type' content='text/html; charset=GBK'><body>");
            sb.append("<table border='1'>");
            if (list.size() == 0) {
                sb.append("<tr><td>无数据</td></tr>");
            }
            int flag = 1;
            for (LinkedHashMap map : list) {
                if (1 == flag) {
                    java.util.Iterator iterTitle = map.entrySet().iterator();
                    sb.append("<tr>");
                    while (iterTitle.hasNext()) {
                        java.util.Map.Entry entry = (java.util.Map.Entry) iterTitle.next();
                        sb.append("<th>" + String.valueOf(entry.getKey()) + "</th>");
                    }
                    sb.append("</tr>");
                    flag = 2;

                }
                java.util.Iterator iter = map.entrySet().iterator();
                sb.append("<tr>");
                while (iter.hasNext()) {
                    java.util.Map.Entry entry = (java.util.Map.Entry) iter.next();
                    sb.append("<td>" + String.valueOf(entry.getValue()) + "</td>");
                }
                sb.append("</tr>");
            }
            sb.append("</table></body></html>");
            byte[] buffer = sb.toString().getBytes();
            output.write(buffer);
            output.flush();
            output.close();
            output = null;
        } catch (Exception ex) {

        }
        return NONE;
    }

    public String findWithOutCount() throws SQLException {
        List list = this.baseService.findList(sqlName, getConditions(conditions));//注意此处方法包装了分页用到的参数
        Map resultMap = new HashMap();
        resultMap.put("rowTotal", list.size());
        resultMap.put("infoContent", list);

        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }


    /**
     * 修改查询
     *
     * @return obj
     * @throws SQLException 
     */
    public String findById() throws SQLException {
        Object obj = this.baseService.findById(sqlName, makeCondition(conditions));//包装页面传来参数
        Map resultMap = new HashMap();
        resultMap.put("obj", obj);
        ServletActionContext.getRequest().setAttribute("latn_id", ((Map) resultMap.get("obj")).get("lan_id"));
        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }

    /**
     * 得到一个Long值
     *
     * @return Long
     * @throws SQLException 
     */
    public String findNumById() throws SQLException {
        Long obj = this.baseService.findListTotal(sqlName, makeCondition(conditions));//包装页面传来参数
        Map resultMap = new HashMap();
        resultMap.put("obj", obj);
        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }

    /**
     * 修改查询
     *
     * @return List
     * @throws SQLException 
     */
    public String findBySqlId() throws SQLException {
        Object obj = this.baseService.findList(sqlName, makeCondition(conditions));//注意此处方法包装了分页用到的参数
        Map resultMap = new HashMap();
        resultMap.put("obj", obj);
        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }

    /**
     * 修改保存
     */
    public String modifySave() {
        Map resultMap = new HashMap();
        try {
            this.baseService.updateObject(sqlName, makeCondition(conditions));
            resultMap.put("tip", "修改成功");
        } catch (Exception ex) {
            resultMap.put("tip", "修改失败：" + ex.getMessage());
            ServletActionContext.getContext().getValueStack().set("result", resultMap);
            return "jsonResult";
        }
        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }

    /**
     * 新增保存
     */
    public String addSave() {
        Map resultMap = new HashMap();
        try {
            this.baseService.addObject(this.sqlName, makeCondition(conditions));
            resultMap.put("tip", "新增成功");
        } catch (Exception ex) {
            resultMap.put("tip", "新增失败：" + ex.getMessage());
            ServletActionContext.getContext().getValueStack().set("result", resultMap);
            return "jsonResult";
        }

        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }

    public String del() {
        Map resultMap = new HashMap();
        try {
            this.baseService.delObject(this.sqlName, makeCondition(conditions));
            resultMap.put("tip", "删除成功");
        } catch (Exception ex) {
            resultMap.put("tip", "删除失败：" + ex.getMessage());
            ServletActionContext.getContext().getValueStack().set("result", resultMap);
            return "jsonResult";
        }

        ServletActionContext.getContext().getValueStack().set("result", resultMap);
        return "jsonResult";
    }



    public BaseService getBaseService() {
		return baseService;
	}

	public void setBaseService(BaseService baseService) {
		this.baseService = baseService;
	}

	public Map<String, Object> getConditions() {
        return conditions;
    }

    public void setConditions(Map<String, Object> conditions) {
        this.conditions = conditions;
    }

    public String getSqlName() {
        return sqlName;
    }

    public void setSqlName(String sqlName) {
        this.sqlName = sqlName;
    }


    public Integer getCurPage() {
        return curPage;
    }

    public void setCurPage(Integer curPage) {
        this.curPage = curPage;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Long getFileId() {
        return fileId;
    }

    public void setFileId(Long fileId) {
        this.fileId = fileId;
    }

    //    文件上传
    public void fileupload() throws Exception {
        MultiPartRequestWrapper req = (MultiPartRequestWrapper) ServletActionContext.getRequest();
        String fileName[] = req.getFileNames("upload");
        Map resultMap = new HashMap();
        String error = "";
        Long fileSeq = -1L;
        if (fileName.length > 0) {

            File file[] = req.getFiles("upload");

            FileBean fileBean = new FileBean();

            fileBean.setFile_name(fileName);
            fileBean.setFiles(file);

            try {
                if (sqlName.equals("insert") || fileId == null) {
                    fileSeq = baseService.getFileSeq("common.getFileSeq");//拿到文件seq
                    fileBean.setFile_id(fileSeq);
                    baseService.attachInsert(fileBean);
                } else if (sqlName.equals("update") || fileId != null) {
                    fileBean.setFile_id(fileId);
                    baseService.attachUpdate(fileBean);
                }


            } catch (Exception ex) {
                error = "error";

            }
        }

        HttpServletResponse response = ServletActionContext.getResponse();
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        out.write("{error:'" + error + "',msg:'" + fileSeq + "'}");
    }

    //    文件下载
    public void filedown() throws Exception {
        try {
            Map con = makeCondition(conditions);
            HttpServletResponse response = ServletActionContext.getResponse();
            InputStream is = baseService.attachDown((String) con.get("id"));
            BufferedInputStream br = new BufferedInputStream(is);
            byte[] buf = new byte[1024];
            int len = 0;
            response.reset(); // 非常重要
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode((String) con.get("name"), "UTF-8"));
            OutputStream out = response.getOutputStream();
            while ((len = br.read(buf)) > 0)
                out.write(buf, 0, len);
            // 纯下载方式

            br.close();
            out.close();
        } catch (RuntimeException e) {
        }

    }


}
