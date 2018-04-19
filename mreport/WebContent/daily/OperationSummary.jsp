<%--
  Created by IntelliJ IDEA.
  User: martin
  Date: 18-4-12
  Time: 下午7:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="run-title">
    <h1 class="float-left">经营走势</h1>
    <div class="group float-right _addPrimary">
        <button type="button" class="btn btn-default">报表呈现</button>
        <button type="button" class="btn btn-default btn-primary">显示数据</button>
        <button type="button" class="btn btn-default">导出数据</button>
    </div>
</div>

<div class="row dataBox1">
    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
        <div class="cont">
            <h2>存取差额 <span>本月:121,696,321.00</span></h2>
            <div class="public-btn-group _addPrimary">
                <button class="btn btn-primary">日</button>
                <button class="btn">周</button>
                <button class="btn">月</button>
            </div>
            <div id="c1"> </div>
            <div id="z1"></div>
        </div>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
        <div class="cont">
            <h2>有效投注 <span>本月:121,696,321.00</span></h2>
            <div class="public-btn-group _addPrimary">
                <button class="btn btn-primary">日</button>
                <button class="btn">周</button>
                <button class="btn">月</button>
            </div>
            <div id="c2"> </div>
            <div id="z2"></div>
        </div>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 list tableCir">
        <div class="cont">
            <h2>损益 <span>本月:121,696,321.00</span></h2>
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
            <h2>损益 <span>本月:121,696,321.00</span></h2>
            <div class="public-btn-group group _addPrimary tableBut">
                <button class="btn btn-primary">存款金额</button>
                <button class="btn">存款人数</button>
            </div>
            <div id="mountNode1" style=" height: 300px; margin: 0 auto"> </div>
        </div>
    </div>
    <div class="col-lg list tableList">
        <div class="cont">
            <h2>损益 <span>本月:121,696,321.00</span></h2>
            <div class="public-btn-group group _addPrimary tableBut">
                <button class="btn btn-primary">新增玩家</button>
                <button class="btn">新增存款玩家</button>
                <button class="btn">活跃玩家</button>
                <button class="btn">投注玩家</button>
                <button class="btn">新增玩家</button>
            </div>
            <div id="mountNode2" style=" height: 300px; margin: 0 auto"></div>
        </div>
    </div>
</div>