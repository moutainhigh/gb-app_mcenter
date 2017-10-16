<%@ page import="so.wwb.gamebox.model.master.report.po.VRakebackReport" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VRakebackReportListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<c:set var="res" value="${command.result}"/>
<c:set var="type" value="<%= VRakebackReport.class %>" />
<input type="hidden" value="${conditionJson}" id="conditionJson">
<div class="search-params-div hide"></div>
<div class="sys_tab_wrap clearfix">
    <div class="m-sm">
        <b>${views.report['rakeback.detail']}</b>
        <soul:button permission="report:rakeback_export" tag="button" cssClass="btn btn-export-btn btn-primary-hide pull-right" callback="gotoExportHistory"
                     text="${views.report['fund.list.export']}" precall="validExportCount" post="getCurrentFormData"
                     title="${views.report['fund.list.export']}" target="${root}/report/rakeback/detail/exportRecords.html?result.siteId=${command.search.siteId}" opType="ajax">
            <i class="fa fa-sign-out"></i><span class="hd">${views.report['operate.list.export']}</span>
        </soul:button>
    </div>
</div>
<div class="table-responsive">
    <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.report['operate.detail.account.player']}</th>
            <th>${views.report['rakeback.detail.period']}</th>
            <c:forEach var="api" items="${command.apis}">
                <th>${gbFn:getSiteApiName(api.toString())}</th>
            </c:forEach>
            <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
            <soul:orderColumn poType="${type}" property="rakebackTotal" column="${tips1} ${views.report['rakeback.list.total']}"></soul:orderColumn>
            <c:set var="tips2" value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.actual']}\" ><i class=\"fa fa-question-circle\"></i></span>"></c:set>
            <soul:orderColumn poType="${type}" property="rakebackActual" column="${tips2} ${views.report['rakeback.list.actual']}"></soul:orderColumn>

            <%--<th>${views.report['rakeback.list.total']}<span
                    tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                    data-content="${views.report['rakeback.help.total']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
            <th>${views.report['rakeback.list.actual']}<span
                    tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                    data-content="${views.report['rakeback.help.actual']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                    --%>
            <th>${views.report['rakeback.detail.state']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="b" items="${res}">
            <c:if test="${b.settlementState eq 'reject_lssuing'}">
                <c:set var="clz" value="label label-danger" />
            </c:if>
            <c:if test="${b.settlementState eq 'pending_lssuing'}">
                <c:set var="clz" value="label label-orange" />
            </c:if>
            <c:if test="${b.settlementState eq 'lssuing'}">
                <c:set var="clz" value="label label-success" />
            </c:if>
            <c:set var="sta" value="${dicts.operation.settlement_state[b.settlementState]}" />
            <tr>
                <td>
                    ${b.playerName}
                    <c:if test="${b.specialFocus}">
                        <span class="ico-lock co-red3"><i class="fa fa-warning"></i></span>
                    </c:if>
                </td>
                <td>${soulFn:formatDateTz(b.startTime, DateFormat.DAY, timeZone)}~${soulFn:formatDateTz(b.endTime, DateFormat.DAY, timeZone)}</td>
                <c:forEach var="at" items="${command.apis}">
                    <td>
                    ${soulFn:formatCurrency(b.apiMap[at.toString()])}
                    </td>
                </c:forEach>
                <td style="padding-left: 40px;">${soulFn:formatCurrency(b.rakebackTotal)}</td>
                <td style="padding-left: 40px;">${soulFn:formatCurrency(b.rakebackActual)}</td>
                <td><span class="${clz}">${empty sta ?dicts.common.status[c.status]:sta}</span></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
