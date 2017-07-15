<%--
  Created by IntelliJ IDEA.
  User: cogo
  Date: 16-01-13
  Time: 下午4:30
--%>
<%--@elvariable id="resetPwdVo" type="so.wwb.gamebox.model.master.agent.vo.ResetSysUserPwdVoo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form>
        <div class="modal-body">

            <div id="validateRule" style="display: none">${resetPwdVo.validateRule}</div>
            <input value="${resetPwdVo.resetType}" type="hidden" name="resetType" />
            <input value="${resetPwdVo.result.id}" type="hidden" name="result.id" />
            <input value="${resetPwdVo.result.username}" type="hidden" id="userName" />
            <input value="${resetPwdVo.login}" type="hidden" id="isLogin" name="login" />
            <input type="hidden" id="resetTypeName" value="${views.role[resetPwdVo.resetType]}">
            <div class="m-b-sm">${views.role['sysUserAccount']}<span class="co-blue">${resetPwdVo.result.username}</span>
                <c:if test="${resetPwdVo.login=='true'}">
                    <span class="m-l-sm co-green">${views.role['user.online.status.online']}</span>
                </c:if>
                <c:if test="${resetPwdVo.login=='false'}">
                    <span class="m-l-sm co-grayc2">${views.role['user.online.status.offline']}</span>
                </c:if>

            </div>
            <div class="condition-options-wraper">
                <c:choose>
                    <c:when test="${resetPwdVo.resetType eq 'permissionPwd'}">
                        <div class="form-group">
                            <label>${views.role['newPwd']}</label>
                            <input type="password" name="newpermissionPwd" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>${views.role['confirmNewPwd']}</label>
                            <input type="password" name="confirmNewPermissionPwd" class="form-control">
                        </div>

                    </c:when>
                    <c:when test="${resetPwdVo.resetType eq 'loginPwd'}">
                        <div class="form-group">
                            <label>${views.role['newPwd']}</label>
                            <input type="password" name="newPwd" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>${views.role['confirmNewPwd']}</label>
                            <input type="password" name="confirmNewPwd" class="form-control">
                        </div>

                    </c:when>
                </c:choose>
                <div class="form-group">
                    <label>
                        <input type="radio" class="i-checks" checked  name="informType" value="mail">
                        ${fn:replace(views.role['sendMailInformAgent'], "{0}",dicts.common.user_type[resetPwdVo.result.userType] )}
                        <%--demovip@demovip.com--%>
                        <%--${resetPwdVo.result.mailStatus eq 1 ? '未激活':'已经激活'}--%>

                        <c:choose>
                            <c:when test="${resetPwdVo.result.mail eq '' || resetPwdVo.result.mail eq null}">
                                <input name="mail" value="" type="text"/>
                            </c:when>
                            <c:when test="${resetPwdVo.result.mailStatus eq '12'}">

                                <input name="mail" value="${resetPwdVo.result.mail}" type="email"/>&nbsp;<span class="co-red">${views.role['Agent.restpwd.unVerified']}</span>

                            </c:when>
                            <c:otherwise>
                                ${resetPwdVo.result.mail}&nbsp;<span class="co-blue">${views.role['Agent.restpwd.Verified']}</span>
                            </c:otherwise>
                        </c:choose>
                    </label>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <soul:button precall="validateForm" cssClass="btn btn-filter" target="resetPwdByHandConfirm" tag="button" opType="function" text="${views.common['OK']}"></soul:button>
            <soul:button target="closePage" cssClass="btn btn-outline btn-filter" opType="function" text="${views.common['cancel']}"></soul:button>
        </div>
    </form>
</body>
<%@ include file="/include/include.js.jsp" %>
</html>
<soul:import res="site/player/agent/resetpwd/ResetPwdEdit"/>
