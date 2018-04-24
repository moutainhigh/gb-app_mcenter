<%--
  Created by IntelliJ IDEA.
  User: martin
  Date: 18-4-12
  Time: 下午7:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,height=device-height">
    <title>整体走势-运营日常统计</title>
</head>
<body>

<div class="gaikuang-page">
    <div class="run-title">
        <h1 class="float-left">运营日常统计</h1>
        <div class="group float-right _addPrimary">
            <button type="button" class="btn btn-default">报表呈现</button>
            <button type="button" class="btn btn-default btn-primary">显示数据</button>
        </div>
    </div>

    <div class="row dataBox1">
        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
            <div class="cont">
                <h2>存取差额 <span>4月16日:${lastDifferenceAmount}</span></h2>
                <div class="public-btn-group _addPrimary">
                    <button class="btn btn-primary">日</button>
                    <button class="btn">周</button>
                    <button class="btn">月</button>
                </div>
                <div id="c1"></div>
                <div id="z1"></div>
            </div>
        </div>

        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
            <div class="cont">
                <h2>有效投注 <span>4月16日:${lastDifferenceAmount}</span></h2>
                <div class="public-btn-group _addPrimary">
                    <button class="btn btn-primary">日</button>
                    <button class="btn">周</button>
                    <button class="btn">月</button>
                </div>
                <div id="c2"></div>
                <div id="z2"></div>
            </div>
        </div>

        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
            <div class="cont">
                <h2>损益 <span>4月16日:${lastDifferenceAmount}</span></h2>
                <div class="public-btn-group _addPrimary">
                    <button class="btn btn-primary">日</button>
                    <button class="btn">周</button>
                    <button class="btn">月</button>
                </div>
                <div id="c3"></div>
                <div id="z3"></div>
            </div>
        </div>
    </div>

    <div class="row dataBox2">
        <div class="col-lg list tableList">
            <div class="cont">
                <h2>活跃用户和登录次数 <span>本月:121,696,321.00</span></h2>
                <div class="public-btn-group group _addPrimary tableBut active-user">
                    <button class="btn btn-primary active-user">活跃用户</button>
                    <button class="btn login-count">总登录次数</button>
                </div>
                <div id="f4"></div>
            </div>
        </div>
        <div class="col-lg list tableList">
            <div class="cont">
                <h2>安装量和卸载量 <span>本月:121,696,321.00</span></h2>
                <div class="public-btn-group group _addPrimary tableBut install">
                    <button class="btn btn-primary install">安装量</button>
                    <button class="btn uninstall">卸载量</button>
                </div>
                <div id="i5"></div>
            </div>
        </div>
    </div>

    <div class="row dataBox2">
        <div class="col-lg list tableList">
            <div class="cont">
                <h2>用户走势 <span>本月:121,696,321.00</span></h2>
                <div class="public-btn-group group _addPrimary tableBut player-trend">
                    <button class="btn btn-primary new-player">新增玩家</button>
                    <button class="btn login-count new-deposit-player">新增存款玩家</button>
                </div>
                <div id="p6"></div>
            </div>
        </div>
        <div class="col-lg list tableList">
            <div class="cont">
                <h2>反水走势 <span>本月:121,696,321.00</span></h2>
                <div class="public-btn-group group _addPrimary tableBut rakeback-trend">
                    <button class="btn btn-primary rakeback-men">反水人数</button>
                    <button class="btn rakeback-cash">反水金额</button>
                </div>
                <br/>
                <div class="group" id="api-choice" style="display: none;">
                    <button class="btn btn-default btn-primary">API选择</button>
                </div>
                <div id="b7"></div>
            </div>
        </div>
    </div>
</div>
<%--存款差额仪表图数据--%>
<div style="display: none;" id="balanceGaugeChartData">${balanceGaugeChartData}</div>
<%--有效投注额仪表图数据--%>
<div style="display: none;" id="effectiveGaugeChartData">${effectiveGaugeChartData}</div>
<%--损益仪表图数据--%>
<div style="display: none;" id="profitLossGaugeChartData">${profitLossGaugeChartData}</div>
<%--历史运营统计数据--%>
<div style="display: none;" id="operationSummaryData">${operationSummaryData}</div>
<%--返水金额API选择--%>
<div style="display: none;" id="rakebackCashApis">${rakebackCashApis}</div>
<script type="text/javascript">
    curl(['site/daily/OperationSummary'], function (OperationSummary) {
        new OperationSummary();
    });
</script>
</body>
</html>
