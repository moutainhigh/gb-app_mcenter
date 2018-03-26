<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<span class="title">${views.player_auto['真实姓名']}</span>
<div class="content" id="real-name-detail">
    <span id="show-real-name">${command.result.realName}</span>
    <c:set var="nameCount" value="${empty repeatNum['realname'] ? 0 : repeatNum['realname']}"></c:set>
    <span class="co-gray same-name-span">${views.player_auto['相同']}
        <c:if test="${nameCount>0}">
            <a href="/player/list.html?search.realName=${command.convertRealName}&search.hasReturn=true" nav-target="mainFrame" class="co-red">${nameCount}</a>
        </c:if>
        <c:if test="${nameCount<=0}">${nameCount}</c:if>
         ${views.player_auto['位']}
    </span>
    <c:if test="${command.result.status ne '2'}">
        <soul:button  permission="role:player_editusername" target="editRealName" text="${views.player_auto['修改真实姓名']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
    </c:if>
    <soul:button target="showPersonalDetail" text="${views.player_auto['查看完整个人信息']}" opType="function" cssClass="btn btn-link hide show-detail-btn co-blue"></soul:button>
    <c:if test="${command.result.status ne '2'}">
        <a href="/player/getVUserPlayer.html?comeFrom=detail&search.id=${command.result.id}" nav-target="mainFrame" class="btn btn-link co-blue player-edit-btn">${views.player_auto['修改资料']}</a>
    </c:if>
    <soul:button target="hidePersonalDetail" text="${views.player_auto['返回']}" opType="function" fromShowBtn="true" cssClass="btn btn-link co-blue hide-personaldata-btn"></soul:button>
</div>
<div class="content hide" id="real-name-edit">
    <div class="table-desc-right-t">
        <input type="text" class="form-control" name="result.realName" value="${command.result.realName}">
    </div>
    <soul:button target="updateRealName" text="${views.player_auto['保存']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
    <soul:button target="cancelEditRealName" text="${views.common_report['取消']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
</div>
<div class="p-b-sm" id="player-personal-detail">
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
                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <c:if test="${electric_pin.paramValue==true}">
                <soul:button target="callPlayer" text="${messages.player_auto['拨打电话']}" opType="function" playerId="${command.result.id}">
                    <img src="${resRoot}/images/call.png" width="15" height="15">
                </soul:button>
                </c:if>
                <c:set var="phoneCount" value="${empty repeatNum['mobile'] ? 0 : repeatNum['mobile']}"></c:set>
                <span class="co-gray pull-right">
                    <c:if test="${phoneCount>0}">${views.player_auto['相同']} <a class="co-red" href="/player/list.html?search.mobilePhone=${command.result.mobilePhone}&search.hasReturn=true" nav-target="mainFrame">${phoneCount}</a> ${views.player_auto['位']}</c:if>
                    <c:if test="${phoneCount<=0}">${fn:replace(views.player_auto['相同位'],"[0]",phoneCount)}</c:if>
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
                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <c:set var="qqCount" value="${empty repeatNum['qq']? 0 : repeatNum['qq']}"></c:set>
                <span class="co-gray pull-right">
                    <c:if test="${qqCount>0}">${views.player_auto['相同']} <a href="/player/list.html?search.qq=${command.result.qq}&search.hasReturn=true" nav-target="mainFrame" class="co-red">${qqCount}</a> ${views.player_auto['位']}</c:if>
                    <c:if test="${qqCount<=0}">${fn:replace(views.player_auto['相同位'],"[0]",qqCount)}</c:if>
                </span>
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
                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <c:set var="mailCount" value="${empty repeatNum['email']? 0 : repeatNum['email']}"></c:set>
                <span class="co-gray pull-right">
                    <c:if test="${mailCount>0}">${views.player_auto['相同']} <a href="/player/list.html?search.mail=${command.result.mail}&search.hasReturn=true" nav-target="mainFrame" class="co-red">${mailCount}</a> ${views.player_auto['位']}</c:if>
                    <c:if test="${mailCount<=0}">${fn:replace(views.player_auto['相同位'],"[0]",mailCount)}</c:if>
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
                                             callback="setPersonalData"   opType="ajax" permission="role:player_personal_detail"></soul:button>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <c:set var="weixinCount" value="${empty repeatNum['weixin']? 0 : repeatNum['weixin']}"></c:set>
                <span class="co-gray pull-right">
                    <c:if test="${weixinCount>0}">${views.player_auto['相同']} <a href="/player/list.html?search.weixin=${command.result.weixin}&search.hasReturn=true" nav-target="mainFrame" class="co-red">${weixinCount}</a> ${views.player_auto['位']}</c:if>
                    <c:if test="${weixinCount<=0}">${fn:replace(views.player_auto['相同位'],"[0]",weixinCount)}</c:if>
                </span>
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
</div>