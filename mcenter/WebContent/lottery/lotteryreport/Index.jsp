<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryBetOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<style>
    .btnleft{
        margin-left: 20px;
    }
</style>
<!--//endregion your codes 1-->
<form:form action="${root}/LotteryBetOrderReport/reportlist.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>彩票管理</span>
            <span>/</span><span>报表</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <ul class="clearfix sys_tab_wrap">
                    <li class="active"><a href="javascript:void(0)">即时报表</a></li>
                    <li><a href="/LotteryBetOrderReport/reportlist.html?searchtype=1" nav-target="mainFrame">历史报表</a></li>
                </ul>
                <!--筛选条件-->
                <div class="filter-wraper clearfix m-t-sm p-xs" id="searchDiv">
                    <soul:button target="changeTime" data="0" text="今天" cssClass="filterbtn btn btn-filter btn-outline m-r-xs active" opType="function" tag="button"/>
                    <soul:button target="changeTime" data="1" text="昨天" cssClass="filterbtn btn btn-filter btn-outline m-r-xs" opType="function" tag="button"/>
                    <soul:button target="changeTime" data="2" text="本周" cssClass="filterbtn btn btn-filter btn-outline m-r-xs" opType="function" tag="button"/>
                    <soul:button target="changeTime" data="3" text="本月" cssClass="filterbtn btn btn-filter btn-outline m-r-xs" opType="function" tag="button"/>
                    <input id="searchDate" name="searchDate" value="0" style="display: none">
                    <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-l-n m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">彩种选择</span>
                            <span class=" input-group-addon bdn right-btn-down">
                            <div class="btn-group table-desc-right-t-dropdown" initprompt="10条" callback="query">
                    <button type="button" class="btn btn btn-default right-radius type-search-btn">
                        <span prompt="prompt">请选择</span>
                        <span class="caret-a pull-right"></span>
                    </button>

                </div>
                        </span>
                        </div>
                        <div class="type-search type-search-game">
                            <div class="search-top-menus">
                                <soul:button target="allCheck" text="全选" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
                                <soul:button target="clearCheck" text="清空" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
                                <soul:button target="highCheck" text="高频彩" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
                                <soul:button target="lowCheck" text="低频彩" cssClass="btn btn-outline btn-filter" opType="function" tag="button"/>
                            </div>

                            <div class="m-t">
                                <table class="table table-bordered m-b-xxs">

                                    <tbody><tr>
                                        <td class="bg-gray al-left" style="width: 80px;"><label><span class="m-l-xs"><b>高频彩</b></span></label></td>
                                        <td class="al-left" id="highlottery">
                                            <c:forEach var="h" items="${highlottery.result}" varStatus="status">
                                                <label class="m-r-sm"><input type="checkbox" class="i-checks" name="code"  value="${h.lotteryCode}"  data-code="${h.lotteryCode}"><span class="m-l-xs">${dicts.lottery.lottery[h.lotteryCode]}</span></label>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="bg-gray al-left"><label><span class="m-l-xs"><b>低频彩</b></span></label></td>
                                        <td class="al-left" id="lowlottery">
                                            <c:forEach var="p" items="${lowlottery.result}" varStatus="status">
                                                <label class="m-r-sm"><input type="checkbox" class="i-checks" name="code"  value="${p.lotteryCode}" data-code="${p.lotteryCode}"><span class="m-l-xs">${dicts.lottery.lottery[p.lotteryCode]}</span></label>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <soul:button target="query" text="" opType="function" cssClass="btn btn-filter pull-left search_btn btnleft"><i class="fa fa-search"></i>&nbsp;搜索</soul:button>
                </div>
                <div class="clearfix m-b bg-gray p-t-xs p-l-sm p-r-sm">
                    <span class="co-orange fs36 line-hi25 pull-left m-r-sm">
                        <i class="fa fa-exclamation-circle m-t-n-sm"></i>
                    </span>
                    <div class="line-hi25 pull-left m-b-sm">此报表只统计已开奖结算的订单，未开奖订单不做统计。</div>
                </div>
    <div class="search-list-container">
                <%@ include file="IndexPartial.jsp" %>
    </div>
                    </div>
        </div>
                </div>
            </div>
        </div>
    </div>
</form:form>


<!--//region your codes 3-->
<soul:import res="site/lottery/lotteryreport/Index"/>
<!--//endregion your codes 3-->