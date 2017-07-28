<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.lottery.vo.lotteryresultlistvo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<style type="text/css">
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button{
        -webkit-appearance: none !important;
        margin: 0;
    }
</style>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">

  <div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.lottery_auto['彩票管理']}</span><span>/</span><span>${views.lottery_auto['开奖结果']}</span>
  </div>

  <form:form action="${root}/lotteryResult/list.html" method="post" name="betorderform">
    <form:hidden path="validateRule" />
      <form:hidden path="search.code" id="lotteryCode"></form:hidden>
      <form:hidden path="search.type" id="lotteryType"></form:hidden>
  <div class="col-lg-12">
    <div class="wrapper white-bg shadow">
      <div class="sys_tab_wrap clearfix">
        <div class="m-sm">
            <c:forEach var="lot" items="${lotterys}">
                <soul:button text="${dicts.lottery.lottery[lot.key]}" opType="function" type="${lot.value.type}"
                         target="queryByLottery" code="${lot.key}" cssClass="label ssc-label ${command.search.code==lot.key?'ssc-active':''}" tag="a"></soul:button>
            </c:forEach>
        </div>
      </div>
        <div class="clearfix m-t-md m-b-sm">
            <div class="clearfix col-lg-10" style="padding-left: 0;">

                <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                    <div class="input-group date">
                        <span class="input-group-addon bg-gray">${views.lottery_auto['彩票期号']}</span>
                        <input type="number" class="form-control" placeholder="" name="search.expect">
                    </div>
                </div>
                <div class="form-group clearfix pull-left col-md-5 col-sm-12 m-b-sm padding-r-none-sm" id="query-time-div">
                    <div class="input-group date time-select-a">
                        <span class="input-group-addon bg-gray">${views.lottery_auto['开奖时间']}</span>
                        <gb:dateRange name="search.queryDate" value="${command.search.queryDate}" useToday="true" position="down" btnClass="search"
                            style="width:30%" format="${DateFormat.DAY}" hideQuick="false" callback="query"></gb:dateRange>
                        <%--<gb:dateRange format="${DateFormat.DAY_SECOND}" useToday="true" useRange="true" position="down" btnClass="search"
                                      startName="search.queryStartDate" endName="search.queryEndDate" style="width:38%;"
                                      startDate="${command.search.queryStartDate}" endDate="${command.search.queryEndDate}"/>--%>
                        <soul:button target="queryResultByDate" days="0" text="${views.lottery_auto['今日']}" opType="function" cssClass="btn btn-filter btn-outline"></soul:button>
                        <soul:button target="queryResultByDate" days="-1" text="${views.lottery_auto['昨日']}" opType="function" cssClass="btn btn-filter btn-outline"></soul:button>
                    </div>
                </div>

            </div>
            <div class="col-lg-2">
                <div class="form-group clearfix m-b-none">
                    <soul:button target="query" opType="function" text="" cssClass="btn btn-filter pull-right">
                        <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                    </soul:button>
                </div>
            </div>
        </div>
      <div class="search-list-container">
          <c:if test="${command.search.type=='ssc'}"><%@ include file="sscPartial.jsp" %></c:if>
          <c:if test="${command.search.type=='pk10'}"><%@ include file="pk10Partial.jsp" %></c:if>
          <c:if test="${command.search.type=='lhc'}"><%@ include file="lhcPartial.jsp" %></c:if>
          <c:if test="${command.search.type=='k3'}"><%@ include file="k3Partial.jsp" %></c:if>

      </div>
    </div>
  </div>
  </form:form>
  </div>

  <!--//region your codes 3-->
  <soul:import res="site/lottery/result/Index"/>
  <!--//endregion your codes 3-->