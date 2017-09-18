<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryBetOrderListVo"--%>
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
    <span>${views.lottery_auto['彩票管理']}</span><span>/</span><span>${views.lottery_auto['即时注单']}</span>
  </div>

  <form:form action="${root}/lotteryBetOrder/list.html" method="post" name="betorderform">
    <form:hidden path="validateRule" />
      <form:hidden path="search.code" id="lotteryType"></form:hidden>
  <div class="col-lg-12">
    <div class="wrapper white-bg shadow">
      <div class="sys_tab_wrap clearfix">
        <div class="m-sm">
            <c:forEach var="lot" items="${lotterys}">
                <soul:button text="${dicts.lottery.lottery[lot.code]}" opType="function"
                         target="queryByLottery" type="${lot.code}" cssClass="label ssc-label ${command.search.code==lot.code?'ssc-active':''}" tag="a"></soul:button>
            </c:forEach>

        </div>
      </div>
      <div class="clearfix m-t-md m-b-sm">
        <div class="clearfix col-lg-10" style="padding-left: 0;">
            <%--<div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.lottery_auto['注单状态']}</span>
                <span class=" input-group-addon bdn  right-btn-down">
                    <gb:select name="search.status" cssClass="btn-group chosen-select-no-single" prompt="${views.common['all']}"
                               list="${orderStatus}" value="${command.search.status}" callback="query"/>
                </span>
                </div>
            </div>--%>
          <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
            <div class="input-group date">
              <span class="input-group-addon bg-gray">${views.lottery_auto['投注帐号']}</span>
              <input type="text" class="form-control" placeholder="" name="search.username">
            </div>
          </div>
        <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
            <div class="input-group date">
                <span class="input-group-addon bg-gray">${views.lottery_auto['注单号']}</span>
                <input type="number" class="form-control" placeholder="" name="search.id">
            </div>
        </div>
        <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
            <div class="input-group date">
                <span class="input-group-addon bg-gray">${views.lottery_auto['彩票期号']}</span>
                <input type="text" class="form-control" placeholder="" name="search.expect">
            </div>
        </div>
            <div class="form-group clearfix pull-left col-md-5 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group date time-select-a">
                    <span class="input-group-addon bg-gray">${views.lottery_auto['时间']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" useToday="true" useRange="true" position="down" btnClass="search"
                                  startName="search.queryStartDate" endName="search.queryEndDate" style="width:38%;"
                                  startDate="${command.search.queryStartDate}" endDate="${command.search.queryEndDate}"/>
                </div>
            </div>

        </div>
        <div class="col-lg-2">
            <div class="form-group clearfix m-b-none">
                <soul:button target="query" opType="function" text="" cssClass="btn btn-filter pull-right btn-search-css">
                    <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                </soul:button>
            </div>
        </div>
      </div>
        <div class="p-sm">
            <b>${views.lottery_auto['投注总金额']}：</b><span class="co-red3" id="betAmount">0</span> ${views.lottery_auto['元']}
            <b class="m-l">${views.lottery_auto['派彩总金额']}：</b><span class="co-red3" id="payoutAmount">0</span>${views.lottery_auto['元']}
            <b class="m-l">${views.lottery_auto['赢利总金额']}：</b><span class="co-red3" id="profitLoss">0</span>${views.lottery_auto['元']}
        </div>
      <div class="search-list-container">
        <%@ include file="IndexPartial.jsp" %>
      </div>
    </div>
  </div>
  </form:form>
  </div>

  <!--//region your codes 3-->
  <soul:import res="site/lottery/lotteryorder/Index"/>
  <!--//endregion your codes 3-->