<%--
  Created by IntelliJ IDEA.
  User: martin
  Date: 18-4-12
  Time: 上午10:53
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.site.report.vo.RealtimeProfileListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
       <%@ include file="/include/include.head.jsp" %>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width,height=device-height">
       <title>整体走势-实时统计</title>
       <style>::-webkit-scrollbar{display:none;}html,body{overflow:hidden;height:100%;}</style>
</head>
<body>
    <div class="container xinzengwanjia-page">
        <div class="main-content _mainContent">
            <div class="_drawer-mask"></div>
            <!--内容区域：-->
            <div class="content">
                <div class="run-title">
                    <h1 class="float-left">实时总览 <span>更新时间  2017-02-32 23:12:12</span></h1>
                    <div class="group float-right _addPrimary">
                        <button type="button" class="btn btn-default btn-primary btnTotal">汇总</button>
                        <button type="button" class="btn btn-default btnPc">PC端</button>
                        <button type="button" class="btn btn-default btnCell">手机端</button>
                        <button type="button" class="btn btn-default btnAll">全部</button>
                    </div>
                </div>
                <div class="dataBox">
                    <div class="swiper-container swiper-info">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide btn-primary">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                            <div class="swiper-slide btn">
                                <p class="info-1"><i class="what">?</i><b>访客数</b></p>
                                <p class="info-2">100</p>
                                <p class="info-3">较昨日同时段</p>
                                <p class='info-4'>↓100%</p>
                            </div>
                        </div>
                        <div class="swiper-button-next" ></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                    <div id="mountNode"></div>
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
                            <c:forEach items="${command.result}" var="item" varStatus="index">
                                <tr class="show">
                                    <td>${soulFn:formatDateTz(item.realtimeDate, DateFormat.DAY,timeZone)}</td>
                                    <td>${item.visitorAll}</td>
                                    <td>${item.activeAll}</td>
                                    <td>${item.registerAll}</td>
                                    <td>${item.depositAll}</td>
                                    <td>${item.effcTransactionAll}</td>
                                    <td>${item.onlineAll}</td>
                                    <td>${item.profitAll}</td>
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
<script src="${resRoot}/js/swiper.min.js"></script>
<script>
    $(function(){
        var swiper = new Swiper('.swiper-info', {
            slidesPerView: 6,
            spaceBetween: 15,
            nextButton: '.swiper-button-next',
            prevButton: '.swiper-button-prev',
            //direction: 'vertical',
            //loop: true
        });
    })
</script>
<script>/*Fixing iframe window.innerHeight 0 issue in Safari */document.body.clientHeight;</script>
<script src="https://gw.alipayobjects.com/os/antv/assets/g2/3.0.5-beta.5/g2.min.js"></script>
<script src="https://gw.alipayobjects.com/os/antv/assets/data-set/0.8.6/data-set.min.js"></script>
<script>
    const data = [
        { month: 'Jan', Tokyo: 7.0, London: 3.9,Test: 3.9 },
        { month: 'Feb', Tokyo: 6.9, London: 4.2 ,Test:5.1},
        { month: 'Mar', Tokyo: 9.5, London: 5.7 ,Test:2.9},
        { month: 'Apr', Tokyo: 18.3, London: 8.5 ,Test:10},
        { month: 'May', Tokyo: 18.4, London: 11.9 ,Test:9},
        { month: 'Jun', Tokyo: 21.5, London: 15.2 ,Test:15},
        { month: 'Jul', Tokyo: 25.2, London: 17.0 ,Test:13},
        { month: 'Aug', Tokyo: 26.5, London: 16.6 ,Test:3},
        { month: 'Sep', Tokyo: 23.3, London: 14.2 ,Test:18.3},
        { month: 'Oct', Tokyo: 18.3, London: 10.3 ,Test:8},
        { month: 'Nov', Tokyo: 13.9, London: 6.6 ,Test:18.3},
        { month: 'Dec', Tokyo: 9.6, London: 4.8 ,Test:12.3},
        { month: 'Jan', Tokyo: 7.0, London: 3.9 ,Test:15.6},
        { month: 'Feb', Tokyo: 6.9, London: 4.2 ,Test:18.3},
        { month: 'Mar', Tokyo: 21.5, London: 5.7 ,Test:14.5},
        { month: 'Apr', Tokyo: 14.5, London: 8.5 ,Test:16.3},
        { month: 'May', Tokyo: 18.4, London: 11.9 ,Test:10},
        { month: 'Jun', Tokyo: 21.5, London: 15.2 ,Test:6},
        { month: 'Jul', Tokyo: 25.2, London: 17.0 ,Test:2},
        { month: 'Aug', Tokyo: 26.5, London: 16.6 ,Test:1},
        { month: 'Sep', Tokyo: 23.3, London: 14.2 ,Test:6},
        { month: 'Oct', Tokyo: 18.3, London: 10.3 ,Test:12},
        { month: 'Nov', Tokyo: 13.9, London: 6.6 ,Test:26.5},
        { month: 'Dec', Tokyo: 9.6, London: 4.8 ,Test:26.5}
    ];
    const ds = new DataSet();
    const dv = ds.createView().source(data);
    dv.transform({
        type: 'fold',
        fields: [ 'Tokyo', 'London' ,'Test'], // 展开字段集
        key: 'city', // key字段
        value: 'temperature', // value字段
    });

    const chart = new G2.Chart({
        container: 'mountNode',
        width: 500,
        height: 500
    });
    chart.source(dv, {
        month: {
            range: [ 0, 1 ]
        }
    });
    chart.tooltip({
        crosshairs: {
            type: 'line'
        }
    });
    chart.axis('temperature', {
        label: {
            formatter: val => {
            return val + '°C';
    }
    }
    });
    chart.line().position('month*temperature').color('city',[ 'green', 'red', '#2ca02c' ]).shape('smooth');
    chart.point().position('month*temperature').color('city',[ 'red', 'green', '#2ca02c' ]).size(4).shape('circle').style({
        stroke: '#fff',
        lineWidth: 1
    });
    chart.render();
</script>
<script src="${resRoot}/js/daily/RealTimeSummary.js" type="text/javascript" charset="utf-8"></script>



