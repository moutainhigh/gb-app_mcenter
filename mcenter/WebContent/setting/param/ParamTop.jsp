<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<ul class="clearfix sys_tab_wrap">
    <shiro:hasPermission name="system:siteparam_setting">
        <li id="li_top_1" class="<c:if test="${'1'.equals(webtype)}">active</c:if>">
            <a href="/param/siteParam.html" nav-target="mainFrame">${views.setting['setting.parameter.basic']}</a>
                <%--<soul:button target="basicSettingIndex" text="${views.setting['setting.parameter.basic']}" opType="function"></soul:button>--%>
        </li>
    </shiro:hasPermission>
    <shiro:hasPermission name="system:siteparam_preference">
        <li id="li_top_2" class="<c:if test="${'2'.equals(webtype)}">active</c:if>">
            <a href="/setting/preference/index.html" nav-target="mainFrame">${views.setting['setting.parameter.preference']}</a>
                <%--<soul:button target="preferenceIndex" text="${views.setting['setting.parameter.preference']}" opType="function"></soul:button>--%>
        </li>
    </shiro:hasPermission>
    <shiro:hasPermission name="system:siteparam_playerimport">
        <c:if test="${isEnableImport=='1'}">

            <li id="li_top_3" class="<c:if test="${'3'.equals(webtype)}">active</c:if>">
                <a href="/vUserPlayerImport/list.html" nav-target="mainFrame">${views.setting['setting.parameter.importPlayer']}</a>
                    <%--<soul:button target="playerImportIndex" text="${views.setting['setting.parameter.importPlayer']}" opType="function"></soul:button>--%>
            </li>
        </c:if>
    </shiro:hasPermission>
</ul>
<!--//endregion your codes 1-->
