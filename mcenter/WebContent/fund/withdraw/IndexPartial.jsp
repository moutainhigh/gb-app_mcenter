<%@ page import="org.soul.web.session.RedisSessionDao" %>
<%@ page import="so.wwb.gamebox.model.enums.UserTypeEnum" %><%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerWithdrawListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<style type="text/css">
    .auditLogCss .modal-dialog{
        max-width:900px;
        width: 100%;
    }
</style>
<a href="" id="showDetail" nav-target="mainFrame" class="co-blue"></a>
<input type="hidden" name="search.deductSum" value="${command.search.deductSum}">
<span id="totalSumSource" hidden>${command.totalSum}</span>
<span id="todayTotalSource" hidden>${command.todayTotal}</span>
<input id="todaySales" value="${command.search.todaySales}" hidden>
    <div class="table-responsive table-min-h">
        <table class="table table-striped table-hover dataTable m-b-sm" aria-describedby="editable_info" id="editable">
            <thead>
            <tr role="row" class="bg-gray">
                <th>${views.fund['交易号']}</th>
                <th>${views.column["VPlayerWithdraw.username"]}</th>
                <th>${views.fund_auto['玩家层级']}</th>
                <th>${views.column["VPlayerWithdraw.createTime"]}</th>
                <th>${views.column["VPlayerWithdraw.successCount"]}</th>
                <th>${views.fund_auto['费用扣除']}</th>
                <th>${views.column["VPlayerWithdraw.withdrawActualAmount"]}</th>
                <th class="inline" style="padding-left: 30px;">
                    <div>
                        <gb:select name="search.withdrawStatus" cssClass="btn-group chosen-select-no-single" prompt="${views.fund['withdraw.index.playerWithdraw.all']}" list="${siteWithdrawStatus}" value="${command.search.withdrawStatus}" callback="query" />
                    </div>
                </th>
                <th>${views.fund_auto['审核人']}</th>
                <th>${views.fund_auto['审核时间']}</th>
                <%--出款--%>
                <c:if test="${isSwitch}">
                    <th>出款确认</th>
                    <th>确认人</th>
                    <th>确认时间</th>
                </c:if>
                <th>${views.fund_auto['备注']}</th>
            </tr>
            </thead>
            <tbody class="table-tbody withdraw-tbody-record">
            </tbody>
        </table>
    </div>

