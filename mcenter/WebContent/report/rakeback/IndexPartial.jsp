<%@ page import="so.wwb.gamebox.model.master.operation.po.RakebackBill" %>
<%@ page import="so.wwb.gamebox.model.report.rakeback.po.SiteRakebackPlayer" %>
<%--@elvariable id="sup" type="so.wwb.gamebox.model.report.rakeback.vo.SiteRakebackPlayerVo"--%>
<%--@elvariable id="sub" type="so.wwb.gamebox.model.master.operation.vo.RakebackBillVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="rbill" value="<%= RakebackBill.class %>" />
<c:set var="srp" value="<%= SiteRakebackPlayer.class %>" />
<div class="col-lg-12 m-t">
    <div class="wrapper white-bg shadow">
        <div class="sys_tab_wrap clearfix">
            <div class="m-sm"><b>${views.report['rakeback.list.result']}</b><span class="co-yellow m-l-md"><i class="fa fa-exclamation-circle"></i></span>
                <c:set var="status" value="${sub.search.settlementState}" />
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
                    <%--<button class="btn btn-outline btn-filter">${views.report['operate.list.export']}</button>--%>
                    <span class="detail <c:if test='${command.search.id == null}'>hide</c:if>">
                    <soul:button target="queryDetail" text="${views.report['rakeback.list.view']}" opType="function" cssClass="btn btn-outline btn-filter" />
                    </span>
                </div>
            </div>
        </div>
        <div class="dataTables_wrapper" role="grid">
            <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                <thead>
                <tr role="row" class="bg-gray">
                    <th>${views.report['rakeback.list.playerNum']}</th>
                    <c:forEach items="${command.apis}" var="api">
                        <th>${gbFn:getSiteApiName(api.apiId.toString())}</th>
                    </c:forEach>
                    <%--<c:if test="${noSub}">
                        <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
                        <soul:orderColumn poType="${srp}" property="rakebackTotal" column="${tips1} 应付返水"></soul:orderColumn>
                        <c:set var="tips2" value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.actual']}\" ><i class=\"fa fa-question-circle\"></i></span>"></c:set>
                        <soul:orderColumn poType="${srp}" property="rakebackActual" column="${tips2} 实付返水"></soul:orderColumn>
                    </c:if>
                    <c:if test="${!noSub}">
                        <c:set value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.total']}\"><i class=\"fa fa-question-circle\"></i></span>" var="tips1"></c:set>
                        <soul:orderColumn poType="${rbill}" property="rakebackTotal" column="${tips1} 应付返水"></soul:orderColumn>
                        <c:set var="tips2" value="<span tabindex=\"0\" class=\"m-l-sm help-popover\" role=\"button\" data-container=\"body\" data-toggle=\"popover\" data-trigger=\"focus\" data-placement=\"top\" data-content=\"${views.report['rakeback.help.actual']}\" ><i class=\"fa fa-question-circle\"></i></span>"></c:set>
                        <soul:orderColumn poType="${rbill}" property="rakebackActual" column="${tips2} 实付返水"></soul:orderColumn>
                    </c:if>--%>

                    <th>${views.report['rakeback.list.total']}<span
                            tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rakeback.help.total']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                    <th>${views.report['rakeback.list.actual']}<span
                            tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                            data-content="${views.report['rakeback.help.actual']}" data-original-title="" title=""><i class="fa fa-question-circle"></i></span></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <c:choose>
                        <c:when test="${noSub}">
                            <td>${soulFn:formatNumber(command.result.playerCount)}</td>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="isSub" value="${noSub}" />
                            <input type="hidden" name="pCount" value="${command.result.playerCount}" />
                            <td class="pnum">
                                <%--<a nav-target="mainFrame">${soulFn:formatNumber(command.result.playerCount)}</a>--%>
                                <span>${soulFn:formatNumber(command.result.playerCount)}</span>
                            </td>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach items="${command.apis}" var="api">
                        <td>${soulFn:formatCurrency(api.rakeback)}</td>
                    </c:forEach>
                    <td>${soulFn:formatCurrency(command.result.rakebackTotal)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${status eq 'pending_lssuing' || status eq 'reject_lssuing'}">
                                --
                            </c:when>
                            <c:otherwise>
                                ${soulFn:formatCurrency(command.result.rakebackActual)}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="col-lg-12 m-t">
    <div class="wrapper white-bg clearfix shadow">
        <div class="sys_tab_wrap clearfix">
            <div class="m-sm"><b>${views.report['rakeback.chart.title']}</b></div>
        </div>
        <div class="panel-body">
            <div class="dataTables_wrapper" role="grid">
                <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
            </div>
        </div>
    </div>
</div>
<%-- 游戏返水json --%>
<input type="hidden" value='${noSub ? command.chartJson : command.chartJson}' id="chartJson">
