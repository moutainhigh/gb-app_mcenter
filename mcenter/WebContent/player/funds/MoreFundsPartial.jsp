<%@ page import="so.wwb.gamebox.model.master.player.po.PlayerTransaction" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerTransactionListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="poType" value="<%= PlayerTransaction.class %>"></c:set>
<!--资金查看更多-->
<div class="form-group over clearfix m-b-n-xs">
  <input type="hidden" name="playerId" value="${command.search.playerId}"/>
  <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
    <thead>
    <tr>
      <th>${views.column['PlayerTransaction.transactionNo']}</th>
      <soul:orderColumn poType="${poType}" property="transaction.result.createTime" column="${views.column['PlayerTransaction.createTime']}"/>
      <th> ${views.column['PlayerTransaction.transactionType']}</th>
      <soul:orderColumn poType="${poType}" property="transaction.result.transactionMoney" column="${views.column['PlayerTransaction.transactionMoney']}"/>
      <th>${views.column['PlayerTransaction.status']}</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${command.result}" var="i" varStatus="status">
      <tr>
      <td>${i.transactionNo}</td>
      <td>${soulFn:formatDateTz(i.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
      <td>
        <div>${dicts.common.transaction_type[i.transactionType]}</div>
        <span class="co-gray9">${i.remark}</span>
      </td>
      <td class="co-green" <c:if test="${i.transactionMoney>0}">co-green</c:if>
      <c:if test="${i.transactionMoney<0}">co-red</c:if>>
        ${i.transactionMoney}
      </td>
      <td  <c:if test="${i.status=='failure'}"> class="co-red" data-toggle="tooltip" data-placement="left" title="${i.failureReason}"</c:if>
      <c:if test="${i.status=='success'}"> class="co-green"</c:if>>
         ${dicts.common.status[i.status]}
      </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
<soul:pagination mode="mini"/>
