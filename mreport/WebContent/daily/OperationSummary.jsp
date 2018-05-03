<%--
  Created by IntelliJ IDEA.
  User: martin
  Date: 18-4-12
  Time: 下午7:18
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="apiGametypeRelation" type="so.wwb.gamebox.model.company.setting.po.ApiGametypeRelation"--%>
<%--@elvariable id="GameTypeEnum" type="so.wwb.gamebox.model.gameapi.enums.GameTypeEnum"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,height=device-height">
    <title>整体走势-运营日常统计</title>
    <% Date date = new Date();%>
    <% Date lastDate = new Date(date.getTime() - (long)7*24*60*60*1000);%>
    <% Date testerDay = new Date(date.getTime() - (long)1*24*60*60*1000);%>
    <c:set var="now" value="<%=date%>"/>
    <c:set var="lastdate" value="<%=lastDate%>"/>
    <c:set var="yesterDay" value="<%=testerDay%>"/>
</head>
<body>

<div class="run-title">
    <h1 class="float-left">运营日常统计</h1>
    <div class="group float-right _addPrimary">
        <button type="button" class="btn btn-default btn-primary" value="chart">图表呈现</button>
        <button type="button" class="btn btn-default" value="report">报表呈现</button>
    </div>
</div>

<%--图表展示--%>
<div class="gaikuang-page" id="operationChart">
    <div class="row dataBox1">
        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
            <div class="cont">
                <h2>存取差额 <span id="c1_title" class="last-amount"></span></h2>
                <div class="public-btn-group _addPrimary balanceBtn">
                    <button class="btn btn-primary" value="D">日</button>
                    <button class="btn" value="W">周</button>
                    <button class="btn" value="M">月</button>
                </div>
                <div id="c1"></div>
                <div id="z1"></div>
            </div>
        </div>

        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
            <div class="cont">
                <h2>有效投注 <span id="c2_title" class="last-amount"></span></h2>
                <div class="public-btn-group _addPrimary effectiveBtn">
                    <button class="btn btn-primary" value="D">日</button>
                    <button class="btn" value="W">周</button>
                    <button class="btn" value="M">月</button>
                </div>
                <div class="terminal-btn-group _addPrimary effectiveTerminal">
                    <button class="btn btn-primary" value="all">全部</button>
                    <button class="btn" value="phone">手机</button>
                    <button class="btn" value="pc">PC</button>
                </div>
                <div id="c2"></div>
                <div id="z2"></div>
            </div>
        </div>

        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
            <div class="cont">
                <h2>损益 <span id="c3_title" class="last-amount"></span></h2>
                <div class="public-btn-group _addPrimary profitLossBtn">
                    <button class="btn btn-primary" value="D">日</button>
                    <button class="btn" value="W">周</button>
                    <button class="btn" value="M">月</button>
                </div>
                <div id="c3"></div>
                <div id="z3"></div>
            </div>
        </div>
    </div>

    <div class="row dataBox2">
        <div class="col-lg list tableList">
            <div class="cont">
                <div class="range-box">
                    <div class="group public-range-group cycleChangeBtn activeUser" >
                        <button type="button" class="btn btn-default btn-success" statisticsDataType="activeUser" value="D">日</button>
                        <button type="button" class="btn btn-default" statisticsDataType="activeUser" value="W">周</button>
                        <button type="button" class="btn btn-default" statisticsDataType="activeUser" value="M">月</button>
                    </div>
                    <div class="date activeUser">
                        <div class="input-group daterangepickers" >
                            <gb:dateRange format="${DateFormat.DAY}" style="width:80px;" inputStyle="width:80px" useToday="true" useRange="true"
                                          position="down" lastMonth="false" hideQuick="true" opens="true" callback="End"  id="activeUser"
                                          startDate="${lastdate}" endDate="${yesterDay}"  maxDate="${yesterDay}"
                                          startName="activeUser-beginTime" endName="activeUser-endTime" thisMonth="true"/>
                        </div>
                    </div>
                </div>
                <h2>活跃用户</h2>
                <div class="public-btn-group group _addPrimary tableBut active-user">
                    <button class="btn btn-primary active-user" value="active-user">活跃用户</button>
                    <button class="btn login-count" value="login-count">总登录次数</button>
                </div>
                <div id="f4"></div>
            </div>
        </div>

        <div class="col-lg list tableList">
            <div class="cont">
                <div class="range-box">
                    <div class="group public-range-group cycleChangeBtn installAndUninstall" >
                        <button type="button" class="btn btn-default btn-success" statisticsDataType="installAndUninstall" value="D">日</button>
                        <button type="button" class="btn btn-default" statisticsDataType="installAndUninstall" value="W">周</button>
                        <button type="button" class="btn btn-default" statisticsDataType="installAndUninstall" value="M">月</button>
                    </div>
                    <div class="date installAndUninstall">
                        <div class="input-group daterangepickers" >
                            <gb:dateRange format="${DateFormat.DAY}" style="width:80px;" inputStyle="width:80px" useToday="true" useRange="true"
                                          position="down" lastMonth="false" hideQuick="true" opens="true" callback="End"  id="installAndUninstall"
                                          startDate="${lastdate}" endDate="${yesterDay}"  maxDate="${yesterDay}"
                                          startName="installAndUninstall-beginTime" endName="installAndUninstall-endTime" thisMonth="true"/>
                        </div>
                    </div>
                </div>
                <h2>安装量和卸载量 <span></span></h2>
                <div class="public-btn-group group _addPrimary tableBut install">
                    <button class="btn btn-primary install" value="install">安装量</button>
                    <button class="btn uninstall" value="uninstall">卸载量</button>
                </div>
                <div id="i5"></div>
            </div>
        </div>
    </div>

    <div class="row dataBox2">
        <div class="col-lg list tableList">
            <div class="cont">
                <div class="range-box">
                    <div class="group public-range-group cycleChangeBtn playerTrend" >
                        <button type="button" class="btn btn-default btn-success" statisticsDataType="playerTrend" value="D">日</button>
                        <button type="button" class="btn btn-default" statisticsDataType="playerTrend" value="W">周</button>
                        <button type="button" class="btn btn-default" statisticsDataType="playerTrend" value="M">月</button>
                    </div>
                    <div class="date playerTrend">
                        <div class="input-group daterangepickers" >
                            <gb:dateRange format="${DateFormat.DAY}" style="width:80px;" inputStyle="width:80px" useToday="true" useRange="true"
                                          position="down" lastMonth="false" hideQuick="true" opens="true" callback="End"  id="playerTrend"
                                          startDate="${lastdate}" endDate="${yesterDay}"  maxDate="${yesterDay}"
                                          startName="playerTrend-beginTime" endName="playerTrend-endTime" thisMonth="true"/>
                        </div>
                    </div>
                </div>
                <h2>用户走势 <span></span></h2>
                <div class="public-btn-group group _addPrimary tableBut player-trend">
                    <button class="btn btn-primary new-player" value="new-player">新增玩家</button>
                    <button class="btn login-count new-deposit-player" value="new-deposit-player">新增存款玩家</button>
                </div>
                <div id="p6"></div>
            </div>
        </div>

        <div class="col-lg list tableList">
            <div class="cont">
                <div class="range-box">
                    <div class="group public-range-group cycleChangeBtn rakebackTrend" >
                        <button type="button" class="btn btn-default btn-success" statisticsDataType="rakebackTrend" value="D">日</button>
                        <button type="button" class="btn btn-default" statisticsDataType="rakebackTrend" value="W">周</button>
                        <button type="button" class="btn btn-default" statisticsDataType="rakebackTrend" value="M">月</button>
                    </div>
                    <div class="date rakebackTrend">
                        <div class="input-group daterangepickers" >
                            <gb:dateRange format="${DateFormat.DAY}" style="width:80px;" inputStyle="width:80px" useToday="true" useRange="true"
                                          position="down" lastMonth="false" hideQuick="true" opens="true" callback="End"  id="rakebackTrend"
                                          startDate="${lastdate}" endDate="${yesterDay}"  maxDate="${yesterDay}"
                                          startName="rakebackTrend-beginTime" endName="rakebackTrend-endTime" thisMonth="true"/>
                        </div>
                    </div>
                </div>
                <h2>反水走势 <span></span></h2>
                <div class="public-btn-group group _addPrimary tableBut rakeback-trend">
                    <button class="btn btn-primary rakeback-men" value="rakeback-men">反水人数</button>
                    <button class="btn rakeback-cash" value="rakeback-cash">反水金额</button>
                </div>
                <br/>
                <div class="group" id="api-choice" style="display: none;">
                    <button class="btn btn-default btn-primary">API选择</button>
                </div>
                <div id="b7"></div>
            </div>
        </div>
