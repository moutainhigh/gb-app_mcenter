<%@ page contentType="text/html;charset=UTF-8" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.RemarkListVo"--%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.role['player.view.funds.viewMore']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<!--备注查看更多-->
<div class="modal-body">
    <form:form action="${root}/playerRemark/moreRemark.html" method="post">
        <div class="search-list-container">
            <%@include file="MoreRemarkPartial.jsp" %>
        </div>
    </form:form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/remark/Remark"/>
</html>
