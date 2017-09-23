<%-- @elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.NoticeTmplListVo" --%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/param/siteParam.html" method="post" id="siteParam">
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['站点参数']}</span>
    </div>
  <div class="col-lg-12">
      <div class="wrapper white-bg shadow">
          <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
              <ul class="clearfix sys_tab_wrap">
                  <shiro:hasPermission name="system:siteparam_setting">
                      <li id="li_top_1" class="<c:if test="${'li_top_1'.equals(index)}">active</c:if>">
                          <soul:button target="basicSettingIndex" text="${views.setting['setting.parameter.basic']}" opType="function"></soul:button>
                      </li>
                  </shiro:hasPermission>
                  <shiro:hasPermission name="system:siteparam_preference">
                      <li id="li_top_2" class="<c:if test="${'li_top_2'.equals(index)}">active</c:if>">
                          <soul:button target="preferenceIndex" text="${views.setting['setting.parameter.preference']}" opType="function"></soul:button>
                      </li>
                  </shiro:hasPermission>
                  <shiro:hasPermission name="system:siteparam_playerimport">
                      <c:if test="${isEnableImport=='1'}">
                          <li id="li_top_3" class="<c:if test="${'li_top_3'.equals(index)}">active</c:if>">
                              <soul:button target="playerImportIndex" text="${views.setting['setting.parameter.importPlayer']}" opType="function"></soul:button>
                          </li>
                      </c:if>
                  </shiro:hasPermission>
              </ul>
              <div id="content-div">

              </div>

          </div>
      </div>
  </div>
</div>
</form:form>

<soul:import res="site/setting/param/siteParam/SiteParam"/>

