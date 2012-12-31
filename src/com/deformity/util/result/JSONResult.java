package com.deformity.util.result;

import com.deformity.util.JSONUtil;
import com.opensymphony.xwork2.ActionInvocation;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.StrutsResultSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;
import java.io.PrintWriter;
import java.util.Date;

public class JSONResult extends StrutsResultSupport
{
  private static final long serialVersionUID = 7115964248053498555L;
  private boolean ignoreHierarchy = false;

  private final Logger log = LoggerFactory.getLogger(super.getClass());

  private boolean ignoreInterfaces = true;

  private boolean enableSMD = false;

  private boolean noCache = false;

  private boolean enableGZIP = false;
  private String root;
  private String roots;
  private String contentType;

  public JSONResult()
  {
  }

  public static JsonConfig configJson(String datePattern)
  {
    JsonConfig jsonConfig = new JsonConfig();
    jsonConfig.setExcludes(new String[] { "" });
    jsonConfig.setIgnoreDefaultExcludes(false);
    jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
    jsonConfig.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor(datePattern));
    return jsonConfig;
  }

  public JSONResult(String location) {
    super(location);
  }

  public String getRoots() {
    return this.roots;
  }

  public void setRoots(String roots) {
    this.roots = roots;
  }

  public String getContentType() {
    return this.contentType;
  }

  public void setContentType(String contentType) {
    this.contentType = contentType;
  }

  public boolean isNoCache() {
    return this.noCache;
  }

  public void setNoCache(boolean noCache) {
    this.noCache = noCache;
  }

  public boolean isEnableSMD() {
    return this.enableSMD;
  }

  public void setEnableSMD(boolean enableSMD) {
    this.enableSMD = enableSMD;
  }

  public boolean isEnableGZIP() {
    return this.enableGZIP;
  }

  public void setEnableGZIP(boolean enableGZIP) {
    this.enableGZIP = enableGZIP;
  }

  public boolean isIgnoreHierarchy() {
    return this.ignoreHierarchy;
  }

  public void setIgnoreHierarchy(boolean ignoreHierarchy) {
    this.ignoreHierarchy = ignoreHierarchy;
  }

  public boolean isIgnoreInterfaces() {
    return this.ignoreInterfaces;
  }

  public void setIgnoreInterfaces(boolean ignoreInterfaces) {
    this.ignoreInterfaces = ignoreInterfaces;
  }

  public String getRoot() {
    return this.root;
  }

  public void setRoot(String root) {
    this.root = root;
  }

  protected void doExecute(String value, ActionInvocation actionInvocation) throws Exception
  {
    try {
      HttpServletResponse response = ServletActionContext.getResponse();
      HttpServletRequest request = ServletActionContext.getRequest();
      if (this.contentType == null) {
        this.contentType = "text/plain; charset=UTF-8";
      }
      response.setContentType(this.contentType);
      if (StringUtils.isNotEmpty(value)) {
        PageContext pageContext = ServletActionContext.getPageContext();
        if (StringUtils.isNotEmpty(this.root)) {
          Object valueRoot = actionInvocation.getStack().findValue(
            this.root);
          if (valueRoot != null) {
            request.setAttribute(this.root + "JSON",
              JSONUtil.toJSON(valueRoot, configJson("yyyy-MM-dd")));
          }
        }
        if (StringUtils.isNotEmpty(this.roots)) {
          String[] ros = this.roots.split(",");
          for (String o : ros) {
            Object valueRoot = actionInvocation.getStack()
              .findValue(o);
            if (valueRoot == null) {
              continue;
            }
            request.setAttribute(o + "JSON",
              JSONUtil.toJSON(valueRoot, configJson("yyyy-MM-dd")));
          }
        }

        if (pageContext != null) {
          pageContext.include(value); return;
        }
        RequestDispatcher dispatcher = request
          .getRequestDispatcher(value);
        if (dispatcher == null) {
          response.sendError(404, "result '" + value +
            "' not found");
          return;
        }
        if ((!(response.isCommitted())) &&
          (request
          .getAttribute("javax.servlet.include.servlet_path") == null)) {
          request.setAttribute("struts.view_uri", value);
          request.setAttribute("struts.request_uri",
            request.getRequestURI());
          dispatcher.forward(request, response); return;
        }
        dispatcher.include(request, response); return;
      }

      if (StringUtils.isNotEmpty(this.root)) {
        Object valueRoot = actionInvocation.getStack().findValue(
          this.root);
        if (valueRoot != null) {
          PrintWriter out = response.getWriter();
          try {
            out.print(JSONUtil.toJSON(valueRoot, configJson("yyyy-MM-dd")));
            out.flush();
          } catch (Exception e) {
            throw e;
          } finally {
            if (out != null)
              out.close();
          }
        }
      }
    }
    catch (Exception e)
    {
      this.log.error(" webpoint - JSONResult Type convert error {}:", e);
      throw new Exception(e);
    }
  }
}