</div>

<%-- 报表展示 --%>
<div class="tableBox" id="operationReport" style="display: none;">
    <div class="top">
        <h3>用户走势</h3>
    </div>
    <table class="reportTab table-hover" id="playerListResult">
        <!--动态生成数据表格-->
    </table>
    <div class="page">
        <div class="pageNum"><span class="txt">每页显示</span>
            <div class="chooseNum _chooseNum">
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                    15条
                </button>
                <div class="dropdown-menu show" aria-labelledby="dropdownMenuButton" id="choseNum">
                    <a class="dropdown-item" href="##">10条</a>
                    <a class="dropdown-item" href="##">15条</a>
                    <a class="dropdown-item" href="##">20条</a>
                </div>
            </div>
            <span class="allCot"></span>
        </div>
        <ul class="pagination float-right" id="playerListPagination">
            <!--动态生成分页器-->
        </ul>
    </div>

    <div class="top">
        <h3>存取走势</h3>
    </div>
    <table class="reportTab table-hover" id="depositWithdrawResult">
        <!--动态生成数据表格-->
    </table>
    <div class="page" id="depositPagination">
        <div class="pageNum"><span class="txt">每页显示</span>
            <div class="chooseNum _chooseNum">
                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                    15条
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="choseNum">
                    <a class="dropdown-item" href="##">10条</a>
                    <a class="dropdown-item" href="##">15条</a>
                    <a class="dropdown-item" href="##">20条</a>
                </div>
            </div>
            <span class="allCot"></span>
        </div>
        <ul class="pagination float-right" id="depositWithdrawPagination">
            <!--动态生成分页器-->
        </ul>
    </div>
