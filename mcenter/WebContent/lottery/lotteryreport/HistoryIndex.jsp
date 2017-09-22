<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.lottery.vo.LotteryBetOrderListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<style>
    .btnleft {
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
                    <li><a href="/LotteryBetOrderReport/reportlist.html" nav-target="mainFrame">即时报表</a></li>
                    <li class="active"><a href="javascript:void(0)">历史报表</a></li>
                </ul>
                <!--筛选条件-->
                <div class="filter-wraper clearfix m-t-sm p-xs">
                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">年</span>
                            <span class=" input-group-addon bdn  right-btn-down">
                            <div class="btn-group table-desc-right-t-dropdown" initprompt="10条">
                    <button type="button" class="btn btn btn-default right-radius" data-toggle="dropdown"
                            aria-expanded="false">
                        <span prompt="prompt" id="searchYearSpan">请选择</span>
                         <input id="searchYear" type="text" name="search.payout_year" style="display: none">
                        <input  name="searchtype" value="1" style="display: none">
                        <span class="caret-a pull-right"></span>
                    </button>
                     <%--<gb:select name="search.rakebackMonth" list="${years}" value="${command.search.payout_year}"  prompt="-- 年 --" cssClass="btn-group chosen-select-no-single" />--%>
                    <ul class="dropdown-menu lottery-years-down-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation">
                            <a  role="menuitem" tabindex="-1" >请选择</a>
                        </li>
                       <c:forEach var="p" items="${years}" varStatus="status">
                            <li role="presentation">
                            <a  role="menuitem" tabindex="-1" key="${p}">${p}</a>
                        </li>
                       </c:forEach>
                    </ul>
                </div>
                        </span>
                        </div>
                    </div>
                    <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">月</span>
                            <span class=" input-group-addon bdn  right-btn-down">
                            <div class="btn-group table-desc-right-t-dropdown" initprompt="10条" >
                    <button type="button" class="btn btn btn-default right-radius" data-toggle="dropdown" aria-expanded="false">
                        <span prompt="prompt" id="searchMonthSpan">请选择</span>
                         <input id="searchMonth" type="text" name="search.payout_month" style="display: none">
                        <span class="caret-a pull-right"></span>
                    </button>
                    <ul class="dropdown-menu lottery-years-down-menu" role="menu" aria-labelledby="dropdownMenu1">
                         <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="javascript:void(0)">请选择</a>
                        </li>
                      <c:forEach var="i" begin="1" end="12" varStatus="o">
                           <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="javascript:void(0)" key="${i}">${i}</a>
                        </li>
                      </c:forEach>
                    </ul>
                </div>
                        </span>
                        </div>
                    </div>
                    <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                        <div class="input-group">
                            <span class="input-group-addon bg-gray">彩种选择</span>
                            <span class=" input-group-addon bdn right-btn-down">
                            <div class="btn-group table-desc-right-t-dropdown" initprompt="10条" callback="query">
                    <button type="button" class="btn btn btn-default right-radius type-search-btn">
                        <span prompt="prompt" class="tranTypeNum">请选择</span>
                        <span class="caret-a pull-right"></span>
                    </button>

                </div>
                        </span>
                        </div>
                        <div class="type-search type-search-game">
                            <div class="search-top-menu">
                                <soul:button target="allCheck" text="全选" cssClass="btn btn-outline btn-filter"
                                             opType="function" tag="button"/>
                                <soul:button target="clearCheck" text="清空" cssClass="btn btn-outline btn-filter"
                                             opType="function" tag="button"/>
                                <soul:button target="highCheck" text="高频彩" cssClass="btn btn-outline btn-filter"
                                             opType="function" tag="button"/>
                                <soul:button target="lowCheck" text="低频彩" cssClass="btn btn-outline btn-filter"
                                             opType="function" tag="button"/>
                            </div>
                            <div class="m-t">
                                <table class="table table-bordered m-b-xxs" id="checkTable">

                                    <tbody>
                                    <tr>
                                        <td class="bg-gray al-left" style="width: 80px;"><label><span class="m-l-xs"><b>高频彩</b></span></label>
                                        </td>
                                        <td class="al-left" id="highlottery">
                                            <c:forEach var="h" items="${highlottery.result}" varStatus="status">
                                                <label class="m-r-sm"><input type="checkbox" class="i-checks"
                                                                             name="code" value="${h.lotteryCode}"
                                                                             data-code="${h.lotteryCode}"><span
                                                        class="m-l-xs">${dicts.lottery.lottery[h.lotteryCode]}</span></label>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="bg-gray al-left"><label><span
                                                class="m-l-xs"><b>低频彩</b></span></label></td>
                                        <td class="al-left" id="lowlottery">
                                            <c:forEach var="p" items="${lowlottery.result}" varStatus="status">
                                                <label class="m-r-sm"><input type="checkbox" class="i-checks"
                                                                             name="code" value="${p.lotteryCode}"
                                                                             data-code="${p.lotteryCode}"><span
                                                        class="m-l-xs">${dicts.lottery.lottery[p.lotteryCode]}</span></label>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <soul:button target="query" text="" opType="function"
                                 cssClass="btn btn-filter pull-left search_btn btnleft"><i
                            class="fa fa-search"></i>&nbsp;搜索</soul:button>
                </div>

                <div class="search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>

            </div>
        </div>
    </div>

</form:form>


<!--//region your codes 3-->
<soul:import res="site/lottery/lotteryreport/Index"/>
<!--//endregion your codes 3-->