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
          <ul class="clearfix sys_tab_wrap" id="lotteryDiv">
              <li class="active" data-code="ssclottery" code="cqssc"><a href="javascript:void(0)">时时彩<span class="badge badge-blue m-l-sm">7种</span></a></li>
              <li data-code="k3lottery" code="jsk3"><a href="javascript:void(0)">快3<span class="badge badge-blue m-l-sm">4种</span></a></li>
              <li data-code="pk10lottery" code="bjpk10"><a href="javascript:void(0)">PK10<span class="badge badge-blue m-l-sm">3种</span></a></li>
              <li data-code="sfclottery" code="cqxync"><a href="javascript:void(0)">十分彩<span class="badge badge-blue m-l-sm">2种</span></a></li>
              <li data-code="otherlottery" code="hklhc"><a href="javascript:void(0)" >其它<span class="badge badge-blue m-l-sm">5种</span></a></li>
          </ul>
      <div class="sys_tab_wrap clearfix" id="searchDiv">
        <div class="m-sm">
                <soul:button text="${dicts.lottery.lottery['cqssc']}" type="cqssc" cssClass="label ssc-label ssc-active" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['tjssc']}"  type="tjssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['xjssc']}" type="xjssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['efssc']}" type="efssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['sfssc']}" type="sfssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['wfssc']}" type="wfssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['ffssc']}" type="ffssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['jsk3']}" type="jsk3" cssClass="label ssc-label hide"   data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['hbk3']}" type="hbk3" cssClass="label ssc-label hide" data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['ahk3']}" type="ahk3" cssClass="label ssc-label hide" data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['gxk3']}" type="gxk3" cssClass="label ssc-label hide" data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['bjpk10']}" type="bjpk10" cssClass="label ssc-label hide" data-code="pk10lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['xyft']}" type="xyft" cssClass="label ssc-label hide" data-code="pk10lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['jspk10']}" type="jspk10" cssClass="label ssc-label hide" data-code="pk10lottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['cqxync']}"  type="cqxync" cssClass="label ssc-label hide" data-code="sfclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['gdkl10']}" type="gdkl10" cssClass="label ssc-label hide" data-code="sfclottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['hklhc']}" type="hklhc" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['xy28']}" type="xy28" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['bjkl8']}" type="bjkl8" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['fc3d']}" type="fc3d" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['tcpl3']}" type="tcpl3" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>

        </div>
      </div>
      <div class="clearfix m-t-md m-b-sm">
        <div class="clearfix col-lg-10" style="padding-left: 0;">
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
            <b>总投注</b>&nbsp;&nbsp;<span class="co-red3" id="betAmount">0</span> 元
            <b class="m-l">总返点</b>&nbsp;&nbsp;<span class="co-red3" id="rabateAmount">0</span>元
            <b class="m-l">总派彩</b>&nbsp;&nbsp;<span class="co-red3" id="payoutAmount">0</span>元
            <b class="m-l">总损益</b>&nbsp;&nbsp;<span class="co-red3" id="profitLoss">0</span>元
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