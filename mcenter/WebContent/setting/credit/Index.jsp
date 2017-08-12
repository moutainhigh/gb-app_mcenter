<%--@elvariable id="command" type="so.wwb.gamebox.model.company.credit.vo.CreditRecordListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/creditRecord/list.html" method="post">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <input type="hidden" name="search.transactionType" value="${command.search.transactionType}">
    <input type="hidden" name="search.type" value="${command.search.type}">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.setting_auto['系统设置']}</span>
            <span>/</span><span>${views.setting_auto['充值记录']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="col-sm-12 clearfix" style="padding-left: 0;">

                            <%--<div class="form-group clearfix pull-left col-md-6 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                    <span class="input-group-addon bg-gray">${views.setting_auto['支付时间']}</span>
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:44%" useRange="true"
                                                  opens="right" position="down"
                                                  startDate=""
                                                  endDate=""
                                                  startName="" endName=""/>
                                </div>
                            </div>--%>

                            <soul:button precall="validateForm" target="query" text="" cssClass="btn btn-filter mediate-search-btn"
                                         opType="function">
                                <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                            </soul:button>

                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="dataTables_wrapper search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import type="list"/>
<!--//endregion your codes 3-->