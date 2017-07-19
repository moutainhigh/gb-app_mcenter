<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/userAgent/agent/detail.html?search.id=${map.id}&ajax=true" method="post">
    <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive" id="tab-1">
    <table class="table dataTable">
        <tbody>
        <tr class="tab-title">
            <th class="bg-tbcolor">${views.column['VUserPlayer.agentName']}：</th>
            <td><a href="javascript:void(0)">${map.username}</a></td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.realName']}：</th>
            <td>${map.real_name}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.parentUsername']}：</th>
            <td>
                <c:if test="${map.general_id eq map.parent_id}">
                    <a href="/vUserTopAgentManage/list.html?search.id=${map.parent_id}&search.hasReturn=true" nav-target="mainFrame" class="co-blue">${map.parent_username}</a>
                </c:if>
                <c:if test="${map.general_id ne map.parent_id}">
                    <a href="/vUserAgentManage/list.html?search.id=${map.parent_id}&search.hasReturn=true" nav-target="mainFrame" class="co-blue">${map.parent_username}</a>
                </c:if>

                <%--<a href="/vUserTopAgentManage/list.html?search.id=${map.parent_id}" nav-target="mainFrame">${map.parent_username}</a>--%>
            </td>
            <th class="bg-tbcolor">${views.role['agent.topAgent']}：</th>
            <td><a href="/vUserTopAgentManage/list.html?search.id=${map.general_id}&search.hasReturn=true" nav-target="mainFrame">${map.general_name}</a></td>
            <%----%>
        </tr>
        <tr class="tab-title">
            <th class="bg-tbcolor">${views.column['UserAgent.playerRankId']}：</th>
            <td><a href="/vPlayerRankStatistics/list.html?search.id=${map.player_rank_id}" nav-target="mainFrame"><span class="label label-info">${map.rank_name}</span></a></td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.rebateName']}：</th>
            <td><a href="/rebateSet/view.html?id=${rebateId}" nav-target="mainFrame"><span class="label label-warning">${map.rebate[0].name}</span></a></td>
            <%--<th class="bg-tbcolor">${views.column['VUserAgentManage.yffsfa']}：</th>
            <td><a href="/setting/vRakebackSet/view.html?id=${rakebackId}" nav-target="mainFrame"><span class="label label-success">${map.rakeback[0].name}</span></a></td>--%>
            <th class="bg-tbcolor">${views.column['VUserPlayer.balance']}：</th>
            <td>${map.account_balance}</td>
            <th class="bg-tbcolor">${views.column['UserAgent.totalRebate']}：</th>
            <td>${map.total_rebate}</td>
        </tr>
        <tr class="tab-title">

            <th class="bg-tbcolor">${views.column['VUserAgentManage.defaultCurrency']}：</th>
            <td>${dicts.common.currency[map.default_currency]}  ${map.default_currency}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.defaultTimezone']}：</th>
            <td>${map.default_timezone}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.registCode']}：</th>
            <td>${map.regist_code}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.createChannel']}：</th>
            <td>${dicts.player.create_channel[map.create_channel]}</td>
        </tr>
        <tr class="tab-title">

            <th class="bg-tbcolor">${views.column['VUserAgentManage.createTime']}：</th>
            <td>${soulFn:formatDateTz(map.create_time, DateFormat.DAY_SECOND,timeZone)}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.registerIp']}：</th>
            <td>${soulFn:formatIp(map.register_ip)}${gbFn:getIpRegion(map.register_ip_dict_code)}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.sex']}：</th>
            <td>${dicts.common.sex[map.sex]}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.birthday']}：</th>
            <td>${soulFn:formatDateTz(map.birthday, DateFormat.DAY,timeZone)}</td>
        </tr>

        <tr class="tab-title">

            <th class="bg-tbcolor">${views.column['VUserAgentManage.status']}：</th>
            <td>${dicts.player.user_status[map.freeze_status]}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.defaultLocale']}：</th>
            <td>${dicts.common.local[map.default_locale]}</td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.lastLoginTime']}：</th>
            <td><fmt:formatDate value="${map.last_login_time}" pattern="${DateFormat.DAY_SECOND}"></fmt:formatDate></td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.mobilePhone']}：</th>
            <td>
                <c:if test="${unencryption}">
                    ${phone.contactValue}
                </c:if>
                <c:if test="${!unencryption}">
                    ${soulFn:overlayTel(phone.contactValue)}&nbsp;
                    <a href="/userAgent/agent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty msn.contactValue && not empty phone.contactValue?'':'none'}">${views.common['view']}</a>
                </c:if>
            </td>
        </tr>

        <tr class="tab-title">

            <th class="bg-tbcolor">${views.column['VUserAgentManage.mail']}：</th>
            <td>
                <c:if test="${unencryption}">
                    ${email.contactValue}
                </c:if>
                <c:if test="${!unencryption}">
                    ${soulFn:overlayEmaill(email.contactValue)}&nbsp;
                    <a href="/userAgent/agent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty msn.contactValue && empty phone.contactValue && not empty email.contactValue?'':'none'}">${views.common['view']}</a>
                </c:if>
            </td>
            <th class="bg-tbcolor">${views.column['VUserTopAgentManage.qq']}：</th>
            <td>
                <c:if test="${unencryption}">
                    ${qq.contactValue}
                </c:if>
                <c:if test="${!unencryption}">
                    ${soulFn:overlayString(qq.contactValue)}&nbsp;
                    <a href="/userAgent/agent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty msn.contactValue && empty phone.contactValue && empty email.contactValue && not empty qq.contactValue?'':'none'}">${views.common['view']}</a>
                </c:if>
            </td>
            <th class="bg-tbcolor">${views.player_auto['微信']}：</th>
            <td>
                <c:if test="${unencryption}">
                    ${weixin.contactValue}
                </c:if>
                <c:if test="${!unencryption}">
                    ${soulFn:overlayString(weixin.contactValue)}&nbsp;
                    <a href="/userAgent/agent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty phone.contactValue && empty email.contactValue && empty qq.contactValue && not empty weixin.contactValue?'':'none'}">${views.common['view']}</a>
                </c:if>
            </td>
            <th class="bg-tbcolor">${views.column['VUserAgentManage.playerNum']}：</th>
            <td><a href="/player/list.html.html?search.agentId=${map.id}&search.hasReturn=true" nav-target="mainFrame">${map.player_num}</a></td>
        </tr>
        <tr  class="tab-title">
            <th class="bg-tbcolor">${views.column['VUserAgentManage.agentNum']}：</th>
            <td><a href="/vUserAgentManage/list.html.html?search.parentId=${map.id}&search.hasReturn=true" nav-target="mainFrame">${map.agent_num}</a></td>
            <th></th><td></td><th></th><td></td><th></th><td></td>
        </tr>
        <tr class="tab-title">
            <th class="bg-tbcolor">${views.role['Agent.detail.playerlinks']}：</th>
            <td colspan="7">
                <c:if test="${not empty invitationCode&&map.freeze_status!='4'}">
                    <c:if test="${not empty indexDomains}">
                        <c:forEach var="item" items="${indexDomains}" varStatus="vs">
                            <c:if test="${vs.index==0}">
                                http://${item.domain}
                                <a data-clipboard-target="p${vs.index}" data-clipboard-text="http://${item.domain}" name="copy">
                                        ${views.common['copy']}
                                </a>
                            </c:if>
                        </c:forEach>
                        <soul:button target="${root}/userAgent/showAllDomains.html?editType=agent&search.id=${command.result.id}" text="${views.player_auto['查看更多']}" title="${views.player_auto['代理推广链接']}" opType="dialog"></soul:button>
                    </c:if>
                    <c:if test="${empty indexDomains}">
                        <c:if test="${not empty domains}">
                            <c:forEach var="item" items="${domains}" varStatus="vs">
                                <c:if test="${vs.index==0}">
                                    http://${item.domain}/?c=${invitationCode}
                                    <a data-clipboard-target="p${vs.index}" data-clipboard-text="http://${item.domain}/?c=${invitationCode}" name="copy">
                                            ${views.common['copy']}
                                    </a>
                                </c:if>

                            </c:forEach>
                            <soul:button target="${root}/userAgent/showAllDomains.html?editType=agent&search.id=${command.result.id}" text="${views.player_auto['查看更多']}" title="${views.player_auto['代理推广链接']}" opType="dialog"></soul:button>
                        </c:if>
                    </c:if>
                </c:if>
            </td>
        </tr>
        <tr class="tab-title">
            <th class="bg-tbcolor">${views.role['Agent.detail.agentlinks']}：</th>
            <td colspan="7">
                <c:if test="${not empty invitationCode&&map.freeze_status!='4'}">
                    <c:if test="${not empty domains}">
                        <c:forEach var="item" items="${domains}" varStatus="vs">
                            <c:if test="${vs.index==0}">
                                http://${item.domain}/commonPage/signUp-agent.html?c=${invitationCode}
                                <a data-clipboard-target="p${vs.index}" data-clipboard-text="http://${item.domain}/commonPage/signUp-agent.html?c=${invitationCode}" name="copy">
                                        ${views.common['copy']}
                                </a>
                            </c:if>

                        </c:forEach>
                        <soul:button target="${root}/userAgent/showAllDomains.html?editType=agent&search.id=${command.result.id}" text="${views.player_auto['查看更多']}" title="${views.player_auto['代理推广链接']}" opType="dialog"></soul:button>
                    </c:if>
                </c:if>
            </td>
        </tr>
        <tr class="tab-title">
            <th class="bg-tbcolor">${views.column['UserAgent.promotionResources']}：</th>
            <td colspan="7">${map.promotion_resources}</td>

        </tr>

        </tbody>
    </table>
    </div>
    </div>
</form:form>
