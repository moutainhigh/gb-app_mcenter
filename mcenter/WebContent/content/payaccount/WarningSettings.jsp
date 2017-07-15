<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-14
  Time: 下午2:10
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.SysDomainVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form id="editForm">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <gb:token/>
    <div class="modal-body">
        <%--<div class="form-group clearfix isDefault">--%>
            <%--<input name="inadequateState.paramValue" value="${inadequateState.paramValue}" hidden>--%>
            <%--<input name="inadequateState.id" value="${inadequateState.id}" hidden>--%>
            <%--<label class="col-xs-4 al-right" >${views.content_auto['层级账户不足提醒方式']}：</label>--%>
            <%--<div class="col-xs-6">--%>
                <%--<label><input type="checkbox" ${inadequateState.paramValue == 'true'?'checked':''}>${views.content_auto['弹窗']}</label>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="form-group clearfix">
            <input name="inadequateCount.id" value="${inadequateCount.id}" hidden>
            <label class="col-xs-4 al-right line-hi34">${views.content['不足个数：']}</label>
            <div class="col-xs-8">
                <input class="form-control m-b-xs" name="inadequateCount.paramValue" value="${inadequateCount.paramValue}"/>
                <div class="co-grayc2">${views.content['当某层级状态为“使用中”的收款账户不足设置的值时，系统将进行弹窗提醒！']}<b>${views.content['建议设置为“2”']}</b></div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <soul:button target="${root}/payAccount/saveWarningSettings.html" post="getCurrentFormData" precall="validateForm" text="" opType="ajax" dataType="json" cssClass="btn btn-filter" callback="saveCallbak" tag="button">${views.common['confirm']}</soul:button>
        <soul:button target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter" tag="button">${views.common['cancel']}</soul:button>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/payaccount/WarningSettings"/>
</html>
