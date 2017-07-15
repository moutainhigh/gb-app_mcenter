<%--
  Created by IntelliJ IDEA.
  User: cj
  Date: 15-9-17
  Time: 上午11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form:form>
  <input type="hidden" name="sysParam[0].id" value="${rebatePeriodNew.id}">
  <input type="hidden" name="sysParam[0].active" value="${true}">
  <input type="hidden" name="sysParam[1].id" value="${agentWithdrawMinParam.id}">
  <input type="hidden" name="sysParam[1].active" value="${true}">
  <input type="hidden" name="sysParam[2].id" value="${agentWithdrawMaxParam.id}">
  <input type="hidden" name="sysParam[2].active" value="${true}">
  <input type="hidden" name="sysParam[0].paramValue" value="${empty rebatePeriodParam.paramValue?'1':rebatePeriodParam.paramValue}">
  <input type="hidden" name="curPeriod" value="${rebatePeriodParam.paramValue}" />
  <input type="hidden" name="newPeriod" value="${rebatePeriodNew.paramValue}" />
  <div class="modal-body">
    <div class="m-b">${views.setting['rakeback.settlement.period.foreword']}</div>
    <div class="settlement">
      <b class="m-r-sm">${views.setting['rebate.settlement.period.monthTime']}:</b>
      <a href="javascript:;" id="1">1${views.setting['rakeback.settlement.period.times']}</a>
      <a href="javascript:;" id="2">2${views.setting['rakeback.settlement.period.times']}</a>
      <a href="javascript:;" id="3">3${views.setting['rakeback.settlement.period.times']}</a>
      <a href="javascript:;" id="4">4${views.setting['rakeback.settlement.period.times']}</a>
      <span id="newTip" class="hide">&nbsp;${views.setting_auto['月结']}&nbsp;<b id="newPeriod" class="co-yellow">${rebatePeriodNew.paramValue}</b>&nbsp;${views.setting_auto['次']}，${views.setting_auto['下个月生效']}</span>
    </div>
    <hr class="m-t-xs m-b-sm">
    <div class="table-responsive">
      <table class="table table-striped table-bordered table-hover dataTable m-b-sm td-c" aria-describedby="editable_info">
        <tr class="bg-gray">
          <th colspan="7">${soulFn:formatDateTz(today, DateFormat.YEARMONTH, timeZone)}</th>
        </tr>
        <c:forEach items="${dates}" var="i" varStatus="vs">
          <c:if test="${vs.index % 7 == 0}">
          <tr class="bg-color">
          </c:if>
            <td id="${i.type}_${i.value}" class="${(i.type == 'last' || i.type == 'next') ? 'co-grayc2' : ''}">${i.value}</td>
          <c:if test="${vs.index % 7 == 6}">
          </tr>
          </c:if>
        </c:forEach>
      </table>
    </div>
    <div class="m-t-xs">
      <span>${views.setting['rakeback.settlement.period.clearDay']}:</span>
      <span id="clearDay">${views.setting['rakeback.settlement.period.everyDay']}</span>
      <span style="margin-left: 32px">
        <span>${views.setting_auto['下月的结算日期为']}:</span>
        <span id="nextDay"></span>
      </span>
    </div>
    <div class="m-t-xs">
      <div class="input-group content-width-limit-400">
        <span class="input-group-addon abroder-no p-x"><b>${views.setting['rebate.settlement.account.singleWithdrawRange']}:&nbsp;</b></span>
        <input type="text" class="form-control" name="sysParam[1].paramValue" value="${agentWithdrawMinParam.paramValue}" placeholder="100">
        <span class="input-group-addon bg-gray">${views.common['TO']}</span>
        <input type="text" class="form-control" name="sysParam[2].paramValue" value="${agentWithdrawMaxParam.paramValue}" placeholder="10,000">
      </div>
    </div>
  </div>
  <div class="modal-footer">
    <soul:button cssClass="btn btn-filter" precall="validateForm" text="${views.common.OK}" opType="ajax" target="${root}/rebateSet/rebatePeriod/save.html" dataType="json" post="getCurrentFormData" callback="saveCallbak"/>
    <soul:button cssClass="btn btn-outline btn-filter" target="closePage" opType="function" text="${views.common.cancel}"/>
  </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/rebate/RebatePeriod"/>
</html>