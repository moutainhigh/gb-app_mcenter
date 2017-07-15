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
  <input type="hidden" name="result.id" value="${newParam.id}" />
  <c:set var="curPeriod" value="${empty curParam.paramValue ? '1' : curParam.paramValue}" />
  <input type="hidden" name="result.paramValue" value="${curPeriod}" />
  <input type="hidden" name="result.active" value="${true}" />
  <input type="hidden" name="curPeriod" value="${curPeriod }" />
  <input type="hidden" name="newPeriod" value="${newParam.paramValue}" />
  <div class="modal-body">
    <div class="m-b">${views.setting['rakeback.settlement.period.foreword']}</div>
    <hr class="m-t-xs m-b-sm">
    <div class="settlement">
      <b class="m-r-sm">${views.setting['rakeback.settlement.period.monthTime']}:</b>
      <a href="javascript:;" id="1">1${views.setting['rakeback.settlement.period.times']}</a>
      <a href="javascript:;" id="2">2${views.setting['rakeback.settlement.period.times']}</a>
      <a href="javascript:;" id="3">3${views.setting['rakeback.settlement.period.times']}</a>
      <a href="javascript:;" id="4">4${views.setting['rakeback.settlement.period.times']}</a>
      <a href="javascript:;" id="0">${views.setting['rakeback.settlement.period.everyDay.rakeback']}</a>
      <span id="newTip" class="hide"></span>
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-bordered table-hover dataTable m-b-sm td-c" aria-describedby="editable_info">
        <tr class="bg-gray">
          <th colspan="7">${soulFn:formatDateTz(today, DateFormat.YEARMONTH, timeZone)}</th>
        </tr>
        <c:forEach items="${dates}" var="i" varStatus="vs">
          <c:if test="${vs.index%7 == 0}">
          <tr class="bg-color">
          </c:if>
            <td id="${i.type}_${i.value}" class="${(i.type == 'last' || i.type == 'next') ? 'co-grayc2' : ''}">${i.value}</td>
          <c:if test="${vs.index%7 == 6}">
          </tr>
          </c:if>
        </c:forEach>
      </table>
    </div>
    <div class="m-t-xs">
      <span>${views.setting['rakeback.settlement.period.clearDay']}：</span>
      <span id="currDay">${views.setting['rakeback.settlement.period.everyDay']}</span>
      <span style="margin-left: 32px">
        <span>${views.setting_auto['下月结算日期为']}：</span>
        <span id="nextDay"></span>
      </span>
    </div>
  </div>
  <div class="modal-footer">
    <soul:button cssClass="btn btn-filter" text="${views.common.OK}" opType="ajax" target="${root}/setting/vRakebackSet/rakebackPeriod/save.html" dataType="json" post="getCurrentFormData" callback="closePage"/>
    <soul:button cssClass="btn btn-outline btn-filter" target="closePage" opType="function" text="${views.common.cancel}"/>
  </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/setting/rakeback/RakebackPeriod"/>
</html>