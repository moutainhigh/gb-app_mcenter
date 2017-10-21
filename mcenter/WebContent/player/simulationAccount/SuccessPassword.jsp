<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<div id="success-pwd-div">
    <div class="row">
        <c:choose>
            <c:when test="${newPwd!=null}">
                <div class="col-xs-12">
                    <p class="al-center">${views.player_auto['登录密码已重设为']}</p>
                    <div class="text-center">
                        <strong class="co-orange fs30 m-r vertical-align-m" style="font-size: 22px;height: 30px">${newPwd}</strong>
                        <a class="btn btn-outline btn-filter" type="button" data-clipboard-text="${newPwd}" name="copy">${views.player_auto['复制']}</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <p class="al-center">重设密码失败！</p>
            </c:otherwise>
        </c:choose>


    </div>

</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/simulationAccount/ResetPassword"/>
</html>