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
    <style>::-webkit-scrollbar{display:none;}html,body{overflow:hidden;}</style>
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


</div>

<div style="display: none;" id="lastDifferenceData">${lastDifferenceData}</div>
<script type="text/javascript">
    curl(['site/daily/OperationSummary'], function (OperationSummary) {
        new OperationSummary();
    });
</script>
</body>
</html>
