<%--@elvariable id="player" type="so.wwb.gamebox.model.master.player.po.VUserPlayer"--%>
<%--@elvariable id="sysUser" type="org.soul.model.security.privilege.po.SysUser"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form>
<div class="modal-body">
    <div class="m-md">
        <table class="table table-hover table-bordered table-desc-list">
            <tbody>
            <tr>
                <th scope="row" class="text-right active">${views.fund_auto['玩家账号']}：</th>
                <td colspan="2">
                    <soul:button target="showPlayerDetail" text="${player.username}" playerId="${player.id}" opType="function">
                        <strong>${player.username}</strong>
                    </soul:button>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right active">${views.fund_auto['真实姓名']}：</th>
                <td>${empty player.realName?views.fund_auto['无']:player.realName}</td>
                <td class="co-grayc2">
                    <c:set var="nameCount" value="${empty repeatNum['realname'] ? 0 : repeatNum['realname']}"></c:set>
                    （${views.fund_auto['相同']}
                    <c:if test="${nameCount>0}">
                        <soul:button target="toSameName" text="${nameCount}" data="${player.realName}" opType="function" realName="">
                            <strong>${nameCount}</strong>
                        </soul:button>
                    </c:if>
                    <c:if test="${nameCount<=0}">
                        <strong>0</strong>
                    </c:if>
                    ${views.fund_auto['位']}）
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right active">${views.fund_auto['手机']}：</th>
                <td class="showNum">${empty player.mobilePhone? views.fund_auto['无'] :soulFn:overlayTel(player.mobilePhone)}</td>
                <td class="co-grayc2">
                    <c:set var="phoneCount" value="${empty repeatNum['mobile'] ? 0 : repeatNum['mobile']}"></c:set>
                    （${views.fund_auto['相同']}
                    <c:if test="${phoneCount>0}">
                        <soul:button target="toSamePhone" text="${phoneCount}" data="${player.mobilePhone}" opType="function">
                            <strong>${phoneCount}</strong>
                        </soul:button>
                    </c:if>
                    <c:if test="${phoneCount<=0}"><strong>0</strong></c:if>
                    ${views.fund_auto['位']}）
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right active">${views.fund_auto['邮箱']}：</th>
                <td>${empty player.mail?views.fund_auto['无']:soulFn:overlayEmaill(player.mail)}</td>
                <td class="co-grayc2">
                    <c:set var="mailCount" value="${empty repeatNum['email']? 0 : repeatNum['email']}"></c:set>
                    （${views.fund_auto['相同']}
                    <c:if test="${mailCount>0}">
                        <soul:button target="toSameMail" text="${mailCount}" data="${player.mail}"  opType="function">
                            <strong>${mailCount}</strong>
                        </soul:button>
                    </c:if>
                    <c:if test="${mailCount<=0}">
                        <strong>0</strong>
                    </c:if>
                    ${views.fund_auto['位']}）
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right active">QQ：</th>
                <td class="showNum">${empty player.qq? views.fund_auto['无'] :soulFn:overlayString(player.qq)}</td>
                <td class="co-grayc2">
                    <c:set var="qqCount" value="${empty repeatNum['qq']? 0 : repeatNum['qq']}"></c:set>
                    （${views.fund_auto['相同']}
                    <c:if test="${qqCount>0}">
                        <soul:button target="toSameQq" qq="${player.qq}" text="${qqCount}"  opType="function">
                            <strong>${qqCount}</strong>
                        </soul:button>
                    </c:if>
                    <c:if test="${qqCount<=0}">
                        <strong>0</strong>
                    </c:if>
                    ${views.fund_auto['位']}）
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right active">${views.fund_auto['微信']}：</th>
                <td>${empty player.weixin?views.fund_auto['无']:soulFn:overlayString(player.weixin)}</td>
                <td class="co-grayc2">
                    <c:set var="weixinCount" value="${empty repeatNum['weixin']? 0 : repeatNum['weixin']}"></c:set>
                    （${views.fund_auto['相同']}
                    <c:if test="${weixinCount>0}">
                        <soul:button target="toSameWeixin" text="${weixinCount}" data="${player.weixin}" opType="function">
                            <strong>${weixinCount}</strong>
                        </soul:button>
                    </c:if>
                    <c:if test="${weixinCount<=0}">
                        <strong>0</strong>
                    </c:if>
                    ${views.fund_auto['位']}）
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right active">${views.fund_auto['最近登录IP']}：</th>
                <td>
                    <soul:button target="toSameLoginIp" text="${soulFn:formatIp(sysUser.lastLoginIp)}" ip="${sysUser.lastLoginIp}" opType="function">
                        <strong>${soulFn:formatIp(sysUser.lastLoginIp)}</strong>
                    </soul:button>
                    <div>${soulFn:formatDateTz(sysUser.lastLoginTime, DateFormat.DAY_SECOND,timeZone)}
                         - <span class="co-grayc2">${soulFn:formatTimeMemo(sysUser.lastLoginTime, locale)}</span>
                    </div>
                </td>
                <td class="co-grayc2">
                    <c:set var="loginipCount" value="${empty repeatNum['loginip']? 0 : repeatNum['loginip']}"></c:set>
                    （${views.fund_auto['相同']}
                    <c:if test="${loginipCount>0}">
                        <soul:button target="toSameLoginIp" text="${loginipCount}" ip="${sysUser.lastLoginIp}" opType="function">
                            <strong>${loginipCount}</strong>
                        </soul:button>
                    </c:if>
                    <c:if test="${loginipCount<=0}">
                        <strong>0</strong>
                    </c:if>
                    ${views.fund_auto['位']}）
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-right active">${views.fund_auto['注册IP']}：</th>
                <td>
                    <soul:button target="toSameRegisterIp" text="${soulFn:formatIp(player.registerIp)}" ip="${player.registerIp}" opType="function">
                        <strong>${soulFn:formatIp(player.registerIp)}</strong>
                    </soul:button>
                    <%--<a href="javascript:void(0);"><strong>${soulFn:formatIp(player.registerIp)}</strong></a>--%>
                    <div>${soulFn:formatDateTz(player.createTime, DateFormat.DAY_SECOND,timeZone)}
                         - <span class="co-grayc2">${soulFn:formatTimeMemo(player.createTime, locale)}</span>
                    </div>
                </td>
                <td class="co-grayc2">
                    <c:set var="registeripCount" value="${empty repeatNum['registerip']? 0 : repeatNum['registerip']}"></c:set>
                    （${views.fund_auto['相同']}
                    <c:if test="${registeripCount>0}">
                        <soul:button target="toSameRegisterIp" ip="${player.registerIp}" text="${registeripCount}"  opType="function">
                            <strong>${registeripCount}</strong>
                        </soul:button>
                    </c:if>
                    <c:if test="${registeripCount<=0}">
                        <strong>0</strong>
                    </c:if>
                    ${views.fund_auto['位']}）
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/fund/withdraw/PlayerDetect"/>
</html>