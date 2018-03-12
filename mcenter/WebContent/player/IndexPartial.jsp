<%@ page import="so.wwb.gamebox.model.master.player.po.VUserPlayer" %>
<%@ page import="org.soul.commons.lang.reflect.MethodTool" %>
<%@ page import="org.soul.model.common.Sortable" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VUserPlayer.class %>"></c:set>
<%--<input type="hidden" name="queryParamsJson" value='${queryParamsJson}'>--%>
<div class="table-responsive table-min-h">
    <input type="hidden" name="search.rankId" value="${command.search.rankId}">
    <table class="table table-striped table-hover dataTable" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th class="user_checkbox"><label><input type="checkbox" class="i-checks"></label></th>
            <th>${views.common['number']}</th>
            <th>${views.player_auto['账号']}</th>
            <th>${views.player_auto['真实姓名']}</th>
            <th>${views.player_auto['所属代理']}</th>
            <soul:orderColumn poType="${poType}" property="createTime" column="${views.player_auto['注册时间']}"/>
            <%--<th>${views.player_auto['注册时间']}</th>--%>
            <th>${views.player_auto['层级']}</th>
            <%--<th>${views.player_auto['钱包余额']}</th>--%>
            <soul:orderColumn poType="${poType}" property="walletBalance" column="${views.player_auto['钱包余额']}"/>
            <soul:orderColumn poType="${poType}" property="totalAssets" column="${views.player_auto['总资产']}"/>
            <%--<soul:orderColumn poType="${poType}" property="rechargeTotal" column="${views.player_auto['存款总额']}"/>--%>
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
            <%--<soul:orderColumn poType="${poType}" property="txTotal" column="${views.player_auto['取款总额']}"/>--%>
            <soul:orderColumn poType="${poType}" property="loginTime" column="${views.player_auto['最后登录时间']}"/>
            <th>
                <gb:select name="search.status" value="${command.search.status}"
                           prompt="${views.role['player.list.title.status']}" list="${playerStatus}" callback="query"/>
            </th>
            <th>${views.player_auto['操作']}</th>
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
                    <td>
                        <input type="checkbox" value="{{:id}}">
                    </td>

                    <%--序号--%>
                    <td>
                        {{:_paging_orderNumber}}
                    </td>

                    <%--账号--%>
                    <td>
                    <shiro:hasPermission name="role:player_detail">
                    <a href="/player/playerView.html?search.id={{:id}}" nav-target="mainFrame">
                    </shiro:hasPermission>{{:username}}
                    <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>
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
                    <%--
                    {{if remarkcount!='' && remarkcount >0}}
                        <span class="ico-lock"><i class="fa fa-flag" title="${views.role['player.list.icon.remark']}"></i></span>
                    {{/if}}
                    --%>
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
                    <%--${gbFn:riskImgById(id)}--%>
                    <%--{{:_gbFn_riskImgById_id}}aaa--%>
                        {{if riskDataType !=null}}
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                        {{:_gbFn_riskImgById_id}}
                            {{:_gbFn_showRiskImg_riskDataType}}
                            {{: riskDataType}}
                        {{/if}}

                    </td>

                    <%--真实姓名--%>
                    <td>{{:realName}}</td>

                    <%--所属代理--%>
                    <td>
                        <a href="/vUserAgentManage/list.html?search.id={{:agentId}}" nav-target="mainFrame">
                        {{if agentName=='defaultagent'}}
                            {{:_views_player_auto_defaultagent}}
                        {{else}}
                            {{:agentName}}
                        {{/if}}
                        </a>
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
                        <a href="/vPlayerRankStatistics/view.html?id={{:rankId}}" nav-target="mainFrame">
                            <span class="label label-info">{{:rankName}}</span>
                        </a>
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

                    <%--操作--%>
                    <td>
                        <shiro:hasPermission name="role:player_edit">
                        {{if playerStatus!=2}}
                            <a href="/player/getVUserPlayer.html?search.id={{:id}}"
                            nav-target="mainFrame">{{:_views_common_edit}}</a>
                        {{/if}}
                        {{if playerStatus==2}}
                            <span CLASS="co-gray">{{:_views_common_edit}}</span>
                        {{/if}}
                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="role:player_detail">
                            <a href="/player/playerView.html?search.id={{:id}}"
                            nav-target="mainFrame">{{:_views_common_detail}}</a>
                        </shiro:hasPermission>
                        {{if riskDataType !=null}}
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                            <soul:button text="${views.player_auto['添加风控人员至总控']}" opType="ajax"
                                         target="${root}/player/addRiskToBoss.html?search.id={{:id}}" />
                        {{/if}}



                    </td>
                </tr>
            {{/for}}

        </script>

       <%-- <c:forEach var="item" items="${command.result}" varStatus="status">
            <tr class="tab-detail">
                <td><input type="checkbox" value="${item.id}"></td>
                <td>${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                <td>

                    <shiro:hasPermission name="role:player_detail">
                    <a href="/player/playerView.html?search.id=${item.id}" nav-target="mainFrame">
                    </shiro:hasPermission>${item.username}
                    <shiro:hasPermission name="role:player_detail"></a></shiro:hasPermission>

                    <c:if test="${item.createChannel=='3'}">
                        <span data-content="${not empty item.importUsername && item.username!=fn:toLowerCase(item.importUsername)?'导入玩家，原账号'.concat(item.importUsername):'导入玩家'}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="ico-lock" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-download"></i></span>
                    </c:if>
                    <c:if test="${item.onLineId>0}">
                        <span data-content="${views.role['player.list.icon.online']}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="ico-lock" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-flash"></i></span>
                    </c:if>
                        &lt;%&ndash;<c:if test="${not empty item.remarkcount && item.remarkcount > 0}"><span class="ico-lock"><i class="fa fa-flag" title="${views.role['player.list.icon.remark']}"></i></span></c:if>&ndash;%&gt;
                    <c:if test="${item.riskMarker == true}">
                        <span data-content="${views.player_auto['危险层级']}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="ico-lock co-red3" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-warning"></i></span>
                    </c:if>
                    <c:if test="${item.createChannel == '2'}">
                                <span data-content="${views.player_auto['后台新增玩家']}"
                                      data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                      role="button" class="ico-lock" tabindex="0"
                                      data-original-title="" title=""><i class="fa icon-houtaixinzengwanjia iconfont"></i></span>
                    </c:if>
                </td>
                <td>${item.realName}</td>
                <td>
                        &lt;%&ndash;<a href="/vUserTopAgentManage/list.html?search.username=${item.generalAgentName}" nav-target="mainFrame">
                                ${item.generalAgentName}
                        </a>
                        >&ndash;%&gt;
                    <a href="/vUserAgentManage/list.html?search.id=${item.agentId}" nav-target="mainFrame">
                        <c:choose>
                            <c:when test="${item.agentName.equals('defaultagent')}">
                                ${views.player_auto['默认代理']}
                            </c:when>
                            <c:otherwise>
                                ${item.agentName}
                            </c:otherwise>
                        </c:choose>
                    </a>
                </td>
                    &lt;%&ndash;<td>
                            ${soulFn:formatDateTz(item.createTime, DateFormat.DAY,timeZone)}
                    </td>&ndash;%&gt;
                <td>
                    <span data-content="${soulFn:formatDateTz(item.createTime, DateFormat.DAY_SECOND,timeZone)}"
                          data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                          role="button" class="ico-lock" tabindex="0" data-original-title="" title="">
                        <span class="${not empty item.rigistLessThanAMonth && item.rigistLessThanAMonth ? 'co-yellow' : ''}">
                                ${soulFn:formatDateTz(item.createTime, DateFormat.DAY,timeZone)}
                        </span>
                    </span>
                </td>
                <td>
                    <a href="/vPlayerRankStatistics/view.html?id=${item.rankId}" nav-target="mainFrame">
                        <span class="label ${item.riskMarker?'label-danger':'label-info'}">${item.rankName}</span>
                    </a>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['walletBalance'])}<i>${soulFn:formatDecimals(item['walletBalance'])}</i>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['totalAssets'])}<i>${soulFn:formatDecimals(item['totalAssets'])}</i>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['rechargeTotal'])}<i>${soulFn:formatDecimals(item['rechargeTotal'])}</i>
                </td>
                <td class="money">
                        ${dicts.common.currency_symbol[item.defaultCurrency]}&nbsp;
                        ${soulFn:formatInteger(item['txTotal'])}<i>${soulFn:formatDecimals(item['txTotal'])}</i>
                </td>
                <td>${soulFn:formatDateTz(item.loginTime, DateFormat.DAY_SECOND,timeZone)}</td>
                <td>
                    <c:if test="${item.playerStatus=='1'}">
                        <span class="label label-success">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                    <c:if test="${item.playerStatus=='2'}">
                        <span class="label label-danger">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                    <c:if test="${item.playerStatus=='3'}">
                        <span class="label label-info">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                    <c:if test="${item.playerStatus=='4'}">
                        <span class="label label-warning">
                                ${dicts.player.player_status[item.playerStatus]}
                        </span>
                    </c:if>
                </td>
                <td>
                    <shiro:hasPermission name="role:player_edit">
                        <c:if test="${item.playerStatus!='2'}">
                            <a href="/player/getVUserPlayer.html?search.id=${item.id}"
                               nav-target="mainFrame">${views.common['edit']}</a>
                        </c:if>
                        <c:if test="${item.playerStatus=='2'}">
                            <span CLASS="co-gray">${views.common['edit']}</span>
                        </c:if>

                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="role:player_detail">
                    <a href="/player/playerView.html?search.id=${item.id}"
                       nav-target="mainFrame">${views.common['detail']}</a>
                    </shiro:hasPermission>
                </td>
            </tr>
        </c:forEach>--%>

    </table>
</div>