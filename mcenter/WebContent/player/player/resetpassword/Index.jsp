<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-7-6
  Time: 下午2:53
--%>
<%--@elvariable id="resetPwdVo" type="so.wwb.gamebox.model.master.player.vo.ResetPwdVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body id="resetPwd">
    <div class="modal-body">
        <form>
        <%--userPlayerVo 该玩家未验证邮箱，请选择其他方式重置登录密码--%>
        <%--<button type="button" class="btn-qfdx" data-toggle="modal" data-target="#pwd-con"><i class="fa fa-envelope-o"></i>${views.player_auto['发送邮箱重置密码链接']}</button>--%>
        <%--该玩家未验证邮箱，请选择其他方式重置登录密码--%>
        <input type="hidden" id="resetType" name="resetType" value="${resetPwdVo.resetType}" />
        <c:set var="resetTypeName" value="${views.role[resetPwdVo.resetType]}"></c:set>
        <input type="hidden" id="resetTypeName" value="${resetTypeName}">
        <input type="hidden" id="userName" value="${resetPwdVo.result.username}">
        <input type="hidden" id="userId" name="userId" value="${resetPwdVo.userId}">
        <div id="reset-pwd-div">
            <c:choose>
                <c:when test="${resetPwdVo.result.mail eq null || resetPwdVo.result.mail eq ''}">
                    <soul:button target="playerHasNoEmail" tag="button" opType="function" cssClass="btn-qfdx"
                                 text="${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}">

                        <i class="fa fa-envelope-o"></i>${fn:replace(views.role['resetPwdByMail'],'{resetTypeName}',resetTypeName)}

                    </soul:button>
                </c:when>
                <c:when test="${resetPwdVo.login}">
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
            <%--<soul:button callback="resetPwdCallback" text="${fn:replace(views.role['resetPwdByHand'],'{resetTypeName}',resetTypeName)}"
                         target="${root}/player/resetPwd/resetPwdByHand.html?resetType=${resetPwdVo.resetType}&userId=${resetPwdVo.userId}"
                         opType="dialog" cssClass="btn-qfdx" tag="button">
                <i class="fa fa-retweet"></i>${fn:replace(views.role['resetPwdByHand'],'{resetTypeName}',resetTypeName)}
            </soul:button>--%>
            <soul:button callback="" text="${fn:replace(views.role['resetPwdByHand'],'{resetTypeName}',resetTypeName)}"
                         target="autoReset"
                         opType="function" cssClass="btn-qfdx" tag="button">
                <i class="fa fa-retweet"></i>${fn:replace(views.role['resetPwdByHand'],'{resetTypeName}',resetTypeName)}
            </soul:button>
        </div>
        </form>
    </div>

</body>
<%@ include file="/include/include.js.jsp" %>
</html>
<soul:import res="site/player/player/resetpassword/Index"/>
