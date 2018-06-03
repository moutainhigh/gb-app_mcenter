<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="so.wwb.gamebox.model.master.fund.enums.RechargeStatusEnum" %>
<%@ include file="/include/include.inc.jsp" %>

<c:set var="deal" value="<%= RechargeStatusEnum.DEAL.getCode() %>"/>
<c:set var="success" value="<%= RechargeStatusEnum.SUCCESS.getCode() %>"/>
<c:set var="exchange" value="<%= RechargeStatusEnum.EXCHANGE.getCode() %>"/>
<input type="hidden" name="search.playerId" value="${command.search.playerId}" />
<input id="todaySales" value="${command.search.todaySales}" hidden>
<div class="table-responsive table-min-h">
    <span id="totalSumSource" hidden>${command.totalSum}</span>
    <span id="todayTotalSource" hidden>${command.todayTotal}</span>
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['orderNum']}</th>
            <th>${views.column['VPlayerDeposit.username']}</th>
            <th>${views.column['VPlayerDeposit.rankName']}</th>
            <th>${views.fund_auto['创建时间']}</th>
            <th class="inline" style="width: 20%">
                <gb:select name="search.rechargeType" value="${command.search.rechargeType}"
                           cssClass="btn-group chosen-select-no-single" callback="query"
                           prompt="${views.fund['desposit.index.allType']}" list="${command.rechargeType}" listKey="key"
                           listValue="${dicts.fund.recharge_type[key]}"/>
            </th>
            <th>${views.column['VPlayerDeposit.bankCode.fullName']}</th>
            <th>${views.column['VPlayerDeposit.rechargeAmount']}</th>
            <th class="inline" style="text-align: center; padding-left: 30px">
                <gb:select name="search.rechargeStatus" value="${command.search.rechargeStatus}"
                           cssClass="btn-group chosen-select-no-single" callback="query"
                           prompt="${views.fund['desposit.index.allStatus']}" list="${command.rechargeStatus}"
                           listKey="key" listValue="${dicts.fund.recharge_status[key]}"/>
            </th>
            <th>${views.column['VPlayerDeposit.checkUsername']}</th>
            <th>${views.column['VPlayerDeposit.checkTime']}</th>
            <%--<th>${views.common['operate']}</th>--%>
            <th>${views.fund['备注']}</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
        <script id="VPlayerDepositListVo" type="text/x-jsrender">

            {{for data}}
                 <tr class="tab-detail">
                    <td>
                        <a href="{{:_url}}" nav-target="mainFrame" class="co-blue">{{:transactionNo}}</a></td>
                    </td>
                    <td>
                        <div class="al-cleft">
                            <shiro:hasPermission name="role:player_detail">
                                <a href="/player/playerView.html?search.id={{:playerId}}" nav-target="mainFrame" title="{{:username}}">
                            </shiro:hasPermission>
                            {{:username}}<shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
                            {{if riskMarker}}
                             <a href="javascript:void(0)" class="ico-lock co-red3" tabindex="0" data-content="${views.fund_auto['危险层级']}"
                                data-placement="right" data-trigger="focus" data-toggle="popover" data-container="body" role="button"><i class="fa fa-warning"></i></a>
                            {{/if}}
                            {{:_views_riskDataType}}
                        </div>

                    </td>
                    <td>
                        <a href="/vPlayerRankStatistics/view.html?id={{:rankId}}" nav-target="mainFrame">
                            <span class="label label-info">{{:rankName}}</span>
                        </a>
                    </td>
                    <td>
                        <span data-content="{{:_soulFn_formatDateTz_createTime}}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="ico-lock" tabindex="0" data-original-title="" title="">
                            <apan class="co-grayc2">{{:_soulFn_formatTimeMemo_createTime}}</apan>
                        </span>
                    </td>
                    <td style="width: 20%">
                         <a href="{{:_url}}" nav-target="mainFrame">
                            {{:_recharge_type_dict}}
                            {{if isFirstRecharge }}
                                <span class="co-orange">&nbsp;${views.fund['首存']}</span>
                            {{/if}}
                         <div class="list-note">
                         {{if payerBankcard!==''&& payerBankcard!==null}}
                                <span class="co-orange" data-content="{{:_fund_auto_data}}" data-placement="bottom"
                                data-trigger="focus" data-toggle="popover" data-container="body" role="button"
                                class="help-popover" tabindex="0">{{:payerBankcard}}</span>
                         {{/if}}
                         {{if  bankOrder !=''&&bankOrder !=null&&  rechargeType != 'bitcoin_fast'}}
                            <span data-content="{{:_bankOrder_data}}" data-placement="bottom" data-trigger="focus"
                            data-toggle="popover" data-container="body" role="button" class="help-popover"
                            tabindex="0"><em>[{{:bankOrder}}]</em></span>
                         {{/if}}
                         {{if rechargeAddress!=null && rechargeAddress!=''}}
                                <span data-content="${views.fund_auto['交易地点']}" data-placement="bottom" data-trigger="focus"
                                data-toggle="popover" data-container="body" role="button" class="help-popover"
                                tabindex="0">{{:rechargeAddress}}</span>
                         {{/if}}
                         {{if payerName!=='' && payerName!==null}}
                                <span data-content="${views.fund_auto['存款人姓名']}" data-placement="bottom" data-trigger="focus"
                                data-toggle="popover" data-container="body" role="button" class="help-popover"
                                tabindex="0">{{:payerName}}</span>
                         {{/if}}
                         </div>
                        </a>
                    </td>
                    <td>
                        <a href="/vPayAccount/detail.html?result.id={{:payAccountId}}&search.type=1" nav-target="mainFrame">
                            {{if customBankName!=='' && customBankName!==null}}
                                {{:customBankName}}-
                            {{else}}
                                {{:_dicts_common_bankname_bankCode}}
                            {{/if}}
                            {{:fullName}}
                        </a>
                    </td>
                    <td class="money">
                        {{if favorableTotalAmount>0}}
                            <span data-content="${views.fund_auto['优惠金额']}<span class='co-blue'>{{:_currencySign}}&nbsp;{{:_soulFn_formatInteger_favorableTotalAmount}}{{:_soulFn_formatDecimals_favorableTotalAmount}}</span>"
                             data-placement="top" data-trigger="focus"
                            data-toggle="popover" data-html="true"
                            data-container="body" role="button" class="help-popover" tabindex="0">
                            <span class="fee blue"></span>
                            </span>
                        {{/if}}

                        {{if favorableTotalAmount==null||favorableTotalAmount==0}}
                            <span data-content="${views.fund_auto['无优惠金额']}" data-placement="top" data-trigger="focus"
                            data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            <span class="fee none"></span>
                            </span>
                        {{/if}}
                        {{if counterFee<0}}
                            <span data-content="${views.fund_auto['手续费']}<span class='co-red'>{{:_currencySign}}&nbsp;{{:_soulFn_formatInteger_counterFee}}{{:_soulFn_formatDecimals_counterFee}}</span>"
                            data-toggle="popover" data-html="true"
                            data-container="body" role="button" class="help-popover" tabindex="0">
                            <span class="fee negative"></span>
                        </span>
                        {{/if}}
                        {{if counterFee>0}}
                            <span data-content="${views.fund_auto['返还手续费']}<span class='co-green'>{{:_currencySign}}&nbsp;{{:_soulFn_formatInteger_counterFee}}{{:_soulFn_formatDecimals_counterFee}}</span>"
                            data-toggle="popover" data-html="true"
                            data-container="body" role="button" class="help-popover" tabindex="0">
                            <span class="fee positive"></span>
                            </span>
                        {{/if}}
                        {{if counterFee==0||counterFee==null}}
                            <span data-content="${views.fund_auto['免手续费']}" data-placement="top" data-trigger="focus"
                            data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            <span class="fee none"></span>
                            </span>
                        {{/if}}
                        {{if rechargeAmount !==0}}
                            {{:_currencySign}}&nbsp;{{:_soulFn_formatInteger_rechargeAmount}}<i>{{:_soulFn_formatDecimals_rechargeAmount}}</i>
                        {{/if}}
                        {{if bitAmount>0}}
                            &nbsp;
                            <span data-content="${views.fund_auto['比特币']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                            Ƀ{{:_bitAmount_formatNumber}}
                            </span>
                        {{/if}}
                </td>
                <td align="center">
                    {{if rechargeStatus =='${deal}'}}
                        <shiro:hasPermission name="fund:companydeposit_check">
                            <soul:button permission="fund:companydeposit_check" deposit_id="{{:id}}" target="confirmCheckPass" text="${views.fund_auto['通过']}" opType="function"
                                         cssClass="btn btn-sm btn-success-hide m-x-xs" tag="button">
                                 <i class="fa fa-check"></i>${views.fund['通过']}
                            </soul:button>
                        <soul:button permission="fund:companydeposit_check" deposit_id="{{:id}}" target="checkFailure" text="${views.fund_auto['失败']}" opType="function"
                         cssClass="btn btn-sm btn-danger-hide m-x-xs" tag="button">
                        <i class="fa fa-close"></i>${views.fund['失败']}
                        </soul:button>
                        </shiro:hasPermission>
                        <shiro:lacksPermission name="fund:companydeposit_check">
                            <a href="/fund/deposit/company/view.html?search.id={{:id}}" nav-target="mainFrame" class="co-blue">
                                <span class="label {{:statusCss}} p-x-md">
                                {{:_recharge_status_dicts}}
                                </span>
                            </a>
                        </shiro:lacksPermission>
                    {{else rechargeStatus =='${exchange}'}}
                        <soul:button  target="${root}/fund/deposit/company/exchange.html?search.id={{:id}}" text="${views.fund_auto['兑换']}" opType="dialog"
                                      cssClass="btn btn-sm btn-success-hide m-x-xs" tag="button" callback="callBackQuery">
                            <i class="fa fa-check"></i>${views.fund_auto['兑现']}
                        </soul:button>
                        <soul:button permission="fund:companydeposit_check" deposit_id="{{:id}}" target="checkFailure" text="${views.fund_auto['失败']}" opType="function"
                                     cssClass="btn btn-sm btn-danger-hide m-x-xs" tag="button">
                            <i class="fa fa-close"></i>${views.fund['失败']}
                        </soul:button>
                    {{else}}
                        <a href="{{:_url}}" nav-target="mainFrame">
                        <span class="label {{:statusCss}} p-x-md">{{:_recharge_status_dicts}}</span>
                        </a>
                    {{/if}}
                    {{if origin =='2' or origin =='MOBILE'}}
                        <span class="fa fa-mobile mobile" data-content="${views.fund_auto['手机存款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                        </span>
                    {{else origin =='8'}}
                        <span class="fa gui-html5 mobile" data-content="${views.fund_auto['手机端H5存款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                        </span>
                    {{else origin =='12'}}
                        <span class="fa gui-android mobile" data-content="${views.fund_auto['手机端ANDROID存款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                        </span>
                    {{else origin =='16'}}
                        <span class="fa gui-apple mobile" data-content="${views.fund_auto['手机端IOS存款']}" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover" tabindex="0">
                        </span>
                    {{else }}
                        <span style="width:8px; display: inline-block"></span>
                    {{/if}}
                </td>
                <td>
                    {{if rechargeStatus =='${deal}'}}
                    --
                    {{else}}
                    {{:checkUsername}}
                    {{/if}}
                </td>
                <td colspan="co-grayc2">
                   {{if rechargeStatus =='${deal}'}}
                    --
                   {{else}}
                        <span data-content="{{:_soulFn_formatDateTz_checkTime}}"
                        data-placement="top" data-trigger="focus" data-toggle="popover"
                        data-container="body" role="button" class="help-popover co-grayc2" tabindex="0">
                        <a name="copy"
                        data-clipboard-text="{{:_soulFn_formatDateTz_checkTime}}">
                        <apan class="co-grayc2">{{:_soulFn_formatTimeMemo_checkTime}}</apan>
                        </a>
                        </span>
                   {{/if}}
                </td>
                <td>
                    {{if ipDeposit !==''&&ipDeposit!==null}}
                    IP:
                    <span data-content="{{:_gbFn_getIpRegion_ipDictCode}}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                    data-container="body" role="button" class="help-popover" tabindex="0">
                    <span>
                    <a nav-target="mainFrame" href="/report/log/logList.html?search.roleType=player&search.ip={{:_ipDeposit_ipv4LongToString}}&keys=search.ip&hasReturn=true">{{:_ipDeposit_ipv4LongToString}}</a>
                    </span>
                    </span>
                    <br/>
                {{/if}}
                {{if _checkRemark_length>20}}
                    <span data-content="{{:checkRemark}}" data-placement="bottom" data-trigger="focus" data-toggle="popover"
                    data-container="body" role="button" class="help-popover" tabindex="0">
                    {{:_checkRemark_sub}}...
                    </span>
                {{else}}
                    {{:checkRemark}}
                {{/if}}
                </td>

                </tr>
            {{/for}}


        </script>
    </table>
</div>
