<%@ page import="so.wwb.gamebox.model.master.player.po.VPlayerRankStatistics" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerRankStatisticsListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VPlayerRankStatistics.class %>"></c:set>
<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-sm" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['PlayerRank.rankCode']}</th>
            <th>${views.column['PlayerRank.rankName']}</th>
            <th>${views.column['PlayerRank.playerNum']}</th>
            <th>${views.player_auto['代理数']}</th>
            <th>${views.player_auto['返水方案']}</th>
            <th>${views.column['PlayerRank.onlinePayMin&PayMax']}</th>
            <th>${views.column['PlayerRank.withdrawMaxNum&MinNum']}</th>
            <th>${views.column['PlayerRank.feeMoney']}</th>
            <th>${views.role['PlayerRank.list.isFee1']}<br>${views.role['PlayerRank.list.isFee2']}</th>
            <th>${views.column['PlayerRank.withdrawFeeNum']}</th>
            <th>${views.role['PlayerRank.list.withdrawTimeLimit1']}<br>${views.role['PlayerRank.list.withdrawTimeLimit2']}</th>
            <th>${views.common['operate']}</th>
        </tr>
        <tr class="bd-none">
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>${p.rankCode}</td>
                <td>
                    <a href="/vPlayerRankStatistics/view.html?id=${p.id}" nav-target="mainFrame">${p.rankName}</a>
                    <c:if test="${p.riskMarker}">
                        <span data-content="${views.player_auto['危险层级']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="co-red3" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-warning"></i></span>
                    </c:if>
                    <c:if test="${empty p.onlinePayMax || empty p.withdrawMaxNum}">
                        <span data-content="${views.player_auto['需先设置完存款和取款后，该层级才会生效！']}" style="background-color: #f3f3f3;padding: 5px;"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="help-popover" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-exclamation-circle co-orange"></i>${views.player_auto['不可使用']}</span>
                    </c:if>
                    <c:if test="${not empty p.onlinePayMax && not empty p.withdrawMaxNum}">
                        <c:if test="${p.payAccountNum==0}">
                            <span data-content="${views.player_auto['该层级暂无可用收款账户，请先设置！']}"
                                  data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                  role="button" class="help-popover" tabindex="0"
                                  data-original-title="" title=""><i class="fa fa-exclamation-circle co-orange"></i>
                                ${views.player_auto['暂未']}<a href="/vPayAccount/list.html?search.type=1" nav-target="mainFrame">${views.player_auto['设置收款账户']}</a>
                            </span>
                        </c:if>
                    </c:if>
                    <%--<span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body" data-toggle="popover"
                          data-trigger="focus" data-placement="top" data-html="true" data-content="${views.player_auto['该代理体系下玩家获得的返水']}"
                          data-original-title="" title=""><i class="fa fa-question-circle"></i></span>--%>
                </td>
                <td>
                    <a href="/player/list.html?search.hasReturn=true&search.rankId=${p.id}" nav-target="mainFrame">${p.playerNum}</a>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${p.agentNum gt 0}">
                            <a href="/vUserAgentManage/list.html?search.hasReturn=true&search.playerRankId=${p.id}" nav-target="mainFrame">${p.agentNum}</a>
                        </c:when>
                        <c:otherwise>
                            ${p.agentNum}
                        </c:otherwise>
                    </c:choose>

                </td>
                <td><a href="/setting/vRakebackSet/view.html?id=${p.rakebackId}" nav-target="mainFrame">${p.rakebackName}</a></td>
                <td>${p.onlinePayMin}~${p.onlinePayMax}</td>
                <td>${p.withdrawMinNum}~${p.withdrawMaxNum}</td>
                <td>
                    <c:if test="${not empty p.isFee&&empty p.isReturnFee}">
                        <c:if test="${p.isFee}">
                            <%--收取存款手续费--%>
                            <%--● 固定收取手续费，显示为：收取¥10--%>
                            <%--● 按比例收取手续费，显示为：收取10%，上限¥50--%>
                            <c:if test="${p.feeType=='1'}">
                                <c:set var="maxFee" value="${siteCurrencySign}${soulFn:formatInteger(p.maxFee)}${soulFn:formatDecimals(p.maxFee)}"></c:set>
                                ${views.player_auto['收取']}${p.feeMoney}%,&nbsp;${views.player_auto['上限']}${maxFee}
                            </c:if>
                            <c:if test="${p.feeType!='1'}">
                                ${views.player_auto['收取']}${siteCurrencySign}${p.feeMoney}
                            </c:if>


                        </c:if>
                        <c:if test="${!p.isFee}">
                            ${views.role['PlayerRank.list.none']}
                        </c:if>
                    </c:if>
                    <c:if test="${empty p.isFee&&not empty p.isReturnFee}">
                        <c:if test="${p.isReturnFee}">
                            <c:set var="restr" value="${views.player_auto['存满']}"></c:set>
                            <c:set var="reachMoney" value="${siteCurrencySign}${soulFn:formatInteger(p.reachMoney)}${soulFn:formatDecimals(p.reachMoney)}"></c:set>
                            <c:if test="${p.returnType=='1'}">
                                <c:set var="returnMoney" value="${p.returnMoney}%"></c:set>
                            </c:if>
                            <c:if test="${p.returnType!='1'}">
                                <c:set var="returnMoney" value="${siteCurrencySign}${soulFn:formatInteger(p.returnMoney)}${soulFn:formatDecimals(p.returnMoney)}"></c:set>
                            </c:if>
                            <c:set var="maxReturnFee" value="${siteCurrencySign}${soulFn:formatInteger(p.maxReturnFee)}${soulFn:formatDecimals(p.maxReturnFee)}"></c:set>
                            <c:set var="depositFee" value='${fn:replace(fn:replace(fn:replace(restr,"{0}", reachMoney),"{1}",returnMoney),"{2}",maxReturnFee)}'/>
                            <%--storyID=1263--%>
                            <%--返还存款手续费&ndash;%&gt;--%>
                            <%--● 固定返还手续费，显示为：存满¥100返¥10--%>
                            <%--● 按比例返还手续费，显示为：存满¥100返10%，上限¥50--%>

                            <c:if test="${p.returnType=='1'}">
                                ${depositFee}
                            </c:if>
                            <c:if test="${p.returnType!='1'}">
                                ${fn:substringBefore(depositFee,"," )}
                            </c:if>

                            <%--${fn:substringBefore(depositFee,"," )}--%>
                            <%--<c:set var="indexof" value="${fn:indexOf(depositFee,',' )}"/>--%>
                            <%--<c:set var="depositFeeLength" value="${fn:length(depositFee)}"/>--%>
                            <%--<div class="co-grayc2">${fn:substring(depositFee,indexof+1,depositFeeLength)}</div>--%>

                            <%--<span class="co-red">-${p.returnMoney}${p.returnType=='1'?'%':''}</span>--%>
                        </c:if>
                        <c:if test="${!p.isReturnFee}">${views.role['PlayerRank.list.none']}</c:if>
                    </c:if>
                </td>
                <td>
                    <%--存款手续费收取--%>
                    <c:if test="${(not empty p.isFee && not empty p.isReturnFee && p.isFee) || (not empty p.isFee && empty p.isReturnFee)}">
                        <c:if test="${p.isFee}">
                            <c:if test="${not empty p.feeTime&&not empty p.freeCount}">
                                ${fn:replace(fn:replace(views.role['playerRank.view.cksxf'], "{hour}", p.feeTime), "{count}", p.freeCount)}
                            </c:if>
                            <c:if test="${empty p.feeTime&&empty p.freeCount}">
                                ${views.role['PlayerRank.view.wmf']}
                            </c:if>
                        </c:if>
                        <c:if test="${!p.isFee}">
                            ${views.role['PlayerRank.list.none']}
                        </c:if>
                    </c:if>
                    <c:if test="${(not empty p.isFee && not empty p.isReturnFee && p.isReturnFee) || (not empty p.isReturnFee && empty p.isFee)}">
                        <c:if test="${p.isReturnFee}">
                            <c:if test="${not empty p.returnTime&&not empty p.returnFeeCount}">
                                ${fn:replace(fn:replace(views.role['playerRank.view.ckfsxf'], "{hour}", p.returnTime), "{count}", p.returnFeeCount)}
                            </c:if>
                            <c:if test="${empty p.returnTime&&empty p.returnFeeCount}">
                                ${views.role['PlayerRank.list.none']}
                            </c:if>
                        </c:if>
                        <c:if test="${!p.isReturnFee}">
                            ${views.role['PlayerRank.list.none']}
                        </c:if>
                    </c:if>
                    <c:if test="${empty p.isReturnFee && empty p.isFee}">
                        ${views.role['PlayerRank.list.none']}
                    </c:if>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${p.withdrawFeeNum>0}">
                            <c:if test="${p.withdrawFeeType=='1'}">
                                ${views.player_auto['收取']}${p.withdrawFeeNum}%,&nbsp;${views.player_auto['上限']}${siteCurrencySign}${p.withdrawMaxFee}
                            </c:if>
                            <c:if test="${p.withdrawFeeType!='1'}">
                                ${views.player_auto['收取']}${siteCurrencySign}${p.withdrawFeeNum}
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            ${views.role['PlayerRank.view.w']}
                        </c:otherwise>
                    </c:choose>
                </td>
                <%--取款手续费--%>
                <td>
                    <c:choose>
                        <%--未免费--%>
                        <c:when test="${p.withdrawFeeType>0&& empty p.withdrawFreeCount}">
                        ${views.role['PlayerRank.view.wmf']}
                        </c:when>
                        <c:when test="${p.withdrawFeeType>0 && !p.isWithdrawFeeZeroReset}">
                            ${p.withdrawTimeLimit}${views.role['PlayerRank.list.hour']}<div class="co-grayc2">${views.role['PlayerRank.list.mian']}${p.withdrawFreeCount}${views.common['ci']}
                        </c:when>
                        <c:when test="${p.withdrawFeeType>0 && p.isWithdrawFeeZeroReset}">
                            ${views.column['启用0000重置']}<div class="co-grayc2">${views.role['PlayerRank.list.mian']}${p.withdrawFreeCount}${views.common['ci']}
                        </c:when>
                        <c:otherwise>
                            ${views.role['PlayerRank.view.w']}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${p.playerNum==0 && p.builtIn==false}">
                        <soul:button permission="role:rank_delete" target="${root}/playerRank/rank_delete.html?id=${p.id}" confirm="${views.player_auto['确认删除该层级']}" callback="query" text="${views.common['delete']}" opType="ajax" cssClass="co-blue">${views.common['delete']}</soul:button>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                    </c:if>
                    <a href="/playerRank/payLimit.html?strPayId=&rankId=${p.id}" class="co-blue" nav-target="mainFrame">${views.role['PlayerRank.list.deposit']}</a>
                    <span class="dividing-line m-r-xs m-l-xs">|</span>
                    <a href="/playerRank/withdrawLimit.html?search.id=${p.id}" class="co-blue" nav-target="mainFrame">${views.role['PlayerRank.list.Withdrawals']}</a>
                    <span class="dividing-line m-r-xs m-l-xs">|</span>
                    <soul:button target="${root}/playerRank/childEdit.html?id=${p.id}" text="${views.common['edit']}" cssClass="co-blue" opType="dialog" callback="saveOrForward" />
                    <span class="dividing-line m-r-xs m-l-xs">|</span>
                    <a href="/vPlayerRankStatistics/view.html?id=${p.id}" class="co-blue" nav-target="mainFrame">${views.common['detail']}</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>

<!--//endregion your codes 1-->
