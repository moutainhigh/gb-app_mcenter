<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--首页-->
<div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i></a></h2>
    <span>${views.home_auto['管理首页']}</span>
</div>

<div class="row">
    <form name="mainFrame">
        <div class="white-bg indicators clearfix  m-l m-r m-b operationsOverview overview shadow">
            <div class="filter-wraper clearfix p-xs">
                <h3 class="pull-left m-r line-hi25">${views.home_auto['近日数据']}</h3>
                <soul:button target="tableModel" text="${views.home_auto['报表模式']}" opType="function" cssClass="btn btn-default chart_model" />
                <soul:button target="chartModel" text="${views.home_auto['图表模式']}" opType="function" cssClass="btn btn-default table_model hide" />
                <label class=" line-hi34 m-l-sm"><input type="checkbox" class="i-checks showData" value="1">${views.home_auto['显示数值']}</label>
                <span class=" line-hi34 m-l-sm co-grayc2">${views.home_auto['更新时间']}：${soulFn:formatDateTz(updateTime, DateFormat.DAY_SECOND, timeZone)}</span>
                <div id="topData" class="pull-right" style="padding-right: 20px">
                    &nbsp;&nbsp;
                    <c:set var="fundTip" value="${views.home_auto['钱包余额']}：${soulFn:formatCurrency(assets.wallet_balance/10000)} ${views.home_auto['万']}<br>API  ${views.home_auto['余额']}：${soulFn:formatCurrency(assets.api_balance/10000)}${views.home_auto['万']}" />
                    <span data-content="${views.home_auto['总资产']}<br>${views.home_auto['钱包余额']}<br>${views.home_auto['API余额']}"
                          class="top-tip" data-placement="bottom" data-trigger="focus" data-container="body" role="button" tabindex="0" data-html="true">
                        <i class="fa fa-question-circle"></i>
                    </span>
                    ${views.home_auto['总资产']}：
                    <span data-content="${fundTip}" class="top-tip" data-placement="bottom" data-trigger="focus" data-container="body" role="button" tabindex="0" data-html="true">
                        <span class="co-tomato">${soulFn:formatCurrency(assets.wallet_balance/10000 + assets.api_balance/10000)}</span>
                    </span> ${views.home_auto['万']}
                    <div style="display: none">${assets.totalAssets} = ${assets.wallet_balance} + ${assets.api_balance} + ${assets.freeze_balance}</div>
                </div>
            </div>
            <div id="stat">
                <div id="chart">
                    <c:import url="include/Chart.jsp" />
                </div>
                <div id="table" style="display: none">
                    <c:import url="include/Table.jsp" />
                </div>
            </div>
        </div>
        <div id="operate" class="white-bg indicators clearfix m operationsOverview overview shadow">
            <!-- 运营状况 -->
        </div>
    </form>
</div>
<div class="hint-box" style="display: none">
    <span class="hint-content">
        <i class="fa fa-exclamation-circle"></i>
        ${views.privilege[subsysCode]}
        <soul:button target="closeHint" cssClass="close" tag="button" text="" opType="function">
            <span aria-hidden="true">×</span>
            <span class="sr-only">${views.home_auto['关闭']}</span>
        </soul:button>
    </span>
</div>
<soul:import res="site/home/Index" />

