<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<ul class="clearfix sys_tab_wrap">
    <li id="li_top_1"><shiro:hasPermission name="system:basicsetting"><a href="/param/basicSettingIndex.html?random=${random}" nav-target="mainFrame">${views.setting['setting.parameter.basic']}</a></shiro:hasPermission></li>
    <%--<li id="li_top_2"><a href="/param/getFieldSort.html?random=${random}" nav-target="mainFrame">${views.setting['setting.parameter.register']}</a></li>
    <li id="li_top_3"><a href="/siteCustomerService/list.html?random=${random}" nav-target="mainFrame">${views.setting['setting.parameter.customer']}</a></li>--%>
    <%--<li id="li_top_4"><a href="/param/switch.html?random=${random}" nav-target="mainFrame">${views.setting['setting.parameter.switch']}</a></li>--%>
    <c:set var="userType" value="<%= SessionManager.isCurrentSiteMaster() %>"/>
    <c:if test="${userType}">
        <li id="li_top_5"><a href="/setting/preference/index.html?random=${random}" nav-target="mainFrame">${views.setting['setting.parameter.preference']}</a></li>
    </c:if>
    <%--<li id="li_top_6"><a href="/param/verification.html?random=${random}" nav-target="mainFrame">${views.setting['setting.parameter.verification']}</a></li>--%>
    <c:if test="${isEnableImport=='1'}">
        <li id="li_top_7">
            <a href="/vUserPlayerImport/list.html" nav-target="mainFrame">
            ${views.setting['setting.parameter.importPlayer']}</a>
        </li>
    </c:if>

</ul>
<!--//endregion your codes 1-->
