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
        <% Date date = new Date();%>
        <c:set var="now" value="<%=date%>"/>
        <input type="hidden" id="profilesJson" value='${profilesJson}'/>
        <div class="_drawer-mask"></div>
        <!--内容区域：-->
        <div class="content">
            <div class="run-title">
                <h1 class="float-left">实时总览 <span>更新时间  ${soulFn:formatDateTz(now, DateFormat.DAY_SECOND,timeZone)} 每60分钟/刷新</span></h1>
            </div>
            <div class="dataBox">
                <c:if test="${not empty command.result && command.result.size() > 0}">
                    <c:set var="lastRealtimeProfile" value="${command.result[command.result.size() - 1]}"/>
                    <div class="swiper-container swiper-info">
                        <div class="swiper-wrapper" id="swiper-wrapper">
                            <div class="swiper-slide btn btn-primary" realtimeGroup="visitor">
                                <p class="info-1"><b>实时总访客</b></p>
                                <p class="info-2">${lastRealtimeProfile.countVisitor}</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>
                                    <c:set var="compare" value="${Vo.compareVisitor}"/>
                                    <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}
                                    <c:if test="${compare != 0}">${Vo.getAbs(Vo.compareVisitor)}%</c:if></span>
                                </p>
                            </div>
                            <div class="swiper-slide btn" realtimeGroup="active">
                                <p class="info-1"><b>实时总活跃</b></p>
                                <p class="info-2">${lastRealtimeProfile.countActive}</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>
                                    <c:set var="compare" value="${Vo.compareActive}"/>
                                    <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}
                                    <c:if test="${compare != 0}">${Vo.getAbs(Vo.compareActive)}%</c:if></span>
                                </p>
                            </div>
                            <div class="swiper-slide btn" realtimeGroup="register">
                                <p class="info-1"><b>实时总注册</b></p>
                                <p class="info-2">${lastRealtimeProfile.countRegister}</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>
                                    <c:set var="compare" value="${Vo.compareRegister}"/>
                                    <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}
                                    <c:if test="${compare != 0}">${Vo.getAbs(Vo.compareRegister)}%</c:if></span>
                                </p>
                            </div>
                            <div class="swiper-slide btn" realtimeGroup="effcTransaction">
                                <p class="info-1"><b>实时总投注</b></p>
                                <p class="info-2">${lastRealtimeProfile.countEffcTransaction}</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>
                                    <c:set var="compare" value="${Vo.compareEffcTransaction}"/>
                                    <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}
                                    <c:if test="${compare != 0}">${Vo.getAbs(Vo.compareEffcTransaction)}%</c:if></span>
                                </p>
                            </div>
                            <div class="swiper-slide btn" realtimeGroup="deposit">
                                <p class="info-1"><b>实时总存款</b></p>
                                <p class="info-2">${lastRealtimeProfile.countDeposit}</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>
                                    <c:set var="compare" value="${Vo.compareDeposit}"/>
                                    <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}
                                    <c:if test="${compare != 0}">${Vo.getAbs(Vo.compareDeposit)}%</c:if></span>
                                </p>
                            </div>
                            <div class="swiper-slide btn" realtimeGroup="online">
                                <p class="info-1"><b>实时总在线</b></p>
                                <p class="info-2">${lastRealtimeProfile.countOnline}</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>
                                    <c:set var="compare" value="${Vo.compareOnline}"/>
                                    <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}
                                    <c:if test="${compare != 0}">${Vo.getAbs(Vo.compareOnline)}%</c:if></span>
                                </p>
                            </div>
                            <div class="swiper-slide btn" realtimeGroup="realtimeProfitLoss">
                                <p class="info-1"><b>实时总损益</b></p>
                                <p class="info-2">${lastRealtimeProfile.realtimeProfitLoss}</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>
                                    <c:set var="compare" value="${Vo.compareRealtimeProfitLoss}"/>
                                    <span style="color: ${compare == 0 ? 'blue' : (compare > 0 ? 'red' : 'green')}">${compare == 0 ? '持平' : (compare > 0 ? '↑' : '↓')}
                                    <c:if test="${compare != 0}">${Vo.getAbs(Vo.compareRealtimeProfitLoss)}%</c:if></span>
                                </p>
                            </div>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                    <div id="mountNode"></div>
                    <div id="explainText" style="color:#777;margin-left: 75%;">以日合计 单位(个)</div><br/>
                </c:if>
            </div>
            <!--曲线图-->
            <div class="tableBox">
                <div class="top run-title">
                    <h3>实时报表 </h3><span style="color:#777;margin-left: 10px;margin-right: 65%">显示20天的数据,今日为实时的数据</span>
                    <a class="btn btn-default export" href="#">导出数据</a>
                </div>
                <!--动态生成数据表格-->
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
                    <c:forEach items="${realtimeProfileVos}" var="item" varStatus="i">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${i.index == 0}">
                                        ${soulFn:formatDateTz(now, DateFormat.DAY_SECOND,timeZone)}
                                    </c:when>
                                    <c:otherwise>
                                        ${soulFn:formatDateTz(item.statisticsDate, DateFormat.DAY,timeZone)} 23:59:59
                                    </c:otherwise>
                                </c:choose>
                            </td>
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
                <%--<div class="page">
                    <div class="pageNum"><span class="txt">每页显示</span>
                        <div class="chooseNum _chooseNum show">
                            <div class="dropdown-menu show">
                                <a class="dropdown-item" href="##">10条</a>
                                <a class="dropdown-item" href="##">15条</a>
                                <a class="dropdown-item" href="##">20条</a>
                            </div>
                            <button class="btn btn-default dropdown-toggle" type="button">
                                10条
                            </button>
                        </div>
                        <span class="allCot"></span>
                    </div>
                    <ul class="pagination float-right" id="pagination">
                        <!--动态生成分页器-->
                    </ul>
                </div>--%>
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