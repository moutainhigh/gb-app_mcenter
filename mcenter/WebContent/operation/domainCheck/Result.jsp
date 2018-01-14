<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultstatusCountVo"--%>
<%--@elvariable id="area" type="so.wwb.gamebox.model.master.setting.vo.SiteConfineAreaVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">
    <form:form action="${root}/operation/domainCheckResult/list.html?search.isSecondSearch=0" method="post">
        <%--        <style>
                    .table th, .table td {
                        text-align: center;
                    }
                </style>--%>

        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a>
            </h2>
            <span>${views.sysResource['运营']}</span><span>/</span><span>${views.operation['域名检测']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li><a href="/vDomainCheckResultStatistics/list.html"
                           nav-target="mainFrame">${views.operation['域名状态']}</a>
                    </li>
                    <li class="active"><a href="#" nav-target="mainFrame">${views.operation['检测结果']}</a>
                    </li>
                </ul>




                <div class="clearfix" style="padding:10px 10px;" id="searchDiv">
                        <%--域名--%>
                    <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group date">
                            <span class="input-group-addon bg-gray">&nbsp;&nbsp;${views.operation['域名']}&nbsp;</span>
                            <input class="form-control account_input list-search-input-text" type="text"
                                   name="search.domain"
                                   placeholder="${views.analyze['多个账号，用半角逗号隔开']}"
                                   value="${command.search.domain}"/>
                        </div>
                    </div>
                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">${views.operation['地区']}</span>
                            <gb:select name="search.serverProvince"
                                       prompt="${views.common['pleaseSelect']}" value=""
                                       ajaxListPath="${root}/regions/states/CN.html"
                                       listValue="remark" listKey="dictCode"
                                       cssClass="btn-group chosen-select-no-single"
                                       relSelect="search.serverCity"/>

                        </div>
                    </div>
                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <gb:select name="search.serverCity" prompt="${views.common['pleaseSelect']}"
                                       value=""
                                       ajaxListPath="${root}/regions/cities/CN-${command.search.serverCity}.html"
                                       relSelectPath="${root}/regions/cities/CN-#search.serverProvince#.html"
                                       listValue="remark"
                                       listKey="dictCode"
                                       cssClass="btn-group chosen-select-no-single"/>
                        </div>
                    </div>

                        <%--地区--%>


                        <%--运营商--%>


                        <%-- 搜索--%>
                    <soul:button text="" target="query" opType="function" cssClass="btn btn-filter" tag="button">
                        <i class="fa fa-search"></i>
                        <span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>

                </div>
                <soul:button target="${root}/operation/domainCheckResult/showPopStatusCount.html" text="showpop" opType="dialog"></soul:button>

                <div class="operate-btn n-o-margin border-b-1 clearfix">
                    <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.operation['检测时间：']}${soulFn:formatDateTz(checkTime, DateFormat.DAY_SECOND, timeZone )}
                </div>

                <div class="clearfix filter-wraper border-b-1 line-hi34 al-right">
                        ${views.operation['所有域名检测结果仅供参考，不完全代表整个区域的实际解析情况，不具备故障证据之作用！如有需要请自行核实域名实际情况！']}
                </div>


                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="ResultPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>

    </form:form>
</div>
<!--//region your codes 3-->
<soul:import res="site/operation/DomainCheckResult/ResultList"/>
<!--//endregion your codes 3-->