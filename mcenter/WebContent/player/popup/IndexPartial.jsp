<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%@ page import="so.wwb.gamebox.model.master.player.po.VUserPlayer" %>
<c:set var="poType" value="<%= VUserPlayer.class %>"></c:set>
<div class="table-responsive table-min-h">
    <input type="hidden" name="search.rankId" value="${command.search.rankId}">
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.common['number']}</th>
            <th>${views.player_auto['账号']}</th>
            <th>${views.player_auto['真实姓名']}</th>
            <th>${views.player_auto['所属代理']}</th>
            <soul:orderColumn poType="${poType}" property="createTime" column="${views.player_auto['注册时间']}"/>
            <th>${views.player_auto['层级']}</th>
            <soul:orderColumn poType="${poType}" property="walletBalance" column="${views.player_auto['钱包余额']}"/>
            <soul:orderColumn poType="${poType}" property="totalAssets" column="${views.player_auto['总资产']}"/>
            <%--自定义orderColumn,需要显示注释--%>
            <th style="" class="sorting">
                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                      data-html="true" data-content="${views.content['annotation.deposit']}">
                                <i class="fa fa-question-circle"></i>
                        </span>
                <input type="hidden" property="rechargeTotal" name="query.pageOrderMap[rechargeTotal]" value="${command.query.pageOrderMap['rechargeTotal']}">
                <span class="soul-table-th-text " style="">${views.player_auto['存款总额']}</span>
            </th>
            <th style="" class="sorting">
                <span tabindex="0" class="" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                      data-html="true" data-content="${views.content['annotation.withdrawal']}">
                                <i class="fa fa-question-circle"></i>
                        </span>
                <input type="hidden" property="txTotal" name="query.pageOrderMap[txTotal]" value="${command.query.pageOrderMap['txTotal']}">
                <span class="soul-table-th-text " style="">${views.player_auto['取款总额']}</span>
            </th>
            <soul:orderColumn poType="${poType}" property="loginTime" column="${views.player_auto['最后登录时间']}"/>
            <th>
                <gb:select name="search.status" value="${command.search.status}"
                           prompt="${views.role['player.list.title.status']}" list="${playerStatus}" callback="query"/>
            </th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="${fn:length(command.fields)+4}">
                <div class="select-records"><i
                        class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span
                        id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function"
                                 text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
        <script id="VUserPlayerListVo" type="text/x-jsrender">
            {{for data}}
                 <tr class="tab-detail">
                    <%--序号--%>
                    <td>
                        {{:_paging_orderNumber}}
                    </td>

                    <%--账号--%>
                    <td>
                    {{:username}}
                    {{if createChannel==3}}
                        <span data-content="{{if importUsername =='' && username!=importUsername}} 导入玩家，原账号{{:importUsername}} {{else}} 导入玩家 {{/if}}"
                        data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                        role="button" class="ico-lock" tabindex="0"
                        data-original-title="" title=""><i class="fa fa-download"></i></span>
                    {{/if}}
                    {{if onLineId>0}}
                        <span data-content="${views.role['player.list.icon.online']}"
                        data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                        role="button" class="ico-lock" tabindex="0"
                        data-original-title="" title=""><i class="fa fa-flash"></i></span>
                    {{/if}}
                    {{if riskMarker == true}}
                        <span data-content="${views.player_auto['危险层级']}"
                        data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                        role="button" class="ico-lock co-red3" tabindex="0"
                        data-original-title="" title=""><i class="fa fa-warning"></i></span>
                    {{/if}}
                    {{if createChannel == '2'}}
                        <span data-content="${views.player_auto['后台新增玩家']}"
                        data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                        role="button" class="ico-lock" tabindex="0"
                        data-original-title="" title=""><i class="fa icon-houtaixinzengwanjia iconfont"></i></span>
                    {{/if}}
                        {{:_views_riskDataType}}

                    </td>

                    <%--真实姓名--%>
                    <td>{{:realName}}</td>

                    <%--所属代理--%>
                    <td>
                        {{if agentName=='defaultagent'}}
                            {{:_views_player_auto_defaultagent}}
                        {{else}}
                            {{:agentName}}
                        {{/if}}
                    </td>

                    <%--注册时间--%>
                    <td>
                        <span data-content="{{:_soulFn_formatDateTz_createTime}}"
                          data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                          role="button" class="ico-lock" tabindex="0" data-original-title="" title="">
                          {{if rigistLessThanAMonth !='' && rigistLessThanAMonth}}
                            <span class="co-yellow">
                                {{:_soulFn_formatDateTz_createTimeDay}}
                            </span>
                           {{else}}
                           <span >
                                {{:_soulFn_formatDateTz_createTimeDay}}
                            </span>
                           {{/if}}
                        </span>
                    </td>

                    <%--层级--%>
                    <td>
                        <span class="label label-info">{{:rankName}}</span>
                    </td>

                    <%--钱包余额--%>
                    <td class="money">
                        {{:_dicts_common_currency_symbol}}&nbsp;
                        {{:_soulFn_formatInteger_walletBalance}}<i>{{:_soulFn_formatDecimals_walletBalance}}</i>
                    </td>
                    <%--总资产--%>
                    <td class="money">
                            {{:_dicts_common_currency_symbol}}&nbsp;
                            {{:_soulFn_formatInteger_totalAssets}}<i>{{:_soulFn_formatDecimals_totalAssets}}</i>
                    </td>
                    <%--存款总额--%>
                    <td class="money">
                            {{:_dicts_common_currency_symbol}}&nbsp;
                            {{:_soulFn_formatInteger_rechargeTotal}}<i>{{:_soulFn_formatDecimals_rechargeTotal}}</i>
                    </td>
                    <%--取款总额--%>
                    <td class="money">
                            {{:_dicts_common_currency_symbol}}&nbsp;
                            {{:_soulFn_formatInteger_txTotal}}<i>{{:_soulFn_formatDecimals_txTotal}}</i>
                    </td>
                    <%--最后登录时间--%>
                    <td>
                        {{:_soulFn_formatDateTz_loginTime}}
                    </td>

                    <%--状态--%>
                    <td>
                        {{if playerStatus=='1'}}
                            <span class="label label-success">
                            {{:_dicts_player_player_status}}
                            </span>
                        {{/if}}
                        {{if playerStatus=='2'}}
                            <span class="label label-danger">
                            {{:_dicts_player_player_status}}
                            </span>
                        {{/if}}
                        {{if playerStatus=='3'}}
                            <span class="label label-info">
                            {{:_dicts_player_player_status}}
                            </span>
                        {{/if}}
                        {{if playerStatus=='4'}}
                            <span class="label label-warning">
                            {{:_dicts_player_player_status}}
                            </span>
                        {{/if}}
                    </td>

                </tr>
            {{/for}}

        </script>
    </table>
</div>
<div id="playerPage"></div>