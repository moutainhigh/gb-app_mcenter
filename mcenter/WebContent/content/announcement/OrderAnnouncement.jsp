<%@ page import="java.util.Date" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="${root}/cttAnnouncement/orderSiteApi.html?search.announcementType=${command.search.announcementType}" method="post">
<div class="row">

    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['公告栏管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>

    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <div class="clearfix filter-wraper border-b-1">
                <div class=" clearfix m-sm">
                    <i class="fa fa-exclamation-circle"></i><span class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                </div>
            </div>
            <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                <table class="table table-striped table-hover dataTable m-b-sm dragdd" aria-describedby="editable_info">
                    <thead>
                    <tr role="row" class="bg-gray">
                        <th width="80">${views.common['number']}</th>
                        <th width="80">类型</th>
                        <th>${views.column['CttAnnouncement.content']}</th>
                        <th>${views.column['CttAnnouncement.publishTime']}</th>
                    </tr>
                    <tr class="bd-none hide">
                        <th colspan="7">
                        </th>
                    </tr>
                    </thead>
                    <tbody class="dd-list1">
                        <c:if test="${empty command.result}">
                            <td colspan="7" class="no-content_wrap">
                                <div>
                                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                                </div>
                            </td>
                        </c:if>
                        <c:forEach items="${command.result}" var="p" varStatus="status">
                            <tr class="tab-detail dd-item1">
                                <input class="td-handle1" type="hidden" name="announcementType" value="${p.id}"/>
                                <td class="td-handle1">${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                                <td class="td-handle1">${dicts.content.ctt_announcement_type[p.announcementType]}</td>
                                <td class="td-handle1"><span class="table-t-title">${p.content}</span></td>
                                <td>
                                    <c:if test="${p.isTask}">
                                        <c:set var="nowtime" value="<%=new Date()%>"></c:set>
                                        <c:if test="${nowtime.before(p.publishTime)}">
                                            ${fn:replace(views.content['announcement.willPublish'], '{time}',soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone))}
                                        </c:if>
                                        <c:if test="${nowtime.after(p.publishTime)}">
                                            ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
                                        </c:if>
                                    </c:if>
                                    <c:if test="${!p.isTask}">
                                        ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="operate-btn" style="text-align: center">
                <soul:button target="saveSiteApiOrder" text="${views.common['OK']}" opType="function"
                             cssClass="btn btn-filter btn-lg m-r" >${views.common['OK']}</soul:button>
                <soul:button target="goToLastPage" text="${views.common['cancel']}" opType="function"
                             cssClass="btn btn-outline btn-filter btn-lg m-r" >${views.common['cancel']}</soul:button>
            </div>
        </div>
    </div>

</div>
</form:form>
<!--//endregion your codes 2-->


<!--//region your codes 3-->
<!--//region your codes 4-->
<soul:import res="site/content/cttannouncement/OrderAnnouncement"/>
<!--//endregion your codes 4-->

<!--//endregion your codes 1-->
