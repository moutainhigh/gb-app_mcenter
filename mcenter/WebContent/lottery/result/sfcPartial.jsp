<%@ page import="so.wwb.gamebox.model.company.lottery.po.LotteryResult" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.lottery.vo.LotteryResultListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@taglib uri="http://soul/tags" prefix="soul" %>

<!--//region your codes 1-->
<div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info">
            <c:set var="poType" value="<%= LotteryResult.class %>"></c:set>
            <thead>
            <tr role="row" class="bg-gray">
                <th style="width: 80px">序号</th>
                <th>彩票类型</th>
                <th>彩票期号</th>
                <th>开盘时间</th>
                <th>封盘时间</th>
                <th>开奖时间</th>
                <th>采集时间</th>
                <th>采集来源</th>
                <th>第一球</th>
                <th>第二球</th>
                <th>第三球</th>
                <th>第四球</th>
                <th>第五球</th>
                <th>第六球</th>
                <th>第七球</th>
                <th>第八球</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty command.result}">
                <td colspan="13" class="no-content_wrap">
                    <div>
                        <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                    </div>
                </td>
            </c:if>
            <c:forEach items="${command.result}" var="p" varStatus="status">
                <tr class="tab-detail">
                    <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                    <td>${dicts.lottery.lottery[p.code]}</td>
                    <td>${p.expect}</td>
                    <td>${soulFn:formatDateTz(p.openingTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${soulFn:formatDateTz(p.closeTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${soulFn:formatDateTz(p.openTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${soulFn:formatDateTz(p.gatherTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${empty p.origin?'--':p.origin=='0'?'手动':'自动'}</td>
                    <c:if test="${not empty p.openCode}">
                        <c:forEach var="rs" items="${fn:split(p.openCode, ',')}" varStatus="vs">
                            <td><span ${p.code=='xklhc'?'num="'.concat(rs).concat('"'):''} class="cpq-num cpq-cqssc">${rs}</span></td>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty p.openCode}">
                        <c:forEach var="i" begin="0" end="7" >
                            <td>--</td>
                        </c:forEach>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
