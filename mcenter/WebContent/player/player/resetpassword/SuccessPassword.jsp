<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div id="success-pwd-div">
    <div class="row">
        <div class="col-xs-12">
            <c:if test="${resetPwdVo.resetType=='loginPwd'}">
                <p class="al-center">${views.player_auto['登录密码已重设为']}</p>
            </c:if>
            <c:if test="${resetPwdVo.resetType=='payPwd'}">
                <p class="al-center">${views.player_auto['安全密码已重设为']}</p>
            </c:if>
            <div class="text-center">
                <strong class="co-orange fs30 m-r vertical-align-m" style="font-size: 22px;height: 30px">${newPwd}</strong>
                <a class="btn btn-outline btn-filter" type="button" data-clipboard-text="${newPwd}" name="copy">${views.player_auto['复制']}</a>
            </div>
        </div>

    </div>

</div>