<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="so.wwb.gamebox.model.SubSysCodeEnum" %>
<%@ include file="/include/include.inc.jsp" %>


<div class="row">
    <form:form id="reportForm" action="${root}/report/operate/subAgentDetail.html" method="post">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <input type="hidden" name="search.startDate" value="${command.search.startDate}">
        <input type="hidden" name="search.endDate" value="${command.search.endDate}">
        <input type="hidden" name="roleName" value="${command.roleName}">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span><span>/</span><span>${views.sysResource['经营报表']}</span><span>/</span><span>${views.report['下级代理']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="col-sm-12 clearfix" style="padding-left: 0;">

                            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date">
                                    <span class="input-group-addon">${views.report['代理名称']}</span>
                                    <input type="text" class="form-control" name="search.agentName"
                                           value="${command.search.agentName}">
                                </div>
                            </div>

                            <soul:button precall="" target="query" text="" cssClass="btn btn-filter"
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
                    <%@ include file="AgentDetailPartial.jsp" %>
                </div>
            </div>
        </div>

    </form:form>
</div>

<soul:import type="list"/>


