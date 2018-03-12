<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerRankStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/siteConfineArea/list.html" method="post">
    <div class="row">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['访问设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>


        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <%@ include file="../top.jsp" %>
                <div class="clearfix filter-wraper border-b-1">
                    <soul:button tag="button" target="${root}/siteConfineArea/create.html"
                                 text="${views.setting['page.createConfine']}" title="${views.setting['siteConfine.area.createTitle']}" opType="dialog"
                                 cssClass="btn btn-info btn-addon" size="open-dialog-50"
                                 callback="callBackQuery"><i class="fa fa-plus"></i><span
                            class="hd">${views.setting['page.createConfine']}</span></soul:button>
                    <div class="function-menu-show hide">
                        <soul:button precall="confirmMessage" tag="button" text="${views.contacts['page.contacts.del']}"
                                     target="${root}/siteConfineArea/batchDeleteArea.html" post="getSelectIds"
                                     opType="ajax" cssClass="btn btn-danger-hide" callback="query"><i
                                class="fa fa-trash-o"></i><span
                                class="hd">${views.setting['common.delete']}</span></soul:button>
                    </div>
                    <div class="btn-group pull-right m-r-n-xs content-width-limit-400 area_limit_width">
                        <div class="input-group">

                            <div class="col-xs-4">
                                <div>
                                    <gb:select name="search.nation" prompt="${views.common['pleaseSelect']}"
                                                   ajaxListPath="${root}/regions/list.html" listValue="remark"
                                                   listKey="dictCode" relSelect="search.province"
                                                   cssClass="btn-group chosen-select-no-single"/>
                                </div>
                            </div>
                            <div class="col-xs-4">
                                <div>
                                    <gb:select name="search.province" prompt="${views.common['pleaseSelect']}"
                                                   relSelectPath="${root}/regions/states/#search.nation#.html"
                                                   listValue="remark" listKey="dictCode"
                                                   cssClass="btn-group chosen-select-no-single" relSelect="search.city"/>
                                </div>
                            </div>
                            <div class="col-xs-4">
                                <div>
                                    <gb:select name="search.city" prompt="${views.common['pleaseSelect']}"
                                                   relSelectPath="${root}/regions/cities/#search.nation#-#search.province#.html"
                                                   listValue="remark" listKey="dictCode"
                                                   cssClass="btn-group chosen-select-no-single"/>
                                </div>
                            </div>



                            <span class="input-group-btn">
                                <soul:button target="query" opType="function" text="${views.common['query']}"
                                             cssClass="btn btn-filter _enter_submit">
                                    <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['query']}</span>
                                </soul:button>
                            </span>
                        </div>
                    </div>
                </div>
                <!--表格内容-->
                <div class="search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/siteConfine/area/Index"/>
<!--//endregion your codes 3-->