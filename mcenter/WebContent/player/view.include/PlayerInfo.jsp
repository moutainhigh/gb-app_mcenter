<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/player/playerView.html?search.id=${command.result.id}&ajax=true" method="post">
    <a href="/player/playerView.html?search.id=${command.result.id}&random=<%=Math.random()%>"
       nav-target="mainFrame" name="returnView" style="display: none"></a>
    <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
    <div class="table-responsive" id="tab-1">
    <c:if test="${command.result.status eq '2'}">
        <c:set value="true" var="option_btn_disabled"></c:set>
    </c:if>
    <table class="table  dataTable">
        <tbody>
        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.account']}</td>
            <td>
                    ${command.result.username}&nbsp;&nbsp;
                <c:if test="${command.result.onLineId>0}">
                    <i class="fa fa-flash" title="${views.role['player.list.icon.online']}"></i>&nbsp;
                </c:if>
                <c:if test="${command.result.remarkcount > 0}">
                    <i class="fa fa-flag" title="${views.role['player.list.icon.remark']}"></i>&nbsp;
                </c:if>
                <%--<c:if test="${command.result.specialFocus}">
                    <soul:button tag="button" target="${root}/player/setSpecialFocus.html?result.id=${command.result.id}&result.specialFocus=false" text="${views.column['VUserPlayer.specialFocus']}" callback="playerInfo.queryView" opType="ajax" dataType="json" confirm="${messages.player['relieve.specialFocus']}？" cssClass="btn btn-filter btn-xs m-l-sm"/>
                </c:if>
                <c:if test="${!command.result.specialFocus}">
                    <soul:button tag="button" target="${root}/player/setSpecialFocus.html?result.id=${command.result.id}&result.specialFocus=true" text="${views.column['VUserPlayer.specialFocus']}" callback="playerInfo.queryView" opType="ajax" dataType="json" confirm="${messages.player['relieve.specialFocus']}？" cssClass="btn btn-outline btn-filter btn-xs m-l-sm"/>
                </c:if>--%>
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.agentRelation']}</td>
            <td>
                <a href="/vUserTopAgentManage/list.html?search.id=${command.result.generalAgentId}" nav-target="mainFrame">${command.result.generalAgentName}</a>
                <%--<soul:button target="queryByAgentName" post="generalAgentName"
                             text="${command.result.generalAgentName}" opType="function"/>--%>
                >
                <a href="/vUserAgentManage/list.html?search.id=${command.result.agentId}" nav-target="mainFrame">${command.result.agentName}</a>
                <%--<soul:button target="queryByAgentName" post="agentName" text="${command.result.agentName}"
                             opType="function"/>--%>
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.realName']}</td>
            <td>${command.result.realName}
                <c:if test="${!option_btn_disabled}">
                    <soul:button target="${root}/player/updateRealName.html?result.id=${command.search.id}&result.realName=${command.result.realName}"
                             text="${views.role['Player.detail.info.editRealName']}" opType="dialog" callback="queryPlayerDetail"/>
                </c:if>
            </td>

            <td class="bg-tbcolor">${views.role['Player.detail.info.walletBalance']}</td>
            <td><fmt:formatNumber value="${command.result.walletBalance}" pattern="0.00" type="number"/></td>
        </tr>
        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.rakeback']}</td>
            <td><fmt:formatNumber value="${command.result.rakeback}" pattern="0.00" type="number"/></td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.rakebackName']}</td>
            <td>${command.result.rakebackName}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.status']}</td>
            <td class="data-status">
                    ${dicts.player.player_status[command.result.playerStatus]}
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.rankName']}</td>
            <td>${command.result.rankName}</td>
        </tr>
        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.email']}</td>
            <c:choose>
                <c:when test="${command.result.mailWayStatus==22}">
                    <td>${views.role['player.view.clearcontact']}</td>
                </c:when>
                <c:otherwise>
                    <c:if test="${unencryption}">
                        <td>${command.result.mail}</td>
                    </c:if>
                    <c:if test="${!unencryption}">
                    <td>
                        ${soulFn:overlayEmaill(command.result.mail)}&nbsp;
                        <shiro:hasPermission name="role:player_personal_detail">
                            <a href="/player/playerViewDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${!empty command.result.mail?'':'none'}">${views.common['view']}</a>
                        </shiro:hasPermission>
                    </td>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <td class="bg-tbcolor">${views.role['Player.detail.info.phone']}</td>
            <c:choose>
                <c:when test="${command.result.mobilePhoneWayStatus==22}">
                    <td>${views.role['player.view.clearcontact']}</td>
                </c:when>
                <c:otherwise>
                    <c:if test="${unencryption}">
                        <td>${command.result.mobilePhone}</td>
                    </c:if>
                    <c:if test="${!unencryption}">
                        <td>
                            ${soulFn:overlayTel(command.result.mobilePhone)}&nbsp;
                            <shiro:hasPermission name="role:player_personal_detail">
                                <a href="/player/playerViewDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty command.result.mail && !empty command.result.mobilePhone?'':'none'}">${views.common['view']}</a>
                            </shiro:hasPermission>
                        </td>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <td class="bg-tbcolor">${views.role['Player.detail.info.defaultCurrency']}</td>
            <td>${dicts.player.main_currency[command.result.defaultCurrency]}&nbsp;${command.result.defaultCurrency}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.defaultLocale']}</td>
            <td>${dicts.common.local[command.result.defaultLocale]}</td>
        </tr>
        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.country']}</td>
            <td>
                ${dicts.region.region[command.result.country]}
                <c:if test="${not empty command.result.region}">-${dicts.state[command.result.country][command.result.region]}</c:if>
                <c:if test="${not empty command.result.city and not empty command.result.region}">-${dicts.city[(command.result.country).concat("_").concat(command.result.region)][command.result.city]}</c:if>
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.defaultTimezone']}</td>
            <td>
                    ${command.result.defaultTimezone}
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.nickname']}</td>
            <td>${command.result.nickname}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.sex']}</td>
            <td>${dicts.common.sex[command.result.sex]}</td>
        </tr>

        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.birthday']}</td>
            <td>${soulFn:formatDateTz(command.result.birthday, DateFormat.DAY,timeZone)}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.rechargeCount']}</td>
            <td>
                <fmt:formatNumber value="${command.result.rechargeCount}" pattern="0" type="number"/>
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.rechargeTotal']}</td>
            <td>
                <fmt:formatNumber value="${command.result.rechargeTotal}" pattern="0.00" type="number"/>
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.txCount']}</td>
            <td>
                <fmt:formatNumber value="${command.result.txCount}" pattern="0" type="number"/>
            </td>
        </tr>

        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.txTotal']}</td>
            <td>
                <fmt:formatNumber value="${command.result.txTotal}" pattern="0.00" type="number"/>
            </td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.totalProfitLoss']}</td>
            <td>${command.result.totalProfitLoss}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.totalTradeVolume']}</td>
            <td>${command.result.totalTradeVolume}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.totalEffectiveVolume']}</td>
            <td>${command.result.totalEffectiveVolume}</td>
        </tr>
        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.message']}</td>
            <td><span class="co-blue">${msgLength}</span>/<span class="co-tomato">${msgCount}</span></td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.id']}</td>
            <td>${command.result.id}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.createChannel']}</td>
            <td>${dicts.player.create_channel[command.result.createChannel]}</td>
            <td class="bg-tbcolor">${views.role['Player.detail.info.createTime']}</td>
            <td>${soulFn:formatDateTz(command.result.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
        </tr>
        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.registerIp']}</td>
            <td><a href="/player/list.html?search.registerIp=${command.result.registerIp}" nav-target="mainFrame">${soulFn:formatIp(command.result.registerIp)}</a></td>
            <%--<td class="bg-tbcolor">skype：</td>
            <c:choose>
                <c:when test="${command.result.skypeWayStatus==22}">
                    <td>${views.role['player.view.clearcontact']}</td>
                </c:when>
                <c:otherwise>
                    <c:if test="${unencryption}">
                        <td>${command.result.skype}</td>
                    </c:if>
                    <c:if test="${!unencryption}">
                        <td>
                            ${soulFn:overlayString(command.result.skype)}&nbsp;
                            <shiro:hasPermission name="role:player_personal_detail">
                                <a href="/player/playerViewDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty command.result.mail && empty command.result.mobilePhone && !empty command.result.skype?'':'none'}">${views.common['view']}</a>
                            </shiro:hasPermission>
                        </td>
                    </c:if>
                </c:otherwise>
            </c:choose>--%>
            <td class="bg-tbcolor">QQ：</td>
            <c:choose>
                <c:when test="${command.result.qqWayStatus==22}">
                    <td>${views.role['player.view.clearcontact']}</td>
                </c:when>
                <c:otherwise>
                    <c:if test="${unencryption}">
                        <td>${command.result.qq}</td>
                    </c:if>
                    <c:if test="${!unencryption}">
                        <td>
                            ${soulFn:overlayString(command.result.qq)}&nbsp;
                            <shiro:hasPermission name="role:player_personal_detail">
                                <a href="/player/playerViewDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty command.result.mail && empty command.result.mobilePhone && empty command.result.skype && !empty command.result.qq?'':'none'}">${views.common['view']}</a></td>
                            </shiro:hasPermission>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <td class="bg-tbcolor">${views.player_auto['微信']}：</td>
            <c:choose>
                <c:when test="${command.result.weixinWayStatus==22}">
                    <td>${views.role['player.view.clearcontact']}</td>
                </c:when>
                <c:otherwise>
                    <c:if test="${unencryption}">
                        <td>${command.result.weixin}</td>
                    </c:if>
                    <c:if test="${!unencryption}">
                        <td>
                        ${soulFn:overlayString(command.result.weixin)}&nbsp;
                        <shiro:hasPermission name="role:player_personal_detail">
                            <a href="/player/playerViewDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty command.result.mail && empty command.result.mobilePhone && empty command.result.qq && not empty command.result.weixin ?'':'none'}">${views.common['view']}</a></td>
                        </shiro:hasPermission>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <%--<td class="bg-tbcolor">MSN：</td>
            <c:choose>
                <c:when test="${command.result.msnWayStatus==22}">
                    <td>${views.role['player.view.clearcontact']}</td>
                </c:when>
                <c:otherwise>
                    <c:if test="${unencryption}">
                        <td>${command.result.msn}</td>
                    </c:if>
                    <c:if test="${!unencryption}">
                    <td>
                        ${soulFn:overlayString(command.result.msn)}&nbsp;
                        <shiro:hasPermission name="role:player_personal_detail">
                            <a href="/player/playerViewDetail.html?search.id=${command.search.id}" nav-target="mainFrame" style="display: ${empty command.result.mail && empty command.result.mobilePhone && empty command.result.skype && empty command.result.qq && !empty command.result.msn?'':'none'}">${views.common['view']}</a></td>
                        </shiro:hasPermission>
                    </c:if>
                </c:otherwise>
            </c:choose>--%>
            <td class="bg-tbcolor">${views.role['Player.detail.info.createUser']}</td>
            <td>${command.result.createUser}</td>
        </tr>
        <tr>
            <td class="bg-tbcolor">${views.role['Player.detail.info.remark']}</td>
            <td>
                    ${remarkCount==0?views.role['Player.detail.info.none']:remarkCount}
            </td>
            <%--<c:if test="${fn:length(playerContactWayListVo.result) >=3}">
                <c:forEach items="${playerContactWayListVo.result}" var="l" begin="0" end="2">
                    <td class="bg-tbcolor">${l.contractType}：</td>
                    <td>${l.contractValue}</td>
                </c:forEach>
            </c:if>

            <c:if test="${fn:length(playerContactWayListVo.result)<3}">

                <c:forEach items="${playerContactWayListVo.result}" var="l">
                    <td class="bg-tbcolor">${l.contractType}：</td>
                    <td>${l.contractValue}</td>
                </c:forEach>

                <c:forEach begin="0" end="${2 - fn:length(playerContactWayListVo.result) }">
                    <td class="bg-tbcolor"></td>
                    <td></td>
                </c:forEach>

            </c:if>--%>


            <td class="bg-tbcolor">${views.role['Player.detail.info.other']}</td>
            <td>${views.role['Player.detail.info.none']}</td>
            <td class="bg-tbcolor">${views.role['player.detail.info.totalfavorable']}</td>
            <td>${soulFn:formatCurrency(favorableVal)}</td>
            <td class="bg-tbcolor">${views.role['player.detail.info.count']}</td>
            <td>${count}</td>
        </tr>
        <%--<c:if test="${fn:length(playerContactWayListVo.result) > 3}">

            <c:if test="${(fn:length(playerContactWayListVo.result) - 3) < 4}">
                <tr>
                    <c:forEach items="${playerContactWayListVo.result}" var="l" begin="3">
                        <td class="bg-tbcolor">${l.contractType}：</td>
                        <td>${l.contractValue}</td>
                    </c:forEach>

                    <c:forEach begin="0" end="${6- fn:length(playerContactWayListVo.result)}">
                        <td class="bg-tbcolor"></td>
                        <td></td>
                    </c:forEach>
                </tr>
            </c:if>

            <c:if test="${(fn:length(playerContactWayListVo.result) - 3) == 4}">
                <tr>
                    <c:forEach items="${playerContactWayListVo.result}" var="l" begin="3">
                        <td class="bg-tbcolor">${l.contractType}：</td>
                        <td>${l.contractValue}</td>
                    </c:forEach>
                </tr>
            </c:if>

            <c:if test="${(fn:length(playerContactWayListVo.result) - 3) > 4}">
                <c:forEach items="${playerContactWayListVo.result}" var="l" begin="3" varStatus="vs">
                    <c:if test="${(vs.index-3) == 0}">
                        <tr>
                    </c:if>
                    <td class="bg-tbcolor">${l.contractType}：</td>
                    <td>${l.contractValue}</td>
                    <c:if test="${((vs.index-3) != 0) && ((vs.index-2) % 4 == 0)}">
                        </tr><tr>
                    </c:if>
                </c:forEach>

                <c:if test="${((fn:length(playerContactWayListVo.result) - 3) % 4) != 0}">
                    <c:forEach begin="0" end="${4- ((fn:length(playerContactWayListVo.result) - 2) % 4) }">
                        <td class="bg-tbcolor"></td>
                        <td></td>
                    </c:forEach>
                </c:if>
                </tr>
            </c:if>

        </c:if>--%>
        <tr>

            <td class="bg-tbcolor">${views.role['Player.detail.info.tag']}</td>
            <td colspan="7">
                <c:forEach items="${vPlayerTagAllListVo.result}" var="l">
                    <span class="label-del">${l.tagName} <a href="javascript:void(0)" class="deleteTag" data-id="${l.id}">×</a></span>
                </c:forEach>
                <c:if test="${!option_btn_disabled}">
                    <soul:button target="${root}/player/editLabel.html?search.id=${command.result.id}"  callback="queryView" text="${dicts.log.op_type['create']}" opType="dialog" cssClass="btn btn-filter"/>
                </c:if>
            </td>
        </tr>
        </tbody>
    </table>
    </div>
    </div>
</form:form>
