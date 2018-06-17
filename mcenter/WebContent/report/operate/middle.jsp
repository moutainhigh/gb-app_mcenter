<%--@elvariable id="command" type="so.wwb.gamebox.model.master.report.vo.OperatePlayerListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="col-lg-12 filterBox">
    <div class="wrapper clearfix">

        <div class="operate-btn shadow clearfix filter hide" style="margin: 0; border-top:0">
            <span>
                <label class="ft-bold line-hi34 al-right">${views.report['operate.search.filter']}</label>
                <soul:button target="fBox.checkAll" text="${views.report['operate.search.all']}" opType="function" cssClass="btn btn-filter btn-outline all"/>
                <soul:button target="fBox.clearAll" text="${views.report['operate.search.clear']}" opType="function" cssClass="btn btn-filter btn-outline"/>
            </span>
            <input type="hidden" name="selAll" value="${command.selAll == null ? 0 : command.selAll}" /> <!-- 选择全部1, 否则0 -->
            <span class="dividing-line m-r-xs m-l-xs">|</span>
            <span class="btn_api"><%-- API 区 --%></span>
            <span class="dividing-line m-r-xs m-l-xs">|</span>
            <span class="btn_api_type"><%-- API Type 区 --%></span>
            <soul:button target="fBox.filterBox" text="${views.report['operate.search.more']}" opType="function" cssClass="more" title="${views.report['operate.search.box.title']}"/>
        </div>

        <div class="hide apiHide"><%-- 隐藏的选择 --%></div>
        <div class="hide apiTypeListHide"><%-- 隐藏的选择 --%></div>
        <div class="sys_tab_wrap shadow m-t clearfix" style="border-bottom: 0; border-top:1px solid #e6e6e6; margin-bottom: -5px;">
            <div class=" clearfix m-sm">
                <b>${views.report['operate.list.select']}</b>
                <span class="co-yellow m-l-sm choose">${views.report['operate.list.all']}</span>
                <%-- 导出部分 --%>
                <%--<div class="pull-right m-t-n-xxs">
                    <soul:button tag="button" cssClass="btn btn-primary-hide" callback="toExportHistory"
                                 text="${views.report['fund.list.export']}" precall="validateData" title="${views.report['fund.list.export']}"
                                 target="${root}/report/operate/exportRecords.html?subSysCode=${subSysCode}&result.siteId=${command.search.siteId}" opType="dialog">
                        <i class="fa fa-sign-out"></i><span class="hd">${views.report['operate.list.export']}</span>
                    </soul:button>
                    <a href="/share/exports/exportHistoryList.html" nav-target="mainFrame" class="hide" id="toExportHistory"></a>
                </div>
                <input type="hidden" value="${conditionJson}" id="conditionJson">
                <input type="hidden" value="${subSysCode}" id="subSysCode">--%>
            </div>
        </div>
        <%-- 筛选弹框开始 --%>
        <div id="filterBox" class="hide">
            <div class="boxFilter" style="padding:5px; line-height: 20px">
                <button onclick="page.fBox.popCheckAll(this)" class="btn btn-outline btn-filter btn-xs all">${views.report['operate.search.all']}</button>
                <button onclick="page.fBox.popClearAll(this)" class="btn btn-outline btn-filter btn-xs m-l-xs m-r">${views.report['operate.search.clear']}</button>
                <input type="hidden" name="boxAll" value="${command.selAll == null ? 0 : command.selAll}"/>
                <input type="hidden" name="clrAll" value="0"/>
                <span class="box_api"><%-- API --%></span>
                <span class="dividing-line m-r-xs m-l-xs">|</span>
                <span class="box_api_type"><%-- API Type --%></span>
            </div>
            <div class="table-responsive" style="overflow: auto;height: 480px">
                <table class="table table-bordered m-b-xxs">
                    <tbody class="box_game_type"><%-- API & GameType --%></tbody>
                </table>
            </div>
        </div>
        <%-- 筛选弹框结束 --%>
    </div>
</div>