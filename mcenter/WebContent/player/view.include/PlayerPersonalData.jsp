<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<table class="table table-bordered table-desc-list width-response" style="background: #fff;">
    <tbody>
    <tr>
        <th scope="row" class="text-center active" style="width: 15%">${views.player_auto['手机']}</th>
        <td style="width: 35%">
            <c:if test="${empty command.result.mobilePhone}">
                <span class="co-grayc2">${views.player_auto['未填写']}</span>
            </c:if>
            <c:if test="${not empty command.result.mobilePhone}">
                <c:choose>
                    <c:when test="${command.result.mobilePhoneWayStatus==22}">
                        ${views.role['player.view.clearcontact']}
                    </c:when>
                    <c:otherwise>
                        <c:if test="${unencryption}">
                            ${command.result.mobilePhone}
                        </c:if>
                        <c:if test="${!unencryption}">
                            ${soulFn:overlayTel(command.result.mobilePhone)}&nbsp;
                            <c:if test="${not empty command.result.mobilePhone}">
                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                             callback="setPersonalData"   opType="ajax" permission="role:player_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <soul:button target="callPlayer" text="${messages.player_auto['拔打电话']}" opType="function" playerId="${command.result.id}">
                    <img src="${resRoot}/images/call.png" width="15" height="15">
                </soul:button>
                <span class="btn btn-xs btn-danger btn-stroke m-l-sm pull-right">
                        ${dicts.notice.contact_way_status[command.result.mobilePhoneWayStatus]}
                </span>
            </c:if>
        </td>
        <th scope="row" class="text-center active">QQ</th>
        <td>
            <c:if test="${empty command.result.qq}">
                <span class="co-grayc2">${views.player_auto['未填写']}</span>
            </c:if>
            <c:if test="${not empty command.result.qq}">
                <c:choose>
                    <c:when test="${command.result.qqWayStatus==22}">
                        ${views.role['player.view.clearcontact']}
                    </c:when>
                    <c:otherwise>
                        <c:if test="${unencryption}">
                            ${command.result.qq}
                        </c:if>
                        <c:if test="${!unencryption}">
                            ${soulFn:overlayString(command.result.qq)}&nbsp;
                            <c:if test="${empty command.result.mobilePhone && not empty command.result.qq}">
                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                             callback="setPersonalData"   opType="ajax" permission="role:player_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </td>
    </tr>
    <tr>
        <th scope="row" class="text-center active">${views.player_auto['邮箱']}</th>
        <td>
            <c:if test="${empty command.result.mail}">
                <span class="co-grayc2">${views.player_auto['未填写']}</span>
            </c:if>
            <c:if test="${not empty command.result.mail}">
                <c:choose>
                    <c:when test="${command.result.mailWayStatus==22}">
                        ${views.role['player.view.clearcontact']}
                    </c:when>
                    <c:otherwise>
                        <c:if test="${unencryption}">
                            ${command.result.mail}
                        </c:if>
                        <c:if test="${!unencryption}">
                            ${soulFn:overlayEmaill(command.result.mail)}&nbsp;
                            <c:if test="${empty command.result.mobilePhone&&empty command.result.qq && not empty command.result.mail}">
                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                             callback="setPersonalData"   opType="ajax" permission="role:player_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <span class="btn btn-xs btn-danger btn-stroke m-l-sm pull-right">
                        ${dicts.notice.contact_way_status[command.result.mailWayStatus]}
                </span>
            </c:if>

        </td>
        <th scope="row" class="text-center active" style="width: 15%">${views.player_auto['性别']}</th>
        <td style="width: 35%">
            <c:if test="${empty command.result.sex}">
                <span class="co-grayc2">${views.player_auto['未填写']}</span>
            </c:if>
            <c:if test="${not empty command.result.sex}">
                <span class="co-black">${dicts.common.sex[command.result.sex]}</span>
            </c:if>
        </td>
    </tr>
    <tr>
        <th scope="row" class="text-center active">${views.player_auto['微信']}</th>
        <td>
            <c:if test="${empty command.result.weixin}">
                <span class="co-grayc2">${views.player_auto['未填写']}</span>
            </c:if>
            <c:if test="${not empty command.result.weixin}">
                <c:choose>
                    <c:when test="${command.result.weixinWayStatus==22}">
                        ${views.role['player.view.clearcontact']}
                    </c:when>
                    <c:otherwise>
                        <c:if test="${unencryption}">
                            ${command.result.weixin}
                        </c:if>
                        <c:if test="${!unencryption}">
                            ${soulFn:overlayString(command.result.weixin)}&nbsp;
                            <c:if test="${empty command.result.mail && empty command.result.mobilePhone && empty command.result.qq && not empty command.result.weixin}">
                                <soul:button target="${root}/player/playerViewDetail.html?search.id=${command.result.id}" text="${views.common['view']}"
                                             callback="setPersonalData"   opType="ajax" permission="role:player_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </td>
        <th scope="row" class="text-center active">${views.player_auto['生日']}</th>
        <td>
            <c:if test="${empty command.result.birthday}">
                <span class="co-grayc2">${views.player_auto['未填写']}</span>
            </c:if>
            <c:if test="${not empty command.result.birthday}">
                <span class="co-black">${soulFn:formatDateTz(command.result.birthday, DateFormat.DAY,timeZone)}</span>
            </c:if>
        </td>
    </tr>
    </tbody>
</table>