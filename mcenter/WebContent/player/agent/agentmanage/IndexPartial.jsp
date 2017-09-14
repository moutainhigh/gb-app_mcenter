<%@ page import="so.wwb.gamebox.model.master.player.po.VUserAgentManage" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserAgentManageListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VUserAgentManage.class %>"></c:set>
<input type="hidden" id="conditionJson" value="${params}">
<div class="search-params-div hide"></div>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['VUserAgentManage.username']}</th>
            <c:forEach items="${command.fields}" var="f" varStatus="status">
                <c:choose>
                    <c:when test="${f.key=='accountBalance' or f.key=='totalRebate' or f.key=='playerNum'}">
                        <soul:orderColumn poType="${poType}" property="${f.key}" column="${views.column['VUserAgentManage.'.concat(f.value.feildName)]}"/>
                    </c:when>
                    <c:when test="${f.key=='username' or f.key=='status'}"></c:when>
                    <c:otherwise>
                        <th>${views.column['VUserAgentManage.'.concat(f.value.feildName)]}</th>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <th>${views.column['VUserAgentManage.addSubAgent']}</th>
            <th class="inline">
                <gb:select name="search.status" value="${command.search.status}" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}" list="${status}" callback="query"/>
            </th>
            <th style="width:100px;" >${views.role['player.list.title.operation']}</th>
        </tr>
        <tr class="bd-none hide">
            <th colspan="${fn:length(command.fields)+3}">
                <div class="select-records"><i class="fa fa-exclamation-circle"></i>${views.role['player.cancelSelectAll.prefix']}&nbsp;<span id="page_selected_total_record"></span>${views.role['player.cancelSelectAll.middlefix']}
                    <soul:button target="cancelSelectAll" opType="function" text="${views.role['player.cancelSelectAll']}"/>${views.role['player.cancelSelectAll.suffix']}
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${command.result}" var="p" varStatus="status">
            <c:choose>
                <c:when test="${p.playerStatus eq '1'}">
                    <c:set var="color" value="label-success"></c:set>
                </c:when>
                <c:when test="${p.playerStatus eq '2'}">
                    <c:set var="color" value="label-danger"></c:set>
                </c:when>
                <c:when test="${p.playerStatus eq '3'}">
                    <c:set var="color" value="label-info"></c:set>
                </c:when>
                <c:when test="${p.playerStatus eq '4'}">
                    <c:set var="color" value="label-orange"></c:set>
                </c:when>
            </c:choose>
            <tr class="tab-detail">
                <td>
                    <a href="/userAgent/agent/detail.html?search.id=${p.id}" nav-target="mainFrame" class="co-blue">${p.username}</a>
                </td>
                <c:forEach items="${command.fields}" var="f" varStatus="status">
                    <c:choose>
                        <c:when test="${f.key=='sex'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.sex}">
                                        ${dicts.common.sex[p.sex]}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='birthday'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.birthday}">
                                        ${soulFn:formatDateTz(p.birthday, DateFormat.DAY,timeZone)}
                                        <%--<fmt:formatDate value="${p.birthday}" type="date" pattern="${DateFormat.DAY_SECOND}"/>--%>
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='createTime'}">
                            <td>
                                    ${soulFn:formatDateTz(p.createTime, DateFormat.DAY_SECOND,timeZone)}
                                <%--<fmt:formatDate value="${p.createTime}" type="date" pattern="${DateFormat.DAY_SECOND}"/>--%>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='lastLoginTime'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.lastLoginTime}">
                                        ${soulFn:formatDateTz(p.lastLoginTime, DateFormat.DAY_SECOND,timeZone)}
                                        <%--<fmt:formatDate value="${p.lastLoginTime}" type="date" pattern="${DateFormat.DAY_SECOND}"/>--%>
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='mail'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.mail}">
                                        ${soulFn:overlayEmaill(p.mail)}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='mobilePhone'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.mobilePhone}">
                                        ${soulFn:overlayTel(p.mobilePhone)}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='qq'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.qq}">
                                        ${soulFn:overlayString(p.qq)}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='weixin'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.weixin}">
                                        ${soulFn:overlayString(p.weixin)}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='parentUsername'}">
                            <td>
                                <c:if test="${p.topagentId eq p.parentId}">
                                    <a href="/vUserTopAgentManage/list.html?search.id=${p.parentId}" nav-target="mainFrame" class="co-blue">${p.parentUsername}</a>
                                </c:if>
                                <c:if test="${p.topagentId ne p.parentId}">
                                    <a href="/vUserAgentManage/list.html?search.id=${p.parentId}" nav-target="mainFrame" class="co-blue">${p.parentUsername}</a>
                                </c:if>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='playerNum'}">
                            <td><a href="/player/list.html?search.hasReturn=true&search.agentId=${p.id}" nav-target='mainFrame'>${p.playerNum}</a></td>
                        </c:when>
                        <c:when test="${f.key=='agentNum'}">
                            <td><a href="/vUserAgentManage/list.html?search.hasReturn=true&search.parentId=${p.id}" nav-target='mainFrame'>${p.agentNum}</a></td>
                        </c:when>
                        <c:when test="${f.key=='rankName'}">
                            <td><a href="/vPlayerRankStatistics/list.html" nav-target='mainFrame'>${p.rankName}</a></td>
                        </c:when>
                        <c:when test="${f.key=='country'}">
                            <td>${dicts.region.region[p.country]}-${dicts.state[p.country][p.region]}<c:set var="_key" value='${p.country.concat("_").concat(p.region)}'></c:set>-${dicts.city[_key][p.city]}</td>
                        </c:when>
                        <c:when test="${f.key=='defaultLocale'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.defaultLocale}">
                                        ${dicts.common.local[p.defaultLocale]}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='defaultCurrency'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.defaultCurrency}">
                                        ${dicts.common.currency[p.defaultCurrency]}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='defaultTimezone'}">
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p.defaultTimezone}">
                                        ${p.defaultTimezone}
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='createChannel'}">
                            <td>${dicts.player.create_channel[p.createChannel]}</td>
                        </c:when>
                        <c:when test="${f.key=='registerIp'}">
                            <td>${soulFn:formatIp(p.registerIp)} </td>
                        </c:when>
                        <c:when test="${f.key=='rebateName'}">
                            <td><a href="/rebateSet/list.html?searchId=${command.getSearchId(p.rebateId)}" nav-target='mainFrame'>${p.rebateName}</a></td>
                        </c:when>
                        <c:when test="${f.key=='rakebackName'}">
                            <td><a href="/setting/vRakebackSet/list.html?searchId=${command.getSearchId(p.rakebackId)}" nav-target='mainFrame'>${p.rakebackName}</a></td>
                        </c:when>
                        <c:when test="${f.key=='accountBalance'}">
                            <td>
                                <c:choose>
                                    <c:when test="${p.accountBalance > 0}">
                                        <fmt:formatNumber value="${p.accountBalance}" pattern="#,###.##"/>
                                    </c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='totalRebate'}">
                            <td>
                                <c:choose>
                                    <c:when test="${p.totalRebate > 0}">
                                        <a href="/report/rebate/rebateIndex.html?search.agentName=${p.username}" nav-target="mainFrame">
                                            <fmt:formatNumber value="${p.totalRebate}" pattern="#,###.##"></fmt:formatNumber>
                                        </a>
                                    </c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='username' or f.key=='status'}"></c:when>
                        <c:otherwise>
                            <td>
                                <c:choose>
                                    <c:when test="${!empty p[f.key]}">
                                        <c:choose>
                                            <c:when test="${f.key eq 'withdrawPlayerTotal' || f.key eq 'rechargePlayerTotal'}">
                                                <fmt:formatNumber value="${p[f.key]}" pattern="#,###.00"></fmt:formatNumber>
                                            </c:when>
                                            <c:otherwise>
                                                ${p[f.key]}
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <td>
                    <shiro:hasPermission name="role:agent_canaddsubagent">
                        <c:if test="${!(p.playerStatus eq '2')}">
                        <input type="checkbox" name="my-checkbox" data-size="mini" ${not empty p.addSubAgent && p.addSubAgent?'checked':''} value="${p.addSubAgent}" agentId="${p.id}">
                        </c:if>
                        <c:if test="${(p.playerStatus eq '2')}">
                            <input type="checkbox" name="my-checkbox" data-size="mini" ${not empty p.addSubAgent && p.addSubAgent?'checked':''} disabled>
                        </c:if>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="role:agent_canaddsubagent">
                        <input type="checkbox" name="my-checkbox" data-size="mini" ${not empty p.addSubAgent && p.addSubAgent?'checked':''} disabled>
                    </shiro:lacksPermission>

                </td>
                <td><span class="label ${color}">${dicts.player.user_status[p.playerStatus]}</span></td>
                <td>
                    <c:if test="${!(p.playerStatus eq '4') && !(p.playerStatus eq '2')}">
                        <shiro:hasPermission name="role:agent_addsubagent">
                            <a href="/userAgent/editSubAgent.html?search.parentId=${p.id}&editType=subAgent" nav-target="mainFrame">${views.player_auto['添加代理']}</a>
                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                        </shiro:hasPermission>
                    </c:if>
                    <c:if test="${p.playerStatus eq '4'}">
                        <c:if test="${empty p.parentUsername||p.parentUsername=='defaulttopagent'}">
                            <shiro:hasPermission name="role:agent_check">
                                <a href="/userAgent/toCheck.html?search.id=${p.id}" nav-target="mainFrame">${views.common['audit']}</a>
                            </shiro:hasPermission>
                        </c:if>
                    </c:if>
                    <c:if test="${!(p.playerStatus eq '4') && !(p.playerStatus eq '2')}">
                        <%--<soul:button target="${root}/" text="${views.player_auto['编辑']}" opType="dialog" callback="query" precall=""/>--%>
                        <shiro:hasPermission name="role:agent_edit">
                            <a href="/userAgent/edit.html?id=${p.id}&editType=${p.parentId eq p.topagentId ?'agent':'subAgent'}" nav-target="mainFrame" class="">${views.common['edit']}</a>
                            <span class="dividing-line m-r-xs m-l-xs">|</span>
                        </shiro:hasPermission>
                    </c:if>
                    <a href="/userAgent/agent/detail.html?search.id=${p.id}" nav-target="mainFrame" class="co-blue">${views.common['detail']}</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(command.result)<1}">
            <tr>
                <td colspan="${fn:length(command.fields)+2}" class="no-content_wrap">
                    <div>
                        <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                    </div>
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
<soul:pagination />