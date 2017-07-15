<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityPlayerApplyListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<form:form action="${root}/operation/vActivityPlayerApply/activityPlayerApply.html" method="post">
    <input type="hidden" value="${command1.get(0).id}" name="search.id">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span>
            <span>/</span><span>${views.sysResource['活动管理']}</span>
            <soul:button tag="a" refresh="true"  target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <span hidden>
                <soul:button target="query" text="" opType="function" cssClass="search_btn hide"/>
            </span>
            <%--<shiro:hasPermission name="operate:activity_checkapply">
                <a href="/operation/vActivityPlayerApply/activityPlayerApply.html?search.id=${command1.get(0).id}"
                   nav-target="mainFrame" name="return"
                   class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" style="display: none"><em
                        class="fa fa-caret-left"></em>${views.common['return']}</a>
            </shiro:hasPermission>--%>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <c:if test="${command1.get(0).isAudit}">
                    <div class="clearfix p-sm border-b-1">
                        <div class="col-md-6 clearfix p-x">
                            <img src="${resRoot}${command1.get(0).logo}" class="pull-left">
                            <div class="pull-left m-l-sm">
                                <h3 class="h3" data-code="${command1.get(0).code}">${command1.get(0).name}</h3>
                                <span>${command1.get(0).introduce}</span>
                            </div>
                        </div>
                        <div class="col-md-6 line-hi25 clearfix">
                            <div class="textVal"><label class="ft-bold">${views.operation['Activity.name']}：</label>${command1.get(0).activityName}</div>
                            <div><label
                                    class="ft-bold">${views.operation['Activity.date']}：</label>${soulFn:formatDateTz(command1.get(0).startTime,DateFormat.DAY_SECOND,timeZone)}~${soulFn:formatDateTz(command1.get(0).endTime,DateFormat.DAY_SECOND,timeZone)}
                            </div>
                        </div>
                    </div>
                    <div class="clearfix filter-wraper border-b-1">
                        <div class="function-menu-show hide" code="${command1.get(0).code}" sumPerson="${command.result.size()}">
                            <soul:button target="successDialog" text="${views.common['checkPass']}" opType="function" cssClass="btn btn-outline btn-filter"/>
                            <soul:button target="${root}/operation/vActivityPlayerApply/auditStatus.html?&result.checkState=3&activityType=${command1.get(0).code}"
                                         text="${views.common['checkFailure']}" opType="ajax" post="getSelectIds" precall="hasFailReason" callback="query"
                                         cssClass="btn btn-outline btn-filter"/>
                        </div>
                        <soul:button target="query" text="${views.common['refresh']}" opType="function" cssClass="btn btn-filter pull-right"></soul:button>
                    </div>
                </c:if>
                <c:if test="${!command1.get(0).isAudit}">
                <div class="clearfix filter-wraper border-b-1">
                    <soul:button target="query" text="${views.common['refresh']}" opType="function" cssClass="btn btn-filter pull-right"></soul:button>
                </div>
                </c:if>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import res="site/operation/activity/activityPlayerApply"/>