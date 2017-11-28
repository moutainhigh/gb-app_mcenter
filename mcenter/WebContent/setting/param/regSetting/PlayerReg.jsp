<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineAreaVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/param/getFieldSort.html" method="post" nav-target="mainFrame">
    <!--//region your codes 2-->
    <form:hidden path="type"/>
    <input name="result.id" type="hidden" value="${command.paramId}">
    <input name="result.paramValue" type="hidden"/>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['注册设置']}</span>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <ul class="clearfix sys_tab_wrap">
                    <li id="li_top_1" class="${empty command.type ?'active':''}"><a href="/param/getFieldSort.html?random=${random}" nav-target="mainFrame">${views.setting['PlayerReg.playerReg']}</a></li>
                    <li id="li_top_2" class="${not empty command.type ?'active':''}"><a href="/param/getFieldSort.html?random=${random}&type=agent" nav-target="mainFrame">${views.setting['PlayerReg.agentReg']}</a></li>
                </ul>
                <div class="clearfix filter-wraper border-b-1 line-hi34">
                    <%--<a class="btn btn-filter ${command.type=="agent"?"btn-outline":""}" href="/param/getFieldSort.html?random=${random}" nav-target="mainFrame">${views.setting['PlayerReg.playerReg']}</a>
                    <a class="btn btn-filter ${command.type=="agent"?"":"btn-outline"}" href="/param/getFieldSort.html?random=${random}&type=agent" nav-target="mainFrame">${views.setting['PlayerReg.agentReg']}</a>--%>
                    <soul:button target="${root}/param/PlayerSetting.html?random=${random}&type=${command.type}" text="${command.type=='agent'?views.setting['playerSetting.agentReg']:views.setting['playerSetting.playerReg']}" title="${command.type=='agent'?views.setting['playerSetting.agentReg']:views.setting['playerSetting.playerReg']}" callback="loadRegSetting" opType="dialog" cssClass="btn btn-outline btn-filter pull-right"><i class="fa fa-gear"></i>${command.type=='agent'?views.setting['playerSetting.agentReg']:views.setting['playerSetting.playerReg']}</soul:button>
                    <a href="/param/getServiceTerms.html?type=${command.type}" nav-target="mainFrame" class="btn btn-outline btn-filter pull-right">${views.setting['PlayerReg.serviceTrems.edit']}</a>
                </div>
                        <table class="table table-striped table-hover dataTable m-b-sm dragdd">
                        <thead>
                        <tr class="bg-gray">
                            <th class="co-yellow">${views.common['DynamicLie.draggingSort']}</th>
                            <th>${views.setting['PlayerReg.name']}</th>
                            <th>${views.setting['PlayerReg.isRequired']}</th>
                            <th>${views.setting['PlayerReg.isRegField']}</th>
                        </tr>
                        </thead>
                        <div class="table-responsive">
                                <tbody class="dd-list1">
                                <c:forEach items="${command.fieldSortList}" var="order" varStatus="status">
                                        <tr data-id="${empty order.sort?status.index:order.sort}" class="dd-item1">
                                            <input type="hidden" value="${order.bulitIn}" class="td-handle1"/>
                                            <td class="${order.bulitIn?"":"td-handle1"}">
                                                <c:if test="${!order.bulitIn}">
                                                    <i class="fa fa-arrows"></i>
                                                </c:if>
                                            </td>

                                            <td class="${order.bulitIn?"":"td-handle1"}" val="${order.name}">${views.column[order.name]}</td>
                                            <td class="${order.isRequired=="1"?"co-green ":""} ${order.bulitIn?"":"td-handle1"}" val="${order.isRequired}">${dicts.setting.isRequired[order.isRequired]}</td>
                                            <td class="${order.isRegField=="1"?"co-green ":""} ${order.bulitIn?"":"td-handle1"}" val="${order.isRegField}">${dicts.setting.isRegField[order.isRegField]}
                                                <c:if test="${order.name=='110'}">
                                                    <span class="co-grayc2" ${command.phoneParam.active?'':'hidden'}> (${dicts.setting.PlayerReg[command.phoneParam.paramValue]})</span>
                                                </c:if>
                                                <c:if test="${order.name=='201'}">
                                                    <span class="co-grayc2" ${command.mailParam.active?'':'hidden'}>  (${dicts.setting.PlayerReg[command.mailParam.paramValue]})</span>
                                                </c:if>&nbsp;&nbsp;
                                                <c:if test="${order.isOnly=='1'}">
                                                    <span val="${empty order.isOnly ? '2' : order.isOnly}" id="isOnly">${dicts.setting.isOnly[order.isOnly]}</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                </c:forEach>
                                </tbody>
                        </div>
                    </table>
            </div>
            <div class="operate-btn">
                <soul:button target="${root}/param/saveRegSetting.html" post="getCurrentFormData" precall="applyCashFlowOrder" text="${views.common['apply']}" opType="ajax" cssClass="btn btn-outline btn-filter btn-lg m-r" callback="loadRegSetting">${views.common['apply']}</soul:button>
            </div>
        </div>

        <!--//endregion your codes 2-->
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/param/regSetting/PlayerReg"/>
<!--//endregion your codes 3-->