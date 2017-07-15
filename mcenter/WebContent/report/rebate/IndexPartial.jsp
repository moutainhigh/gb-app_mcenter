<%@ page import="so.wwb.gamebox.model.master.operation.po.RebateBill" %>
<%@ page import="so.wwb.gamebox.model.report.rebate.po.SiteRebate" %>
<%--@elvariable id="sup" type="so.wwb.gamebox.model.report.rebate.vo.SiteRebateVo"--%>
<%--@elvariable id="sub" type="so.wwb.gamebox.model.master.operation.vo.RebateAgentVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="rbill" value="<%= RebateBill.class %>" />
<c:set var="srp" value="<%= SiteRebate.class %>" />
<div class="col-lg-12 m-t">
    <div class="wrapper white-bg shadow">
        <div class="sys_tab_wrap clearfix">
            <div class="m-sm">
                <b>
                    ${views.report['rakeback.list.result']}
                </b>
                <span class="co-yellow m-l-md"><i class="fa fa-exclamation-circle"></i></span>
                <c:set var="status" value="${command.search.settlementState}" />
                <c:choose>
                    <c:when test="${status eq 'pending_lssuing'}">
                        ${views.report['rakeback.list.state.pending_lssuing']}
                    </c:when>
                    <c:when test="${status eq 'lssuing'}">
                        ${views.report['rakeback.list.state.lssuing']}
                    </c:when>
                    <c:when test="${status eq 'reject_lssuing'}">
                        ${views.report['rakeback.list.state.reject_lssuing']}
                    </c:when>
                    <c:otherwise>
                        ${views.report['rakeback.list.state.selment']}
                    </c:otherwise>
                </c:choose>
                <div class="pull-right m-t-n-xxs">
                    <c:set var="isShow" value="${command.search.id}" />
                    <span class="detail <c:if test='${isShow == null}'>hide</c:if>">
                    <soul:button target="queryDetail" text="${views.report['rakeback.list.view']}" opType="function"
                                 cssClass="btn btn-outline btn-filter" />
                    </span>
                </div>
            </div>
        </div>
        <div class="dataTables_wrapper" role="grid">
            <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                <thead>
                <tr role="row" class="bg-gray">
                    <th>${views.column['VRebateReport.effectivePlayer']}</th>
                    <th>${views.column['VRebateReport.effectiveTransaction']}</th>
                    <th>${views.column['VRebateReport.profitLoss']}<span
                            tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rebate.help.profitLoss']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.depositAmount']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-html="true" data-trigger="focus" data-placement="top" data-content="<p>${views.report_auto['包含人工存入的']}<br/><span class='co-grayc2'>PS:${views.report_auto['仅统计']}</span></p>" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.withdrawalAmount']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-html="true" data-trigger="focus" data-placement="top" data-content="${views.report_auto['含人工取出的“人工存取”']}" data-original-title="" title="" aria-describedby="popover705884"><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.backwater']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-html="true" data-trigger="focus" data-placement="top" data-content="<p>1.${views.report_auto['该代理体系下玩家获得的返水；']}</p><p>2.${views.report_auto['包含人工存入的返水']}</p>" data-original-title="" title="" aria-describedby="popover60472"><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.preferentialValue']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-html="true" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="<p>${views.report_auto['包含以下三部分费用']}：</p><p>1.${views.report_auto['该代理体系下玩家通过站长发布的优惠活动获得的优惠金额（不含返水)；']}</p><p>2.${views.report_auto['管理员通过后台手动给玩家存入的优惠金额(含优惠活动/派彩/其他)']}<br/><span class='co-grayc2'>PS:${views.report_auto['仅统计']}</span></p>" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.refundFee']}<span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-html="true" data-toggle="popover" data-trigger="focus" data-placement="top" data-content="<p>${views.report_auto['返还给玩家的手续费。']}</p><p><span class='co-grayc2'>PS：${views.report_auto['站长收款时被第三方或银行扣掉的手续费，请自行线下跟代理结算。']}</span></p>" data-original-title="" title="" aria-describedby="popover267683"><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.deductExpenses']}<span
                            tabindex="0" class="m-l-sm help-popover" role="button" data-html="true" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rebate.help.appro']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.prevUnsettled']}
                        <span data-content="${views.report['rebate.help.unsettled']}" data-html="true" class="m-l-sm help-popover"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" tabindex="0" data-original-title="" title=""><i class="fa fa-question-circle"></i>
                        </span>
                    </th>
                    <%--<c:if test="${noSub}">
                        <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
                        <soul:orderColumn poType="${srp}" property="rebateTotal" column="${tips1} ${views.column['VRebateReport.rebateTotal']}"></soul:orderColumn>
                        <c:set var="tips2" value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.actual']}\" ><i class=\"fa fa-question-circle\"></i></span>"></c:set>
                        <soul:orderColumn poType="${srp}" property="rebateActual" column="${tips2} ${views.column['VRebateReport.rebateActual']}"></soul:orderColumn>
                    </c:if>--%>
                    <%--<c:if test="${!noSub}">
                        <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
                        <soul:orderColumn poType="${rbill}" property="rebateTotal" column="${tips1} ${views.column['VRebateReport.rebateTotal']}"></soul:orderColumn>
                        <c:set var="tips2" value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.actual']}\" ><i class=\"fa fa-question-circle\"></i></span>"></c:set>
                        <soul:orderColumn poType="${rbill}" property="rebateActual" column="${tips2} ${views.column['VRebateReport.rebateActual']}"></soul:orderColumn>
                    </c:if>--%>
                    <th>${views.column['VRebateReport.rebateTotal']}<span
                            tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rebate.help.total']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.column['VRebateReport.rebateActual']}<span
                            tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rebate.help.actual']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                </tr>
                </thead>
                <tbody>
                <c:set var="p" value="${command.result}"/>
                <tr>
                    <c:choose>
                        <c:when test="${p.effectivePlayer == null || p.effectivePlayer == '' || p.effectivePlayer==0}">
                            <td>0</td>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="pCount" value="${p.effectivePlayer}" />
                            <td class="co-blue pnum"><a nav-target="mainFrame">${soulFn:formatNumber(p.effectivePlayer)}</a></td>
                        </c:otherwise>
                    </c:choose>
                    <td class="co-blue">${soulFn:formatCurrency(p.effectiveTransaction)}</td>
                    <td>${soulFn:formatCurrency(p.profitLoss)}</td>
                    <td class="co-blue">${soulFn:formatCurrency(p.depositAmount)}</td>
                    <td class="co-blue">${soulFn:formatCurrency(p.withdrawalAmount)}</td>
                    <td class="co-blue">${soulFn:formatCurrency(p.rakeback)}</td>
                    <td>${soulFn:formatCurrency(p.preferentialValue)}</td>
                    <td class="co-blue">${soulFn:formatCurrency(p.refundFee)}</td>
                    <td>${soulFn:formatCurrency(p.apportion)}</td>
                    <td>${soulFn:formatCurrency(p.historyApportion)}</td>
                    <td>${soulFn:formatCurrency(p.rebateTotal)}</td>
                    <td>${soulFn:formatCurrency(p.rebateActual)}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="col-lg-12 m-t">
    <div class="wrapper white-bg clearfix shadow">
        <div class="sys_tab_wrap clearfix">
            <div class="m-sm"><b>${views.report['rebate.chart.title']}</b></div>
        </div>
        <div class="panel-body">
            <div class="dataTables_wrapper" role="grid">
                <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
            </div>
        </div>
    </div>
</div>
<%-- 游戏返佣json --%>
<input type="hidden" value='${command.chartJson}' id="chartJson">
