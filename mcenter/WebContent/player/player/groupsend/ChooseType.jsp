<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
    <%@ include file="/include/include.head.jsp" %>
    <title>${views.role['Player.list.groupsend.groupsenditleT']}</title>
</head>
<body>
    <div id="chooseType_btn" class="modal-body">
    <%--<form:form>--%>
            <soul:button tag="button" cssClass="btn-qfdx" precall="" opType="dialog"
                         text="${views.role['player.sendMessage.button.email']}" callback="returnPage"
                         target="${root}/player/groupSend/sendByType.html?ids=${playerIds}&sendType=mail" ><i class="fa fa-envelope-o"></i>${views.role['player.sendMessage.button.email']}
            </soul:button>

            <soul:button tag="button" cssClass="btn-qfdx" precall=""  opType="dialog"
                         target="${root}/player/groupSend/sendByType.html?ids=${playerIds}&sendType=stationLetter"
                         text="${views.role['player.sendMessage.button.stationLetter']}"><i class="fa fa-comment-o"></i>${views.role['player.sendMessage.button.stationLetter']}
            </soul:button>
    <%--</form:form>--%>
    </div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/groupsend/ChooseType"/>
</html>