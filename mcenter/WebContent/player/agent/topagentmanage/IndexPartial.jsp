<%@ page import="so.wwb.gamebox.model.master.player.po.VUserTopAgentManage" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserTopAgentManageListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= VUserTopAgentManage.class %>"></c:set>
<div class="table-responsive table-min-h">
    <table class="table table-striped table-hover dataTable m-b-none" id="editable" aria-describedby="editable_info">
        <thead>
        <tr role="row" class="bg-gray">
            <th>${views.column['VUserTopAgentManage.username']}</th>
            <c:forEach items="${command.fields}" var="f" varStatus="status">
                <c:choose>
                    <c:when test="${f.key=='childAgentNum' or f.key=='playerNum'}">
                        <soul:orderColumn poType="${poType}" property="${f.key}" column="${views.column['VUserTopAgentManage.'.concat(f.value.feildName)]}"/>
                    </c:when>
                    <c:when test="${f.key=='username' or f.key=='status'}"></c:when>
                    <c:otherwise>
                        <th>${views.column['VUserTopAgentManage.'.concat(f.value.feildName)]}</th>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
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
            </c:choose>
            <tr class="tab-detail">
                <td>
                    <a href="/userAgent/topagent/detail.html?search.id=${p.id}" nav-target="mainFrame">${p.username}</a>
                </td>
                <c:forEach items="${command.fields}" var="f" varStatus="status">
                    <c:choose>
                        <c:when test="${f.key=='sex'}">
                            <td>${dicts.common.sex[p.sex]}</td>
                        </c:when>
                        <c:when test="${f.key=='birthday'}">
                            <td><fmt:formatDate value="${p.birthday}" type="date" pattern="${DateFormat.DAY}"/></td>
                        </c:when>
                        <c:when test="${f.key=='createTime'}">
                            <td><fmt:formatDate value="${p.createTime}" type="date" pattern="${DateFormat.DAY}"/></td>
                        </c:when>
                        <c:when test="${f.key=='mobilePhone'}">
                            <td>${soulFn:overlayTel(p.mobilePhone)}</td>
                        </c:when>
                        <c:when test="${f.key=='skype'}">
                            <td>${soulFn:overlayString(p.skype)}</td>
                        </c:when>
                        <c:when test="${f.key=='qq'}">
                            <td>${soulFn:overlayString(p.qq)}</td>
                        </c:when>
                        <c:when test="${f.key=='msn'}">
                            <td>${soulFn:overlayString(p.msn)}</td>
                        </c:when>
                        <c:when test="${f.key=='childAgentNum'}">
                            <td><a href="/vUserAgentManage/list.html?search.parentId=${p.id}" nav-target='mainFrame'>${p.childAgentNum}</a></td>
                        </c:when>
                        <c:when test="${f.key=='playerNum'}">
                            <td><a href="/player/list.html.html?search.generalAgentId=${p.id}" nav-target='mainFrame'>${p.playerNum}</a></td>
                        </c:when>
                        <c:when test="${f.key=='country'}">
                            <td>
                            ${dicts.region.region[p.country]}
                            <c:if test="${not empty p.region}">
                                -
                                <c:if test="${not empty dicts.state[p.country][p.region]}">
                                    ${dicts.state[p.country][p.region]}
                                </c:if>
                                <c:if test="${empty dicts.state[p.country][p.region]}">
                                    ${p.region}
                                </c:if>
                            </c:if>
                            <%--<c:if test="${not empty p.city}">
                                -
                                <c:set var="_key" value='${p.country.concat("_").concat(p.region)}'></c:set>
                                ${dicts.city[_key][p.city]}
                            </c:if>--%>
                                <%---${dicts.region.state[p.region]}--%>
                            </td>
                        </c:when>
                        <c:when test="${f.key=='mail'}">
                            <td>${soulFn:overlayEmaill(p.mail)}</td>
                        </c:when>
                        <c:when test="${f.key=='defaultLocale'}">
                            <td>${dicts.common.local[p.defaultLocale]}</td>
                        </c:when>
                        <c:when test="${f.key=='defaultTimezone'}">
                            <td>${p.defaultTimezone}</td>
                        </c:when>
                        <c:when test="${f.key=='createChannel'}">
                            <td>${dicts.player.create_channel[p.createChannel]}</td>
                        </c:when>
                        <c:when test="${f.key=='registerIp'}">
                            <td>${soulFn:formatIp(p.registerIp)} </td>
                        </c:when>
                        <c:when test="${f.key=='username' or f.key=='status'}"></c:when>
                        <c:when test="${f.key=='rebatenum'}">
                            <td><a href="/rebateSet/list.html?topAgentId=${p.id}" nav-target='mainFrame'>${p[f.key]}</a></td>
                        </c:when>
                        <c:when test="${f.key=='rakebacknum'}">
                            <td><a href="/setting/vRakebackSet/list.html?topAgentId=${p.id}" nav-target='mainFrame'>${p[f.key]}</a></td>
                        </c:when>
                        <c:when test="${f.key=='lastLoginTime'}">
                            <td>${soulFn:formatDateTz(p.lastLoginTime, DateFormat.DAY_SECOND,timeZone)}</td>
                        </c:when>
                        <c:otherwise>
                            <td>${p[f.key]}</td>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <td><span class="label ${color}">${dicts.player.user_status[p.playerStatus]}</span></td>
                <td>
                    <shiro:hasPermission name="role:topagent_edit">
                        <a href="/userAgent/editTopAgent.html?search.id=${p.id}" nav-target="mainFrame" class="">${views.common['edit']}</a>
                        <span class="dividing-line m-r-xs m-l-xs">|</span>
                    </shiro:hasPermission>

                    <a href="/userAgent/topagent/detail.html?search.id=${p.id}" nav-target="mainFrame">${views.common['detail']}</a>
                </td>
            </tr>
            <%--<tr class="bg-color">
                <td colspan="${command.fields.size()+3}" class="p-x" id="${p.id}"></td>
            </tr>--%>
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