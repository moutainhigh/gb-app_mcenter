<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.VPlayerTransactionVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<form:form  action="" method="post">
<div class="row">
  <div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.sysResource['统计']}</span>
    <span>/</span>
    <span>${views.sysResource['资金记录']}</span>
    <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
      <em class="fa fa-caret-left"></em>${views.common['return']}
    </soul:button>
    <!--        <a href="javascript:void(0)" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.report_auto['返回']}</a>-->
    <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
  </div>
  <c:set value="" var="_symbol"></c:set>
  <c:set value="" var="_desc"></c:set>
  <c:choose>
    <c:when test="${command.result.transactionType eq 'favorable'}">
      <%--优惠--%>
      <c:set value="+" var="_symbol"></c:set>
      <c:set value="${dicts.common.transaction_way[command.result._describe['favorableType']]}" var="_desc"></c:set>
    </c:when>
    <c:when test="${command.result.transactionType eq 'deposit'}">
      <%-- 存款 --%>
      <c:set value="+" var="_symbol"></c:set>
      <c:set value="${dicts.common.fund_type[command.result.fundType]}-${dicts.common.bankname[command.result._describe['bankCode']]}" var="_desc"></c:set>
    </c:when>
    <c:when test="${command.result.transactionType eq 'withdrawals'}">
      <%-- 取款 --%>
      <c:set value="${dicts.common.bankname[command.result._describe['bankCode']]} ${views.fund['transaction.list.bankNoAfter']}${fn:substring(command.result._describe['bankNo'],14,18)}" var="_desc"></c:set>
    </c:when>
    <c:when test="${command.result.transactionType eq 'transfers'}">
      <%--转账:转入 转出 --%>
      <c:choose>
        <c:when test="${command.result.fundType eq 'transfer_into'}">
          <c:set value="+" var="_symbol"></c:set>
          <c:set value="${gbFn:getSiteApiName(command.result._describe['API'].toString())}${views.fund['transaction.list.transferInto']}" var="_desc"></c:set>
          <%--转入--%>
        </c:when>
        <c:when test="${command.result.fundType eq 'transfer_out'}">
          <c:set value="${views.fund['transaction.list.transferOut']}${gbFn:getSiteApiName(command.result._describe['API'].toString())}" var="_desc"></c:set>
          <%--转出--%>
        </c:when>
      </c:choose>
    </c:when>
    <c:when test="${command.result.transactionType eq 'backwater'}">
      <%--返水--%>
      <c:set value="+" var="_symbol"></c:set>
      <c:set value="${command.result._describe['date']} ${command.result._describe['period']}${views.fund['transaction.list.period']}" var="_desc"></c:set>
    </c:when>
    <c:when test="${command.result.transactionType eq 'recommend'}">
      <%--推荐--%>
      <c:set value="+" var="_symbol"></c:set>
      <c:set value="${views.fund['transaction.list.friend']} ${command.result._describe['username']}" var="_desc"></c:set>
    </c:when>
  </c:choose>

  <c:choose>
    <c:when test="${command.result.transactionType eq 'backwater'}">
      <%--返水--%>
      <%@ include file="views/BackwaterView.jsp" %>
    </c:when>
    <c:when test="${command.result.transactionType eq 'favorable'}">
      <%--优惠--%>
      <%@ include file="views/FavorableView.jsp" %>
    </c:when>
    <c:when test="${command.result.transactionType eq 'transfers'}">
      <%--额度转换 --%>
      <%@ include file="views/TransfersView.jsp" %>
    </c:when>
    <c:when test="${command.result.transactionType eq 'recommend'}">
      <%--推荐 --%>
      <%@ include file="views/RecommendView.jsp" %>
    </c:when>
  </c:choose>

</div>
  </form:form>
<soul:import res="site/report/fund/views"/>
<!--//endregion your codes 1-->