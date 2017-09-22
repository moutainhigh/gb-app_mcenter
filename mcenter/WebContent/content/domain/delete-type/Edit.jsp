<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-17
  Time: 上午7:07
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttDomainTypeVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form:form action="${root}/content/cttDomain/type/persist.html">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <div class="dashed">
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34">${views.content['项目名称']}：</label>
                <div class="col-xs-9">
                    <div class="input-group date">
                        <%--<input type="text" class="form-control" value="${command.result.name}">--%>
                        <form:input path="result.name" cssClass="form-control"/>
                        <span class="input-group-addon bdn co-red3">&nbsp;&nbsp;<span class="co-red3">*</span></span>
                    </div>
                </div>
            </div>
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right line-hi34">${views.content['指向地址']}：</label>
                <div class="col-xs-9">
                    <div class="input-group date" data-value="${command.result.linkAddress}">
                        <select class="chosen-select-no-single" name="result.linkAddress">
                            <option value="">${views.content['请选择']}</option>
                            <c:forEach items="${command.linkAddress}" var="linkAddress">
                                <option value="${linkAddress}" ${linkAddress eq command.result.linkAddress ?'selected':''}>${linkAddress}</option>
                            </c:forEach>
                        </select>
                        <span class="input-group-addon bdn co-red3">&nbsp;&nbsp;<span class="co-red3">*</span></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <soul:button target="${root}/content/cttDomain/type/persist.html" precall="validateForm" post="getCurrentFormData" callback="closePage" text="${views.content['确认']}" opType="ajax" cssClass="btn btn-filter">${views.content['确认']}</soul:button>
            <%--<button type="button" class="btn btn-filter">${views.delete-content_auto['确认']}</button>--%>
            <soul:button tag="button" target="closePage" text="${views.common_report['取消']}" cssClass="btn btn-outline btn-filter" opType="function"></soul:button>
        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/type/Edit"/>
</html>
