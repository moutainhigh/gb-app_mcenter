<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineIpListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/siteConfineIp/list.html?search.type=${command.type}" method="post">
    <div class="row">
        <div id="validateRule" style="display: none">${command.validateRule}</div>

        <input  id="type" name="type" value="${command.type}" hidden="hidden">


        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['访问设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <%@ include file="../top.jsp" %>
                <c:choose>
                <c:when test="${command.type.equals('2')&&!command.sysParam.paramValue=='true'}">
                    <div class="modal-body">
                        <div class="clearfix m-b bg-gray p-t-xs">
                        <span class="co-orange fs36 line-hi25 col-xs-1 al-right m-r-sm">
                            <i class="fa fa-exclamation-circle"></i>
                        </span>
                            <div class="line-hi34 m-b-sm">${command.type.equals('2')?views.setting['siteConfine.ip.site.playerMsg']:views.setting['siteConfine.ip.site.admin.playerMsg']}</div>
                        </div>
                    </div>
                    <div class="modal-footer al-center">
                        <!--                <button type="button" class="btn btn-filter">${views.setting_auto['好的']}</button>-->
                        <a href="/siteConfineIp/list.html?sysParam.id=${command.sysParam.id}&sysParam.paramValue=true&search.type=${command.type}&type=${command.type}" class="btn btn-filter btn-lg" nav-target="mainFrame">${views.setting_auto['好的']}</a>
                    </div>
                </c:when>
                <c:otherwise>
                <div class="clearfix filter-wraper border-b-1">
                    <soul:button callback="oneDialog" tag="button" target="${root}/siteConfineIp/create.html?type=${command.type}"
                                 text="${views.setting['page.createConfine']}" title="${views.setting['siteConfine.ip.create']}"
                                 size="open-dialog-50"
                                 opType="dialog" cssClass="btn btn-info btn-addon" ><i class="fa fa-plus"></i><span class="hd">${views.setting['page.createConfine']}</span></soul:button>
                    <div class="function-menu-show hide">
                        <soul:button precall="confirmMessage" tag="button" text="${views.setting['common.delete']}" target="${root}/siteConfineIp/batchDeleteArea.html" post="getSelectIds" opType="ajax" cssClass="btn btn-danger-hide" callback="query"><i class="fa fa-trash-o"></i><span class="hd">${views.setting['common.delete']}</span></soul:button>
                    </div>

                    <div class="" style="display: ${command.type=="2"?"":"none"}">
                        <soul:button cssClass="btn btn-primary-hide" target="${root}/siteConfineIp/getSettingParam.html?type=${command.type}" callback="query" text="${views.common['setting']}" opType="dialog"><i class="fa fa-gear"></i><span class="hd">${views.common['setting']}</span></soul:button>
                    </div>
                    <div class="search-wrapper btn-group pull-right m-r-n-xs">
                        <div class="input-group">
                            <form:input class="form-control" path="search.searchIp" placeholder="${views.common['pleaseEnter']}IP"/>
                                <span class="input-group-btn">
                                    <soul:button target="query" opType="function" text="${views.common['query']}"  cssClass="btn btn-filter">
                                        <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['query']}</span>
                                    </soul:button>
                                </span>
                        </div>
                    </div> </div>
                <!--表格内容-->
                <div class="search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
                </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <button hidden="hidden" id="showButton" type="button" class="" data-toggle="modal" data-target="#myModal">
    </button>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">${messages.common['msg']}</h4>
                </div>
                <div class="modal-body">
                        ${views.setting['siteConfine.ip.open']}
                </div>
                <div class="modal-footer">
                    <soul:button cssClass="btn btn-primary-hide" callback="closeModal" target="${root}/siteConfineIp/getSettingParam.html?type=${command.type}" text="${views.common['setting']}" opType="dialog"><i class="fa fa-gear"></i><span class="hd">${views.setting['siteConfine.ip.to.open']}</span></soul:button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">${views.common['cancel']}</button>
                </div>
            </div>
        </div>
    </div>





</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/siteConfine/ip/Index"/>
<!--//endregion your codes 3-->