<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-7-6
  Time: 下午4:30
--%>
<%--@elvariable id="resetPwdVo" type="so.wwb.gamebox.model.master.player.vo.ResetPwdVo"--%>
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
            <input value="${isOnLine}" type="hidden" name="isOnLine" />
            <input value="${resetPwdVo.resetType}" type="hidden" name="resetType" />
            <input value="${resetPwdVo.userId}" type="hidden" name="userId" />
            <input value="${resetPwdVo.result.username}" type="hidden" id="userName" />
            <input type="hidden" id="resetTypeName" value="${views.role[resetPwdVo.resetType]}">
            <div class="m-b-sm">${views.role['playerAccount']}<span class="co-blue">${resetPwdVo.result.username}</span></div>
            <div class="condition-options-wraper">
                <c:choose>
                    <c:when test="${resetPwdVo.resetType eq 'payPwd'}">
                        <div class="form-group">
                            <label>${views.role['newPwd']}</label>
                            <input type="password" name="permissionPwd" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>${views.role['confirmNewPwd']}</label>
                            <input type="password" name="confirmPermissionPwd" class="form-control">
                        </div>

                    </c:when>
                    <c:when test="${resetPwdVo.resetType eq 'loginPwd'}">
                        <div class="form-group">
                            <label>${views.role['newPwd']}</label>
                            <input type="password" name="password" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>${views.role['confirmNewPwd']}</label>
                            <input type="password" name="confirmLoginPwd" class="form-control">
                        </div>

                    </c:when>
                </c:choose>
                <div class="form-group">
                    <label>
                        <input type="checkbox" class="i-checks" id="mailCheck"  name="informType">
                        ${views.role['sendMailInformPlayer']}
                        <%--demovip@demovip.com--%>
                        <%--${resetPwdVo.result.mailStatus eq 1 ? '未激活':'已经激活'}--%>

                        <c:choose>
                            <c:when test="${resetPwdVo.result.mail eq '' || resetPwdVo.result.mail eq null}">
                             <input name="mail" value="" type="text"/>
                            </c:when>
                            <c:when test="${resetPwdVo.result.mailStatus eq 'unActivated'}">

                             <input name="mail" value="${resetPwdVo.result.mail}" type="email" class="form-control"/>

                            </c:when>
                            <c:otherwise>
                                ${resetPwdVo.result.mail}
                            </c:otherwise>
                        </c:choose>
                        <%----%>
                        <c:if test="${resetPwdVo.result.mail ne '' && resetPwdVo.result.mail ne null}">
                            <c:forEach items="${resetPwdVo.mailMobilePhoneStatus}" var="item">
                                <c:if test="${item.value.dictCode eq resetPwdVo.result.mailStatus}">
                                    <span class="co-red"> ${dicts[item.value.module][item.value.dictType][item.value.dictCode]}</span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </label>
                </div>
        <%--        <div class="form-group">
                    <label>
                        <input type="radio" class="i-checks"  name="informType" value="sms">
                        ${views.role['sendSMSInformPlayer']}
                        <c:choose>
                            <c:when test="${resetPwdVo.result.mobilePhone eq '' || resetPwdVo.result.mobilePhone eq null}">
                                <input name="mobilePhone" value="" type="text"/>
                            </c:when>
                            <c:when test="${resetPwdVo.result.mobilePhoneStatus eq 1}">
                                <input name="mobilePhone" value="${resetPwdVo.result.mobilePhone}" type="text"/>
                                &lt;%&ndash;<c:set value="" ></c:set>&ndash;%&gt;
                            </c:when>
                            <c:otherwise>
                                ${resetPwdVo.result.mobilePhone}
                            </c:otherwise>
                        </c:choose>
                    </label>
                </div>--%>
                <!--<button type="button" class="btn btn-xs btn-white">${views.player_auto['发送']}</button>-->
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
<soul:import res="site/player/player/resetpassword/ChangePassword"/>
