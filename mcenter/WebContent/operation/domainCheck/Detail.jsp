<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.VDomainCheckResultStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vDomainCheckResultStatistics/getCount.html" method="post">
    <style>
        .table th, .table td {
            text-align: center;
        }
    </style>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>运营</span><span>/</span><span>域名检测</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"
                     text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
        <div class="col-lg-12 m-b">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li class="active"><a href="javascript:void(0)"><%--${views.analyze['新近情况']}--%>域名状态</a></li>
                </ul>
                <div class="clearfix" style="padding:10px 10px;" id="searchDiv">
                        <%--域名--%>
                            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date">
                                    <span class="input-group-addon bg-gray">&nbsp;&nbsp;<%--${views.analyze['代理账号']}--%>域名&nbsp;</span>
                                    <input class="form-control account_input list-search-input-text" type="text"
                                           name="search.domain"
                                           placeholder="多个账号，用半角逗号隔开<%--${views.analyze['多个账号，用半角逗号隔开']}--%>"
                                           value="${command.search.domain}"/>
                                </div>
                            </div>
                            <%--地区--%>
                           <%-- <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">地区省</span>
                                    <gb:select name="result.province"
                                               prompt="省" value="${command.result.province}"
                                               ajaxListPath="${root}/regions/states/CN.html"
                                               listValue="remark" listKey="dictCode"
                                               cssClass="btn-group chosen-select-no-single"
                                               relSelect="result.city"/>

                                </div>
                            </div>--%>
                                <%--运营商--%>
                            <%--<div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">城市</span>
                                    <gb:select name="result.city" prompt="${views.common['pleaseSelect']}"
                                               value="${command.result.province}"
                                               ajaxListPath="${root}/regions/cities/CN-${command.search.serverCity}.html"
                                               relSelectPath="${root}/regions/cities/CN-#result.province#.html"
                                               listValue="remark"
                                               listKey="dictCode"
                                               cssClass="btn-group chosen-select-no-single"/>
                                </div>
                            </div>--%>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                        <%-- 搜索--%>

                    <soul:button text="" target="query" opType="function" cssClass="btn btn-filter" tag="button">
                        <i class="fa fa-search"></i>
                        <span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>

                </div>


                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <div class="search-list-container">
                        <%@ include file="IndexPartial.jsp" %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import type="list"/>
<!--//endregion your codes 3-->