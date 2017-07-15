<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<ul class="clearfix sys_tab_wrap">
    <shiro:hasPermission name="system:confinearea_limitarea">
        <li id="li_top_1"><a href="/siteConfineArea/list.html" nav-target="mainFrame">${views.setting['setting.parameter.confine.area']}</a></li>
    </shiro:hasPermission>
    <shiro:hasPermission name="system:confinearea_limitsite">
        <li id="li_top_2"><a href="/siteConfineIp/list.html?search.type=1&type=1" nav-target="mainFrame">${views.setting['setting.parameter.confine.ip']}</a></li>
    </shiro:hasPermission>
    <shiro:hasPermission name="system:confinearea_permitsite">
        <li id="li_top_3"><a href="/siteConfineIp/list.html?search.type=2&type=2" nav-target="mainFrame">${views.setting['setting.parameter.allow.ip']}</a></li>
    </shiro:hasPermission>
    <shiro:hasPermission name="system:confinearea_permit">
        <li id="li_top_4"><a href="/siteConfineIp/list.html?search.type=3&type=3" nav-target="mainFrame">${views.setting['setting.parameter.allow.admin.ip']}</a></li>
    </shiro:hasPermission>
</ul>
<!--允许访问-->
<%--<div class="modal inmodal" id="allow" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight family">
            <div class="modal-header">
                <span class="filter"><i class="fa fa-plus"></i>&nbsp;&nbsp;新增IP地址</span>
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${views.setting_auto['关闭']}</span> </button>
            </div>
            <div class="modal-body">
                <div class="clearfix m-b bg-gray p-t-xs">
                    <span class="co-orange fs36 line-hi25 col-xs-1 al-right m-r-sm">
                        <i class="fa fa-exclamation-circle"></i>
                    </span>
                    <div class="line-hi34 m-b-sm">开启该功能后，仅添加的并处于正常状态的IP可访问站点前端，请谨慎操作！</div>
                </div>
            </div>
            <div class="modal-footer">
                <!--                <button type="button" class="btn btn-filter">${views.setting_auto['好的']}</button>-->
                <a href="/siteConfineIp/list.html?search.type=3&type=3" class="btn btn-filter" nav-target="mainFrame">${views.setting_auto['好的']}</a>
            </div>
        </div>
    </div>
</div>--%>
<!--//endregion your codes 1-->
