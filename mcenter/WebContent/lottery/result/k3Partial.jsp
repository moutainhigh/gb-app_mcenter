<%@ page import="so.wwb.gamebox.model.company.lottery.po.LotteryResult" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.lottery.vo.lotteryresultlistvo"--%>
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
                <th style="width: 80px">${views.lottery_auto['序号']}</th>

                <th>${views.lottery_auto['彩票类型']}</th>
                <th>${views.lottery_auto['彩票期号']}</th>
                <th>${views.lottery_auto['开奖时间']}</th>
                <th>${views.lottery_auto['开奖号码']}</th>
                <th colspan="3" style="text-align: center">${views.lottery_auto['总和']}</th>
                <th>${views.lottery_auto['操作']}</th>
                <%--<th>${views.lottery_auto['开盘时间']}</th>--%>
                <%--<th>${views.lottery_auto['封盘时间']}</th>--%>
                <%--<th>${views.lottery_auto['开奖时间']}</th>--%>
                <%--<th>${views.lottery_auto['第一球']}</th>--%>
                <%--<th>${views.lottery_auto['第二球']}</th>--%>
                <%--<th>${views.lottery_auto['第三球']}</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty command.result}">
                <td colspan="9" class="no-content_wrap">
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
                    <%--<td>${soulFn:formatDateTz(p.openingTime, DateFormat.DAY_SECOND,timeZone)}</td>--%>
                    <%--<td>${soulFn:formatDateTz(p.closeTime, DateFormat.DAY_SECOND,timeZone)}</td>--%>
                    <td>${soulFn:formatDateTz(p.openTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <c:set value="0" var="numSum"></c:set>
                    <c:set value="${false}" var="sumFlag"/>
                    <c:if test="${not empty p.openCode}">
                        <c:set value="${fn:split(p.openCode, ',')}" var="openCodes"/>
                        <td>
                            <c:forEach var="rs" items="${fn:split(p.openCode, ',')}" varStatus="vs">
                                <span ${p.code=='hklhc'?'num="'.concat(rs).concat('"'):''} class="cpq-num cpq-cqssc">${rs}</span>
                                <c:set value="${numSum+rs}" var="numSum"></c:set>
                            </c:forEach>
                            <c:if test="${openCodes[0] eq openCodes[1] && openCodes[0] eq openCodes[2]}">
                                <c:set value="${true}" var="sumFlag"/>
                            </c:if>
                        </td>
                        <td>${numSum}</td>
                        <c:if test="${sumFlag}">
                            <td>通吃</td>
                            <td>通吃</td>
                        </c:if>
                        <c:if test="${!sumFlag}">
                            <td><c:if test="${numSum%2 == 0}">双</c:if><c:if test="${numSum%2 != 0}">单</c:if></td>
                            <td><c:if test="${numSum>=11}">大</c:if><c:if test="${numSum <= 10}">小</c:if></td>
                        </c:if>
                    </c:if>
                    <c:if test="${empty p.openCode}">
                        <%--<c:forEach var="i" begin="0" end="2" >--%>
                            <td></td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <%--</c:forEach>--%>
                    </c:if>
                    <td>
                        <soul:button target="payout" text="派彩" opType="function"  objId="${p.id}"></soul:button>
                    </td>



                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
