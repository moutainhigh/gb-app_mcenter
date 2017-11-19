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
      <ul class="clearfix sys_tab_wrap" id="lotteryDiv">
          <li class="active" data-code="ssclottery" ><a href="javascript:void(0)">时时彩<span class="badge badge-blue m-l-sm">7种</span></a></li>
          <li data-code="k3lottery" ><a href="javascript:void(0)">快3<span class="badge badge-blue m-l-sm">4种</span></a></li>
          <li data-code="pk10lottery" ><a href="javascript:void(0)">PK10<span class="badge badge-blue m-l-sm">3种</span></a></li>
          <li data-code="sfclottery" ><a href="javascript:void(0)">十分彩<span class="badge badge-blue m-l-sm">2种</span></a></li>
          <li data-code="otherlottery" ><a href="javascript:void(0)" >其它<span class="badge badge-blue m-l-sm">5种</span></a></li>
      </ul>
    <div class="wrapper white-bg shadow">
      <div class="sys_tab_wrap clearfix" >
        <div class="m-sm" id="searchDiv">
                <soul:button text="${dicts.lottery.lottery['cqssc']}" type="ssc" code="cqssc" cssClass="label ssc-label ssc-active" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['tjssc']}" type="ssc"  code="tjssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['xjssc']}" type="ssc" code="xjssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['efssc']}" type="ssc" code="efssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['sfssc']}" type="ssc" code="sfssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['wfssc']}" type="ssc" code="wfssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['ffssc']}" type="ssc" code="ffssc" cssClass="label ssc-label" data-code="ssclottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['jsk3']}" type="k3" code="jsk3" cssClass="label ssc-label hide"   data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['hbk3']}" type="k3" code="hbk3" cssClass="label ssc-label hide" data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['ahk3']}" type="k3" code="ahk3" cssClass="label ssc-label hide" data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['gxk3']}" type="k3" code="gxk3" cssClass="label ssc-label hide" data-code="k3lottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['bjpk10']}" type="pk10" code="bjpk10" cssClass="label ssc-label hide" data-code="pk10lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['xyft']}" type="pk10" code="xyft" cssClass="label ssc-label hide" data-code="pk10lottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['jspk10']}" type="pk10"  code="jspk10" cssClass="label ssc-label hide" data-code="pk10lottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['cqxync']}" type="sfc" code="cqxync" cssClass="label ssc-label hide" data-code="sfclottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['gdkl10']}" type="sfc"  code="gdkl10" cssClass="label ssc-label hide" data-code="sfclottery" target="queryByLottery" opType="function" tag="a"></soul:button>

                <soul:button text="${dicts.lottery.lottery['hklhc']}" type="lhc"  code="hklhc" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['xy28']}" type="xy28" code="xy28" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['bjkl8']}"  type="keno" code="bjkl8" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button  text="${dicts.lottery.lottery['fc3d']}" type="pl3" code="fc3d" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>
                <soul:button text="${dicts.lottery.lottery['tcpl3']}" type="pl3"  code="tcpl3" cssClass="label ssc-label hide" data-code="otherlottery" target="queryByLottery" opType="function" tag="a"></soul:button>


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