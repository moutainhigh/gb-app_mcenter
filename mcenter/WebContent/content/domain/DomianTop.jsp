<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<ul class="clearfix sys_tab_wrap">
    <li id="li_top_1"><a href="/content/sysDomain/list.html?random=${random}" nav-target="mainFrame">${views.content['domain.site']}</a></li>
    <li id="li_top_2"><a href="/content/sysDomain/agentDomainList.html?random=${random}" nav-target="mainFrame">${views.content['domain.agent']}</a></li>
</ul>
<!--//endregion your codes 1-->
