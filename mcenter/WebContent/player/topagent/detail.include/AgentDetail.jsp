<%--@elvariable id="listVo" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/userAgent/agent/detail.html?search.id=${map.id}&ajax=true" method="post">
    <div class="panel-body">
        <div class="tab-content">
        <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
            <div class="table-responsive" id="tab-1">
                <table class="table dataTable">
                    <tbody><tr class="tab-title">
                        <th class="bg-tbcolor" style="width: 150px;">${views.column['VUserPlayer.top.agentName']}：</th>
                        <td><a href="javascript:void(0)">${map.username}</a></td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.realName']}：</th>
                        <td>${map.real_name}</td>
                        <th class="bg-tbcolor">${views.role['topAgent.edit.agentCount']}：</th>
                        <td><a href="/vUserAgentManage/list.html?search.parentId=${map.id}" nav-target="mainFrame">${map.child_agent_num}</a></td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.playerNum']}：</th>
                        <td><a href="/player/list.html.html?search.generalAgentId=${map.id}" nav-target="mainFrame">${map.player_num_for_topagent}</a></td>
                    </tr>

                    <tr class="tab-title">
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.mobilePhone']}：</th>
                        <td>
                            <c:if test="${unencryption}">
                                ${phone.contactValue}
                            </c:if>
                            <c:if test="${!unencryption}">
                                ${soulFn:overlayTel(phone.contactValue)}&nbsp;
                                <a href="/userAgent/topagent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${not empty phone.contactValue?'':'none'}">${views.common['view']}</a>
                            </c:if>
                        </td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.mail']}：</th>
                        <td>
                            <c:if test="${unencryption}">
                                ${email.contactValue}
                            </c:if>
                            <c:if test="${!unencryption}">
                                ${soulFn:overlayEmaill(email.contactValue)}&nbsp;
                                <a href="/userAgent/topagent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty phone.contactValue&&not empty email.contactValue?'':'none'}">${views.common['view']}</a>
                            </c:if>
                        </td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.status']}：</th>
                        <td>${dicts.player.player_status[map.freeze_status]}</td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.defaultTimezone']}：</th>
                        <td>${map.default_timezone}</td>
                    </tr>
                    <tr class="tab-title">
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.sex']}：</th>
                        <td>
                                ${dicts.common.sex[map.sex]}
                        </td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.birthday']}：</th>
                        <td>${soulFn:formatDateTz(map.birthday, DateFormat.DAY,timeZone)}</td>
                        <th class="bg-tbcolor">${views.role['topAgent.edit.defaulturrency']}：</th>
                        <td>${dicts.common.conpany[map.default_currency]}</td>
                        <%--<th class="bg-tbcolor">${views.column['VUserAgentManage.defaultLocale']}：</th>
                        <td>${dicts.common.local[map.default_locale]}</td>--%>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.lastLoginTime']}：</th>
                        <td><fmt:formatDate value="${map.last_login_time}" pattern="${DateFormat.DAY_SECOND}"></fmt:formatDate></td>
                    </tr>

                    <tr class="tab-title">
                        <th class="bg-tbcolor">${views.player_auto['微信']}：</th>
                        <td>
                            <c:if test="${unencryption}">
                                ${weixin.contactValue}
                            </c:if>
                            <c:if test="${!unencryption}">
                                ${soulFn:overlayString(weixin.contactValue)}&nbsp;
                                <a href="/userAgent/topagent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty phone.contactValue && empty email.contactValue && not empty weixin.contactValue?'':'none'}">${views.common['view']}</a>
                            </c:if>
                        </td>
                        <th class="bg-tbcolor">QQ：</th>
                        <td>
                            <c:if test="${unencryption}">
                                ${qq.contactValue}
                            </c:if>
                            <c:if test="${!unencryption}">
                                ${soulFn:overlayString(qq.contactValue)}&nbsp;
                                <a href="/userAgent/topagent/veiwDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty phone.contactValue && empty email.contactValue && empty skype.contactValue && empty msn.contactValue && not empty qq.contactValue?'':'none'}">${views.common['view']}</a>
                            </c:if>
                        </td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.registCode']}：</th>
                        <td>
                                ${map.regist_code}
                        </td>
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.createTime']}：</th>
                        <td>${soulFn:formatDateTz(map.create_time, DateFormat.DAY_SECOND,timeZone)}</td>
                    </tr>

                    </tbody>
                </table>
                </div>
            </div>
            <div class="dataTables_wrapper m-t" role="grid">
                <div class="table-responsive">
                <table class="table dataTable">
                    <tbody>
                    <tr class="tab-title">
                        <th class="bg-tbcolor" style="width: 150px;">${views.column['VUserAgentManage.ysfyfa']}：</th>
                        <td class="al-left">
                            <c:forEach items="${map.rebate}" var="p">
                                <a href="/rebateSet/view.html?id=${p.id}" nav-target="mainFrame">
                                    <span class="label label-warning">
                                    ${p.name}
                                    </span>
                                </a>
                            </c:forEach>

                        </td>

                    </tr>

                    <%--<tr class="tab-title">
                        <th class="bg-tbcolor">${views.column['VUserAgentManage.yffsfa']}：</th>
                        <td class="al-left">
                            <c:forEach items="${map.rakeback}" var="p">
                                <a href="/setting/vRakebackSet/view.html?id=${p.id}" nav-target="mainFrame"><span class="label label-success">${p.name}</span></a>
                            </c:forEach>
                        </td>

                    </tr>--%>
                    <%--<tr class="tab-title">--%>
                        <%--<th class="bg-tbcolor">${views.column['VUserAgentManage.ysxefa']}：</th>--%>
                        <%--<td class="al-left">--%>
                            <%--<c:forEach items="${map.quota}" var="p">--%>
                                <%--<a class="propormpt"> <span class="label label-danger">${p.name}</span></a>--%>
                            <%--</c:forEach>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <tr class="tab-title">
                        <th class="bg-tbcolor">${views.player_auto['推广链接']}：</th>
                        <td>
                            <c:if test="${not empty invitationCode && map.freeze_status!='4'}">
                                <c:if test="${not empty domains}">
                                    <c:forEach var="item" items="${domains}" varStatus="vs">
                                        <c:if test="${vs.index==0}">
                                            http://${item.domain}/commonPage/signUp-agent.html?c=${invitationCode}
                                            <a data-clipboard-target="p${vs.index}" data-clipboard-text="http://${item.domain}/commonPage/signUp-agent.html?c=${invitationCode}" name="copy">
                                                    ${views.common['copy']}
                                            </a>
                                        </c:if>

                                    </c:forEach>
                                    <soul:button target="${root}/userAgent/showAllDomains.html?editType=topAgent&search.id=${command.result.id}" text="${views.player_auto['查看更多']}" title="${views.player_auto['总代推广链接']}" opType="dialog"></soul:button>
                                </c:if>
                            </c:if>
                        </td>
                    </tr>
                    <tr class="tab-title">
                        <th class="bg-tbcolor">${views.column['UserAgent.promotionResources']}：</th>
                        <td>${map.promotion_resources}</td>

                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
            </div>
    </div>
</form:form>