<script id="VPlayerWithdrawListVo" type="text/x-jsrender">
    {{for data}}
        <tr class="tab-detail" id="record_id_{{:id}}">
            <td>
                <input type="hidden" name="id" value="{{:id}}"/>
                <a href="/fund/withdraw/withdrawAuditView.html?search.id={{:id}}&pageType=detail" nav-target="mainFrame" class="co-blue">{{:transactionNo}}</a>
            </td>
            <td>
                <shiro:hasPermission name="role:player_detail">
                    <a  href="/player/playerView.html?search.id={{:playerId}}" nav-Target="mainFrame">
                        </shiro:hasPermission>
                            {{:username}}
                        <shiro:hasPermission name="role:player_detail">
                    </a>
                </shiro:hasPermission>
                {{if riskMarker}}
                    <span data-content="${views.fund_auto['危险层级']}"
                    data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                    role="button" class="ico-lock co-red3 help-popover" tabindex="0"
                    data-original-title="" title=""><i class="fa fa-warning"></i>&nbsp;</span>
                {{/if}}
                {{if _userActiveSession}}
                    <span data-content="${views.role['player.list.icon.online']}"
                    data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                    role="button" class="ico-lock help-popover" tabindex="0"
                    data-original-title="" title=""><i class="fa fa-flash"></i></span>
                {{/if}}
            <td>
                <a href="/vPlayerRankStatistics/view.html?id={{:rankId}}" nav-target="mainFrame">
                {{if riskMarker}}
                    <span data-content="${views.fund_auto['危险层级']}" data-placement="right" data-trigger="focus" data-toggle="popover"
                    data-container="body" role="button" class="help-popover" tabindex="0">
                    <span class="label label-danger">{{:rankName}}</span>
                    </span>
               {{else}}
                    <span class="label label-info">{{:rankName}}</span>
                {{/if}}
                </a>
            </td>
            <td>
                <span data-content="{{:_formatDateTz_createTime}}" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <a name="copy" data-clipboard-text="{{:_formatDateTz_createTime}}">
                        <span class="co-grayc2">{{:createTimeMemo}}</span>
                    </a>
                </span>
            </td>
            <td>{{if successCount == null}}0 {{else}}{{:successCount}}{{/if}}${views.fund['次']}</td>
            <td class="money">
                <span data-content="{{if counterFee == 0 ||counterFee==null}}${views.fund_auto['无手续费']}{{else}}${views.fund_auto['手续费']}{{:_currency_symbol_withdrawMonetary}}{{:counterFee}}{{/if}}" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <span class="fee {{if counterFee == 0 ||counterFee==null}}none{{/if}}{{if counterFee!=null && counterFee != 0}}red{{/if}}"></span>
                </span>
                <span data-content="{{if administrativeFee == 0 ||administrativeFee==null}}${views.fund_auto['无行政费']}{{else}}${views.fund_auto['行政费']}{{:_currency_symbol_withdrawMonetary}}{{:administrativeFee}}{{/if}}" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <span class="fee {{if administrativeFee == 0 ||administrativeFee==null }}none{{/if}}{{if administrativeFee!=null && administrativeFee != 0}}blue{{/if}}"></span>
                </span>
                <span data-content="{{if deductFavorable == 0 ||deductFavorable==null}}${views.fund_auto['无扣除优惠']}{{else}}${views.fund_auto['扣除优惠']}{{:_currency_symbol_withdrawMonetary}}{{:deductFavorable}}{{/if}}" data-placement="top" data-trigger="focus" data-toggle="popover"
                      data-container="body" role="button" class="help-popover" tabindex="0">
                    <span class="fee {{if deductFavorable == 0||deductFavorable==null}}none{{/if}}{{if deductFavorable!=null && deductFavorable != 0}}orange{{/if}}"></span>
                </span>
            </td>
            <td class="money">
                {{if withdrawActualAmount != null }}
                {{:_currency_symbol_withdrawMonetary}}&nbsp;{{:_withdrawActualAmount_formatInteger}}<i>{{:_withdrawActualAmount_formatDecimals}}</i>
                <a name="copy" data-clipboard-text="{{:withdrawActualAmount}}"
                class="btn btn-xs btn-info btn-stroke"><li class="fa fa-copy" ></li></a>
                {{if bitAmount!=null && bitAmount!=0}}
                    &nbsp;Ƀ{{:_bitAmount_formatNumber}}
                {{/if}}
                {{/if}}
            </td>
            <td>
                {{if withdrawStatus=='1'}}
                    {{if isLock=='1'}}
                            <span data-content="${views.fund_auto['锁定人']}{{:lockPersonName}}" data-placement="left" data-trigger="focus"
                            data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            {{if _islockPersonId}}
                                <soul:button target="cancelLockOrder" text="${views.fund_auto['取消锁定']}" opType="function" objId="{{:id}}">
                                    <span class="fa fa-lock" style="width: 12.67px;"></span>
                                </soul:button>
                            {{else}}
                                <soul:button target="cancelLockOrder" text="${views.fund_auto['取消锁定']}" opType="function"
                                             confirm="{{:_lockPersonName_replace}})}" objId="{{:id}}">
                                    <span class="fa fa-lock" style="width: 12.67px;"></span>
                                </soul:button>
                            {{/if}}
                            </span>
                        {{else}}
                            <soul:button target="lockOrder" text="${views.fund_auto['点击锁定']}" opType="function" objId="{{:id}}">
                                <span class="fa fa-unlock"></span>
                            </soul:button>
                    {{/if}}
                {{/if}}
                {{if withdrawStatus!='1'}}
                    <span style="width:12.67px; display: inline-block"></span>
                {{/if}}
                {{if withdrawStatus=='1'||withdrawStatus=='2'}}
                    <soul:button  dataId="{{:id}}" target="withdrawAuditView"  callback="query"  size="auditLogCss" cssClass="label label-info p-x-md" text="{{:_dicts_fund_withdraw_status}}" opType="function" />
                {{/if}}
                {{if withdrawStatus=='4'}}
                    <soul:button target="withdrawAuditView" dataId="{{:id}}" size="auditLogCss" cssClass="label label-success p-x-md" text="{{:_dicts_fund_withdraw_status}}" opType="function" />
                    {{if remittanceWay=='2'&&checkStatus=='success'}}
                        &nbsp;[${views.fund_auto['未兑币']}]
                    {{/if}}
                    {{if remittanceWay=='2'&&checkStatus=='exchange_bit'}}
                        &nbsp;[${views.fund_auto['已兑币']}]
                    {{/if}}
                    {{if remittanceWay=='2'&&checkStatus=='automatic_pay'}}
                        &nbsp;[${views.fund_auto['已打款']}]
                    {{/if}}
                {{/if}}
                {{if withdrawStatus=='5'}}
                    <soul:button target="withdrawAuditView" dataId="{{:id}}" size="auditLogCss" cssClass="label label-danger p-x-md" text="{{:_dicts_fund_withdraw_status}}" opType="function" />
                {{/if}}
                {{if withdrawStatus=='6'}}
                    <soul:button target="withdrawAuditView" dataId="{{:id}}" size="auditLogCss" cssClass="label label-warning p-x-md" text="{{:_dicts_fund_withdraw_status}}" opType="function" />
                {{/if}}
                {{if origin == 'MOBILE'}}
                    <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机取款']}" data-placement="top" data-trigger="focus"
                    data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0" style="padding-left: 5px;">
                    </span>
                {{/if}}
                <input type="hidden" name="id" value="{{:id}}"/>
            </td>
            <td>
                {{if withdrawStatus != '1'}}
                   {{:checkUserName}}
                {{else}}
                    --
                {{/if}}
            </td>
            <td>
                <span class="co-grayc2">
                    {{if withdrawStatus != '1'}}
                        <span data-content="{{:_formatDateTz_checkTime}}" data-placement="top" data-trigger="focus" data-toggle="popover"
                        data-container="body" role="button" class="help-popover" tabindex="0">
                        <a name="copy" data-clipboard-text="{{:_formatDateTz_checkTime}}">
                        <span class="co-grayc2" >{{:checkTimeMemo}}</span>
                        </a>
                        </span>
                    {{else}}
                        --
                    {{/if}}
                </span>
            </td>
            <%--出款列表--%>
            {{if _isSwitch}}
                <td>
                    {{if withdrawStatus=='4'}}
                        {{if checkStatus=='success'}}
                        <shiro:hasPermission name="fund:withdraw_payment">
                            <soul:button target="${root}/fund/withdraw/payment.html?search.transactionNo={{:transactionNo}}" callback="query" confirm="确认出款？" cssClass="label label-info p-x-md" text="出款" opType="ajax" />
                        </shiro:hasPermission>
                        <shiro:lacksPermission name="fund:withdraw_payment">
                            <span class="label p-x-md">出款</span>
                        </shiro:lacksPermission>
                        {{/if}}
                        {{if checkStatus=='payment_processing'}}
                            <soul:button target="withdrawStatusView" dataId="{{:id}}" size="auditLogCss" callback="query" cssClass="label label-timeout p-x-md" text="出款处理中" opType="function" />
                        {{/if}}
                        {{if checkStatus=='payment_success'}}
                            <span class="label label-success p-x-md">出款成功</span>
                        {{/if}}
                        {{if checkStatus=='payment_fail'}}
                            <%--<shiro:hasPermission name="fund:withdraw_payment">--%>
                                <soul:button target="withdrawStatusView" dataId="{{:id}}" size="auditLogCss" callback="query" cssClass="label label-danger p-x-md" text="出款失败" opType="function" />
                            <%--</shiro:hasPermission>--%>
                            <%--<shiro:lacksPermission name="fund:withdraw_payment">--%>
                                <%--<span class="label p-x-md">出款失败</span>--%>
                            <%--</shiro:lacksPermission>--%>
                        {{/if}}
                    {{else}}
                        --
                    {{/if}}
                </td>
                <td>
                    {{if withdrawCheckUsername!=null&&withdrawCheckUsername!=''}}
                        {{:withdrawCheckUsername}}
                    {{else}}
                        --
                    {{/if}}
                </td>
                <td>
                    {{if withdrawCheckTime!=null&&withdrawCheckTime!=''}}
                        <span data-content="{{:_formatDateTz_withdrawCheckTime}}" data-placement="top" data-trigger="focus" data-toggle="popover"
                          data-container="body" role="button" class="help-popover" tabindex="0">
                        <a name="copy" data-clipboard-text="{{:_formatDateTz_withdrawCheckTime}}">
                            <span class="co-grayc2">{{:withdrawCheckTimeMemo}}</span>
                        </a>
                </span>
                    {{else}}
                        --
                    {{/if}}
                </td>
            {{/if}}
            <td>
                {{if ipWithdraw!=null&&ipWithdraw!=''}}
                    IP:
                    <span data-content="{{:_getIpRegion_ipDictCode}}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                    data-container="body" role="button" class="help-popover" tabindex="0">
                    <span>
                    <a nav-target="mainFrame" href="/report/log/logList.html?search.roleType=player&search.ip={{:_ipWithdraw_ipv4LongToString}}&keys=search.ip&hasReturn=true">{{:_ipWithdraw_ipv4LongToString}}</a>
                    </span>
                    </span>
                    <br/>
                {{/if}}
                {{if _checkRemark_length>20}}
                    <span data-content="{{:checkRemark}}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                    data-container="body" role="button" class="help-popover" tabindex="0">
                    {{:_checkRemark_substring}}..
                    </span>
                {{else}}
                    {{:checkRemark}}
                {{/if}}
            </td>
        </tr>
    {{/for}}
</script>