<%--@elvariable id="command" type="org.soul.model.sys.po.SysParam"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.content['充值中心']}</title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form name="editUrl" method="post">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <div class="modal-body">
        <div class="clearfix bg-gray p-t-xxs p-b-xxs m-b-md al-center">
                	<span class="co-orange fs36 m-l-n-md modal-alert-icon">
                    <i class="fa fa-exclamation-circle"></i>
                </span>
            <div class="line-hi25 m-l-md al-left modal-alert-text">
                    ${views.content['添加后，将在玩家中心存款页面显示“充值中心”入口;']}<br>${views.content['玩家点击入口后，将跳转至快速充值页面进行存款;']}</div>
        </div>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3 al-right line-hi34">${views.content['快速充值页面链接']}</label>
            <div class="col-xs-8 p-x">
                <input name="paramValue" class="form-control m-b" value="${command.paramValue}" type="text" placeholder="${views.content_auto['请输入有效的url地址']}"/>
            </div>
        </div>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3  al-right line-hi34">${views.content['使用层级:']}</label>
            <div class="col-xs-8 p-x p-xxs">
                <label class="">
                    <input name="allRank" class="check-box" ${allRank.paramValue eq 'true'?'checked':''} value="true" type="checkbox"/>
                        ${views.content['全部层级']}
                </label>
                <button type="button" class="btn btn-outline btn-filter btn-xs" data-type="clear" name="clearRank" style="margin-right: 10px;">清空</button>
                <div>
                    <c:set var="rs" value="${fn:split(ranksParam.paramValue, ',')}"/>
                    <c:forEach var="r" items="${ranks}">
                        <label class="">
                            <c:set var="c" value=""/>
                            <c:forEach items="${rs}" var="i">
                                <c:if test="${i eq r['id']}">
                                    <c:set var="c" value="checked"/>
                                </c:if>
                            </c:forEach>
                            <input name="rank" ${c} value="${r['id']}" class="check-box" type="checkbox"/>
                            ${r['rankName']}
                        </label>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/payAccount/saveRechargeUrl.html" post="getCurrentFormData" text="" opType="ajax" dataType="json" cssClass="btn btn-filter" callback="saveCallbak" tag="button">${views.common['confirm']}</soul:button>
        <soul:button cssClass="btn btn-outline btn-filter" target="closePage" text="${views.common_report['取消']}" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/payaccount/RechargeUrl"/>
<!--//endregion your codes 4-->
</html>