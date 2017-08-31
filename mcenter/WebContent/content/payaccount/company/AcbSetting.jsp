<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.PayAccountVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<html lang="zh-CN">
<head>
    <title>${views.content_auto['充值中心']}</title>
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
            <div class="line-hi25 m-l-md  modal-alert-text">
                    ${views.content_auto['添加后']}<br>${views.content_auto['玩家点击入口后']}</div>
        </div>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3 al-right line-hi34">${views.content_auto['上分系统KEY值']}</label>
            <div class="col-xs-8 p-x">
                <input type="hidden" name="result.id" value="${command.payKeyParam.id}"/>
                <input name="result.paramValue" class="form-control m-b" value="${command.payKeyParam.paramValue}" type="text" placeholder="${views.content_auto['请输入KEY值']}"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/payAccount/saveAcbSetting.html" post="getCurrentFormData" text="" opType="ajax" dataType="json" cssClass="btn btn-filter" callback="saveCallbak" tag="button">${views.common['confirm']}</soul:button>
        <soul:button cssClass="btn btn-outline btn-filter" target="closePage" text="取消" opType="function"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/content/payaccount/AcbSetting"/>
<!--//endregion your codes 4-->
</html>