<%--
  Created by IntelliJ IDEA.
  User: martin
  Date: 18-4-12
  Time: 上午10:53
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo"--%>
<%--@elvariable id="Vo" type="so.wwb.gamebox.model.site.report.vo.RealtimeProfileVo"--%>
<%--@elvariable id="realtimeProfile" type="so.wwb.gamebox.model.site.report.po.RealtimeProfile"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>整体走势-实时统计</title>
</head>
<body>
    <div class="container xinzengwanjia-page">
        <div class="main-content _mainContent">
            <input type="hidden" id="profilesJson" value='${profilesJson}'/>
            <div class="_drawer-mask"></div>
            <!--内容区域：-->
            <div class="content">
                <div class="run-title">
                    <h1 class="float-left">实时总览 <span>更新时间  2017-02-32 23:12:12</span></h1>
                </div>
                <div class="dataBox">
                    <c:if test="${not empty command.result && command.result.size() > 0}">
                        <c:set var="lastRealtimeProfile" value="${command.result[command.result.size() - 1]}"/>
                        <div class="swiper-container swiper-info">
                            <div class="swiper-wrapper" id="swiper-wrapper">
                                <div class="swiper-slide btn-primary" realtimeGroup="visitor">
                                    <p class="info-1"><i class="what">?</i><b>实时总访客</b></p>
                                    <p class="info-2">${lastRealtimeProfile.countVisitor}</p>
                                    <p class="info-3">较昨日同时段</p>
                                    <p class='info-4'>
                                        <c:set var="compare" value="${Vo.compareVisitor}"/>
                                        <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}</span>
                                        ${Vo.getAbs(Vo.compareVisitor)}%
                                    </p>
                                </div>
                                <div class="swiper-slide" realtimeGroup="active">
                                    <p class="info-1"><i class="what">?</i><b>实时总活跃</b></p>
                                    <p class="info-2">${lastRealtimeProfile.countActive}</p>
                                    <p class="info-3">较昨日同时段</p>
                                    <p class='info-4'>
                                        <c:set var="isPositive" value="${Vo.compareActive >= 0 }"/>
                                        <span style="color: ${isPositive ? 'red' : 'green'}">${isPositive ? '↑' : '↓'}</span>
                                        ${Vo.getAbs(Vo.compareActive)}%
                                    </p>
                                </div>
                                <div class="swiper-slide" realtimeGroup="register">
                                    <p class="info-1"><i class="what">?</i><b>实时总注册</b></p>
                                    <p class="info-2">${lastRealtimeProfile.countRegister}</p>
                                    <p class="info-3">较昨日同时段</p>
                                    <p class='info-4'>
                                        <c:set var="isPositive" value="${Vo.compareRegister >= 0 }"/>
                                        <span style="color: ${isPositive ? 'red' : 'green'}">${isPositive ? '↑' : '↓'}</span>
                                        ${Vo.getAbs(Vo.compareRegister)}%
                                    </p>
                                </div>
                                <div class="swiper-slide" realtimeGroup="effcTransaction">
                                    <p class="info-1"><i class="what">?</i><b>实时总投注</b></p>
                                    <p class="info-2">${lastRealtimeProfile.countEffcTransaction}</p>
                                    <p class="info-3">较昨日同时段</p>
                                    <p class='info-4'>
                                        <c:set var="isPositive" value="${Vo.compareEffcTransaction >= 0}"/>
                                        <span style="color: ${isPositive ? 'red' : 'green'}">${isPositive ? '↑' : '↓'}</span>
                                        ${Vo.getAbs(Vo.compareEffcTransaction)}%

                                    </p>
                                </div>
                                <div class="swiper-slide" realtimeGroup="deposit">
                                    <p class="info-1"><i class="what">?</i><b>实时总存款</b></p>
                                    <p class="info-2">${lastRealtimeProfile.countDeposit}</p>
                                    <p class="info-3">较昨日同时段</p>
                                    <p class='info-4'>
                                        <c:set var="isPositive" value="${Vo.compareDeposit >= 0}"/>
                                        <span style="color: ${isPositive ? 'red' : 'green'}">${isPositive ? '↑' : '↓'}</span>
                                            ${Vo.getAbs(Vo.compareDeposit)}%
                                    </p>
                                </div>
                                <div class="swiper-slide" realtimeGroup="online">
                                    <p class="info-1"><i class="what">?</i><b>实时总在线</b></p>
                                    <p class="info-2">${lastRealtimeProfile.countOnline}</p>
                                    <p class="info-3">较昨日同时段</p>
                                    <p class='info-4'>
                                        <c:set var="isPositive" value="${Vo.compareOnline >= 0}"/>
                                        <span style="color: ${isPositive ? 'red' : 'green'}">${isPositive ? '↑' : '↓'}</span>
                                        ${Vo.getAbs(Vo.compareOnline)}%
                                    </p>
                                </div>
                                <div class="swiper-slide" realtimeGroup="realtimeProfitLoss">
                                    <p class="info-1"><i class="what">?</i><b>实时总损益</b></p>
                                    <p class="info-2">${lastRealtimeProfile.realtimeProfitLoss}</p>
                                    <p class="info-3">较昨日同时段</p>
                                    <p class='info-4'>
                                        <c:set var="isPositive" value="${Vo.compareRealtimeProfitLoss >= 0}"/>
                                        <span style="color: ${isPositive ? 'red' : 'green'}">${isPositive ? '↑' : '↓'}</span>
                                        ${Vo.getAbs(Vo.compareRealtimeProfitLoss)}%
                                    </p>
                                </div>
                            </div>
                            <div class="swiper-button-next" ></div>
                            <div class="swiper-button-prev"></div>
                        </div>
                        <div id="mountNode"></div>
                    </c:if>
                </div>
                <!--曲线图-->
                <div class="tableBox">
                    <div class="top">
                        <h3>数据明细</h3>
                        <!--<a class="btn btn-default export" href="#">导出数据</a>-->
                    </div>
                    <!--动态生成数据表格-->

                    <div class="page">
                        <table class="reportTab table-hover" id="Searchresult">
                            <tr>
                                <th>时间</th>
                                <th>实时总访客</th>
                                <th>实时总活跃</th>
                                <th>实时总注册</th>
                                <th>实时总存款</th>
                                <th>实时总投注</th>
                                <th>实时总在线</th>
                                <th>实时总损益</th>
                            </tr>
                            <c:forEach items="${realtimeProfileVos}" var="item" varStatus="index">
                                <tr>
                                    <td>${soulFn:formatDateTz(item.statisticsDate, DateFormat.DAY,timeZone)}</td>
                                    <td>${item.visitorAll}</td>
                                    <td>${item.activeAll}</td>
                                    <td>${item.registerAll}</td>
                                    <td>${item.depositAll}</td>
                                    <td>${item.effcTransactionAll}</td>
                                    <td>${item.onlineAll}</td>
                                    <td>${item.realtimeProfitLossAll}</td>
                                </tr>
                            </c:forEach>
                        </table>
                        <div class="pageNum"><span class="txt">每页显示</span>
                            <div class="chooseNum _chooseNum">
                                <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                    10条
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="choseNum">
                                    <a class="dropdown-item" href="##">10条</a>
                                    <a class="dropdown-item" href="##">15条</a>
                                    <a class="dropdown-item" href="##">20条</a>
                                </div>
                            </div>
                            <span class="allCot"></span>
                        </div>
                        <ul class="pagination float-right" id="pagination">
                            <!--动态生成分页器-->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script>
    curl(['site/daily/RealTimeSummary'], function (RealTimeSummary) {
        page = new RealTimeSummary();
    });
</script>