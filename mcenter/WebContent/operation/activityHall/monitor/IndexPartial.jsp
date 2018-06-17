<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th><input type="checkbox" class="i-checks"></th>
            <th>${views.operation['优惠订单号']}</th>
            <th>${views.column['VActivityPlayerApply.playerName']}</th>
            <th>${views.column['VActivityMessage.activityName']}</th>
            <th>${views.column['VActivityPlayerApply.applyTime']}</th>
            <th class="inline">
                <gb:select name="search.code" value="${command.search.code}" cssClass="btn-group chosen-select-no-single" callback="query" prompt="${views.operation['Activity.list.allType']}" list="${activityType}"></gb:select>
            </th>
            <th>${views.operation['申请优惠金额']}</th>
            <th>${views.operation['Activity.step.audit']}</th>
            <th>
                <span title="${views.operation['仅展示检测通过的玩家申请']}">
                 ${views.operation['活动检测结果']}
                     <i class="fa fa-question-circle"></i>
                </span>

            </th>
            <%--<th class="inline">--%>
                <%--<gb:select name="search.code" value="${command.search.code}"--%>
                           <%--cssClass="btn-group chosen-select-no-single" callback="query"--%>
                           <%--prompt="${views.operation['Activity.list.allType']}" list="${activityType}"></gb:select>--%>
            <%--</th>--%>
            <%--<th class="inline">--%>
                <%--<gb:select name="search.activityClassifyKey" value="${command.search.activityClassifyKey}"--%>
                           <%--cssClass="btn-group chosen-select-no-single" callback="query"--%>
                           <%--prompt="${views.operation['Activity.list.allCategory']}" list="${siteI18ns}" listKey="key"--%>
                           <%--listValue="value"></gb:select>--%>
            <%--</th>--%>
            <th>
                <%--<gb:select name="search.checkState" value="${command.search.checkState}" prompt="${views.operation['活动审批']}" list="${checkStatusDicts}" callback="query"/>--%>
                <%--<gb:select name="search.checkState" value="${command.search.checkState}" prompt="${views.operation['活动审批']}" list="${checkStatusDicts}" callback="query"/>--%>
                <gb:select name="search.checkState" value="${command.search.checkState}" list="{'1':'${views.operation['待处理']}','2':'${views.operation['已通过']}','3':'${views.operation['已拒绝']}'}" prompt="${views.common['all']}" callback="query"/>
            </th>
            <th>${views.operation['backwater.settlement.view.operator']}</th>
            <th>${views.operation['申请IP']}</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <tr class="tab-detail">
                <td>
                    <input type="checkbox" class="i-checks" value="${p.id}" ${p.checkState ne '1'?'disabled="disabled"':''}>
                    <label>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</label>
                </td>
                <td>
                    ${p.transactionNo}
                </td>
                <td>
                    <a href="/player/playerView.html?search.id=${p.playerId}" nav-Target="mainFrame">${p.playerName}</a>
                    <c:if test="${p.riskMarker == true}">
                                <span data-content="${views.player_auto['危险层级']}"
                                      data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                      role="button" class="ico-lock co-red3" tabindex="0"
                                      data-original-title="" title=""><i class="fa fa-warning"></i></span>
                    </c:if>
                    ${gbFn:riskImgByName(p.playerName)}
                </td>
                <td>${p.activityName}</td>
                <td>${soulFn:formatDateTz(p.applyTime,DateFormat.DAY_SECOND,timeZone)}</td>
                <td>${views.operation[p.code]}</td>
                <td>${p.preferentialValue}</td>
                <td>${p.preferentialAudit}</td>
                <td>
                    <div style="display: none"></div>
                    <span tabindex="0" detailId="${p.id}" activityType="${p.code}" class=" help-popover m-r-xs co-blue3 showMonitorDetail" role="button" data-container="body" data-toggle="popover" data-trigger="click" data-placement="top" data-html="true"
                          data-content=""
                          data-original-title="" title="">
                                         查看详情
                                        </span>
                    <%--<span tabindex="0" class=" help-popover m-r-xs co-blue3" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true"--%>
                          <%--data-content="首存金额：100.00元--%>
                                        <%--<br>--%>
                                        <%--有效交易额：100,100,100.00元--%>
                                        <%--<br>参与游戏：xx电子，xx体育--%>
                                        <%--<br>注单号：316254654--%>
                                        <%--<br>存款金额：156,211.00--%>
                                        <%--<br>--%>
                                        <%--存款成功单号：54646445"--%>
                          <%--data-original-title="" title="">--%>
                                         <%--查看详情--%>
                                        <%--</span>--%>

                </td>
                <%--<td>${views.operation[p.code]}</td>--%>
                <%--<td>${siteI18nMap[p.activityClassifyKey].value}</td>--%>

                <td>
                    <c:if test="${p.checkState eq '0'}">
                        <span class="label label-info">${dicts.operation.activity_apply_check_status[p.checkState]}</span>
                    </c:if>
                    <c:if test="${p.checkState eq '1'}">
                        <%--<span class="label label-warning">${dicts.operation.activity_apply_check_status[p.checkState]}</span>--%>
                        <soul:button permission="operate:activityHall_checkapply"  target="${root}/activityHall/vActivityPlayerApply/successDialog.html?code=${p.code}&ids=${p.id}&sumPerson=1"
                                     text="${views.operation['同意派奖']}" opType="dialog" callback="callBackQuery"/>

                        <soul:button permission="operate:activityHall_checkapply"  target="${root}/activityHall/vActivityPlayerApply/auditStatus.html?&result.checkState=3&activityType=&ids=${p.id}"
                                     text="${views.operation['拒绝派奖']}" opType="ajax" post="" precall="hasFailReason" callback="query"
                                     cssClass="co-red3" applyId="${p.id}"/>
                        <shiro:lacksPermission name="operate:activityHall_checkapply">
                            ${views.operation['待处理']}
                        </shiro:lacksPermission>



                    </c:if>
                    <c:if test="${p.checkState eq '2'}">
                        <span class="co-green">${views.operation['已通过']}</span>
                    </c:if>
                    <c:if test="${p.checkState eq '3'}">
                        <span class="co-red3">${views.operation['已拒绝']}</span>
                    </c:if>
                    <c:if test="${p.checkState eq '4'}">
                        <span class="co-red3">${views.operation['未达到条件']}</span>
                    </c:if>

                </td>
                <td>
                    <c:if test="${p.checkState eq '1' || p.checkState eq '4'}">
                        --
                    </c:if>
                    <c:if test="${p.checkState eq '2' || p.checkState eq '3'}">
                        <c:if test="${empty p.checkUserId}">
                            ${views.operation['系统自动']}
                        </c:if>
                        <c:if test="${not empty p.checkUserId}">
                            ${p.username}

                        </c:if>
                    </c:if>
                </td>
                <td>
                        ${soulFn:formatIp(p.ipApply)}
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<soul:pagination/>
<!--//endregion your codes 1-->
