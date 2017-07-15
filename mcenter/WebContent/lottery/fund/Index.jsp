<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryTransactionListVo"--%>
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
    <span>${views.lottery_auto['彩票管理']}</span><span>/</span><span>${views.lottery_auto['资金记录']}</span>
  </div>

  <form:form action="${root}/lotteryTransaction/list.html" method="post" name="betorderform">
    <form:hidden path="validateRule" />
  <div class="col-lg-12">
    <div class="wrapper white-bg shadow">
      <div class="clearfix m-t-md m-b-sm">
        <div class="clearfix col-lg-10" style="padding-left: 0;">
            <div class="form-group clearfix pull-left col-md-5 col-sm-12 m-b-sm padding-r-none-sm">
                <div class="input-group date time-select-a">
                    <span class="input-group-addon bg-gray">${views.lottery_auto['时间']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" useToday="true" useRange="true" position="down" btnClass="search"
                                  startName="search.queryStartDate" endName="search.queryEndDate" style="width:38%;"
                                  startDate="${command.search.queryStartDate}" endDate="${command.search.queryEndDate}"/>
                </div>
            </div>
            <div class="input-group date time-select-a">
                <span class="input-group-addon bg-gray">${views.fund['玩家账号']}</span>
                <input name="search.username" style="width: 200px;" class="form-control" id="search_username">
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
        <%@ include file="IndexPartial.jsp" %>
      </div>
    </div>
  </div>
  </form:form>
  </div>

  <!--//region your codes 3-->
  <soul:import res="site/lottery/fund/Index"/>
  <!--//endregion your codes 3-->