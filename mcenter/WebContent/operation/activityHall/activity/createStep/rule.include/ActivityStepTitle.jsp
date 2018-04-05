<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<ul class="artificial-tab clearfix">
    <c:choose>
        <c:when test="${activityType.result.code eq 'content'}">
            <li class="col-sm-3 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
        </c:when>
        <c:otherwise>
            <li class="col-sm-3 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['Activity.content']}</span></a></li>
            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['Activity.rule']}</span></a></li>
            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['Activity.preview']}</span></a></li>
            <li class="col-sm-3 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">4</span><span class="con">${views.operation['Activity.finish']}</span></a></li>
        </c:otherwise>
    </c:choose>
</ul>
<!--//endregion your codes 1-->

