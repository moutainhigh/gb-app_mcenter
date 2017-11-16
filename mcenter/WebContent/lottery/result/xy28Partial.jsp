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
                <th style="width: 80px">${views.lottery_auto['序号']}</th>

                <th>${views.lottery_auto['彩票类型']}</th>
                <th>${views.lottery_auto['彩票期号']}</th>
                <th>${views.lottery_auto['开奖时间']}</th>
                <th>${views.lottery_auto['开奖号码']}</th>
                <th colspan="3" style="text-align: center">${views.lottery_auto['总和']}</th>
                <th>${views.lottery_auto['操作']}</th>
                <%--<th>第一球</th>--%>
                <%--<th>第二球</th>--%>
                <%--<th>第三球</th>--%>
                <%--<c:if  test="${code eq'bjkl8'}">--%>
                    <%--<th>第四球</th>--%>
                    <%--<th>第五球</th>--%>
                    <%--<th>第六球</th>--%>
                    <%--<th>第七球</th>--%>
                    <%--<th>第八球</th>--%>
                    <%--<th>第九球</th>--%>
                    <%--<th>第十球</th>--%>
                    <%--<th>第十一球</th>--%>
                    <%--<th>第十二球</th>--%>
                    <%--<th>第十三球</th>--%>
                    <%--<th>第十四球</th>--%>
                    <%--<th>第十五球</th>--%>
                    <%--<th>第十六球</th>--%>
                    <%--<th>第十七球</th>--%>
                    <%--<th>第十八球</th>--%>
                    <%--<th>第十九球</th>--%>
                    <%--<th>第二十球</th>--%>
                <%--</c:if>--%>
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
                    <%--<td>${soulFn:formatDateTz(p.openingTime, DateFormat.DAY_SECOND,timeZone)}</td>--%>
                    <%--<td>${soulFn:formatDateTz(p.closeTime, DateFormat.DAY_SECOND,timeZone)}</td>--%>
                    <td>${soulFn:formatDateTz(p.openTime, DateFormat.DAY_SECOND,timeZone)}</td>
                    <c:set value="0" var="numSum"></c:set>
                    <c:if test="${not empty p.openCode}">
                        <td>
                            <c:forEach var="rs" items="${fn:split(p.openCode, ',')}" varStatus="vs">
                                <span ${p.code=='hklhc'?'num="'.concat(rs).concat('"'):''} class="cpq-num cpq-cqssc">${rs}</span>
                                <c:set value="${numSum+rs}" var="numSum"></c:set>
                            </c:forEach>
                        </td>
                        <td>${numSum}</td>
                        <td><c:if test="${numSum%2 == 0}">双</c:if><c:if test="${numSum%2 != 0}">单</c:if></td>
                        <td><c:if test="${numSum>=14}">大</c:if><c:if test="${numSum <= 13}">小</c:if></td>

                    </c:if>
                    <c:if test="${empty p.openCode}">
                        <c:set var="num" value="2"/>
                        <c:if test="${code eq 'bjkl8'}">
                            <c:set var="num" value="19"/>
                        </c:if>
                        <%--<c:forEach var="i" begin="0" end="${num}" >--%>
                            <td></td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <%--</c:forEach>--%>
                    </c:if>
                    <td>
                        <soul:button target="payout" text="派彩" opType="function" permission="lottery:openresult_payout" objId="${p.id}"></soul:button>
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<soul:pagination cssClass="bdtop3"/>
<!--//endregion your codes 1-->