</div>
<%--历史运营统计数据--%>
<div style="display: none;" id="operationSummaryDataOfDay">${operationSummaryData}</div>
<div style="display: none;" id="operationSummaryDataOfWeek"></div>
<div style="display: none;" id="operationSummaryDataOfMonth"></div>
<%--返水金额API选择--%>
<div style="display: none;" id="rakebackCashApis">${rakebackCashApis}</div>
</div>
<c:if test="${not empty rakebackCashApis && not empty gameTypes}">
    <div id="mask-api" style="display: none; width: 100%; height: 100%; position: fixed; z-index: 100; left: 0; top: 0;background-color: rgba(0,0,0,0.65);" >
        <div class="api_chose row" id="api_chose" style="position: absolute; z-index: 9999;">
            <button type="button" class="close" aria-label="Close" id="closeAPi"><span aria-hidden="true">&times;</span></button>
            <h5 class="text-center">选择API</h5>
            <form class="check_api">
                <div class="allCheck form-group" id="allCheck">
                    <input type="checkbox" checked="true" id="apiAllCheckInput" /><span>全选</span>
                </div>
                <!--电子-->
                <c:forEach items="${gameTypes}" var="gameType" varStatus="i">
                    <div class="api_box form-group" id="casino_area">
                        <!--type-->
                        <div class="api_tlt form-group">
                            <input type="checkbox" id="casino_checkAll" value="${gameType}"><span>${dicts.game.game_type[gameType]}</span>
                        </div>
                        <!--class-->
                        <c:forEach items="${rakebackCashApis.values()}" var="rakebackApi" varStatus="">
                            <div class="classification form-group clearfix" id="caniso_check">
                                <c:if test="${rakebackApi.gameType eq gameType}">
                                    <div class="pro form-group"><input class="singleAPI" type="checkbox" gameType="${gameType}" value="${rakebackApi.apiId}" /><span>${gbFn:getApiName(rakebackApi.apiId)}</span></div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:forEach>
            </form>
            <!--提交-->
            <div class="sub">
                <button class="btn btn-primary" id="submitApi" type="submit">保存</button>
            </div>

        </div>
    </div>
</c:if>
<script src="${resRoot}/js/jqPaginator.js"></script>
<script type="text/javascript">
    curl(['site/daily/OperationSummary'], function (OperationSummary) {
        new OperationSummary();
    });
</script>
</body>
</html>
