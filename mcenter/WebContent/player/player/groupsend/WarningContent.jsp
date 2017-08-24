<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-7-22
  Time: 上午10:35
--%>
<%--@elvariable id="userPlayerVo" type="so.wwb.gamebox.model.master.player.vo.UserPlayerVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
    <div style="margin-left: 100px;margin-top:50px;font-size: 16px">
            ${views.player_auto['您还未设置邮箱接口']}
    </div>
    <div class="modal-footer">
        <soul:button target="setEmailInterface" text="${views.player_auto['去设置']}" cssClass="btn btn-filter" opType="function"/>
        <soul:button target="closePage" text="${views.common_report['取消']}" cssClass="btn btn-filter" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/groupsend/EditContent"/>
</html>
