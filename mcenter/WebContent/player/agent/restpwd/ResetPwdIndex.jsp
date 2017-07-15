<%--
  Created by IntelliJ IDEA.
  User: cogo
  Date: 16-01-13
  Time: 下午2:53
--%>
<%--@elvariable id="resetPwdVo" type="so.wwb.gamebox.model.master.agent.vo.ResetSysUserPwdVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body id="resetPwd">
    <div class="modal-body">

        <%--userPlayerVo 该玩家未验证邮箱，请选择其他方式重置登录密码--%>
        <%--<button type="button" class="btn-qfdx" data-toggle="modal" data-target="#pwd-con"><i class="fa fa-envelope-o"></i>${views.player_auto['发送邮箱重置密码链接']}</button>--%>
        <%--该玩家未验证邮箱，请选择其他方式重置登录密码--%>
        <!-- ${resetPwdVo.result.username} -->
        <input type="hidden" id="resetType" value="${resetPwdVo.resetType}" />
        <c:set var="resetTypeName" value="${views.role[resetPwdVo.resetType]}"></c:set>
       <input type="hidden" id="resetTypeName" value="${views.role[resetPwdVo.resetType]}">
        <input type="hidden" id="userName" value="${resetPwdVo.result.username}">
        <input type="hidden" id="userId" value="${resetPwdVo.result.id}">
        <input type="hidden" id="mail" value="${resetPwdVo.result.mail}"/>
        <input type="hidden" id="login" value="${resetPwdVo.login}"/>

        <c:choose>
            <c:when test="${resetPwdVo.result.mail eq null || resetPwdVo.result.mail eq ''}">
                <soul:button target="userHasNoEmail" tag="button" opType="function" cssClass="btn-qfdx"
                     text="${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}">
                    <i class="fa fa-envelope-o"></i>${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}
                </soul:button>
            </c:when>
            <c:when test="${empty resetPwdVo.login}">
                <soul:button target="resetPwdLoginConfirm" tag="button" opType="function" cssClass="btn-qfdx"
                     text="${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}">
                    <i class="fa fa-envelope-o"></i>${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}
                </soul:button>
            </c:when>
            <c:otherwise>
                <soul:button target="resetPwdByEmailConfirm" callback="" tag="button" opType="function" cssClass="btn-qfdx"
                     confirmMessage="${fn:replace(fn:replace(views.role['resetPwdByMailNotLoginConfirm'],'{userName}' ,resetPwdVo.result.username ),'{resetTypeName}',resetTypeName)}"
                     text="${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}">
                    <i class="fa fa-envelope-o"></i>${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}
                </soul:button>
            </c:otherwise>
        </c:choose>

        <%-- 短信功能二期
            <button type="button" class="btn-qfdx" data-toggle="modal" data-target="#pwd-con"><i class="fa fa-comment-o"></i>${views.player_auto['发送短信重置密码']}</button>
         <soul:button target="" opType="" cssClass="btn-qfdx">
            <i class="fa fa-retweet"></i>${views.role['resetPwdBySMS']}
        </soul:button>
        --%>
        <soul:button callback="resetPwdCallback" text="${fn:replace(views.role['resetPwdByHand'],'{resetTypeName}',resetTypeName)}" target="${root}/player/resetPwd/goRestUserPwdEdit.html?resetType=${resetPwdVo.resetType}&result.id=${resetPwdVo.result.id}" opType="dialog" cssClass="btn-qfdx" tag="button">
            <i class="fa fa-retweet"></i>${fn:replace(views.role['resetPwdByHand'],'{resetTypeName}',resetTypeName)}
        </soul:button>
    </div>
</body>
<%@ include file="/include/include.js.jsp" %>
</html>
<soul:import res="site/player/agent/resetpwd/ResetPwdIndex"/>
