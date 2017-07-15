<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VPlayerGameOrderVo"--%>

<form:form id="editForm" action="" method="post">
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.sysResource['投注记录']}</span>
            <!--        <a href="javascript:void(0)" nav-target="mainFrame" class="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn"><em class="fa fa-caret-left"></em>${views.report_auto['返回']}</a>-->
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="sys_tab_wrap clearfix">
                    <b class="m-l">${views.report_auto['投注记录详细']}</b>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['玩家账号']}：</label>
                    <div class="col-sm-5 co-blue3">${command.result.username}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['游戏供应商']}：</label>
                    <div class="col-sm-5">QQ</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['游戏种类']}：</label>
                    <div class="col-sm-5">QQ &gt;&gt;${views.report_auto['百家乐']}</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['交易时间']}：</label>
                    <div class="col-sm-5">2015-08-06 04:22:15</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['交易量']}：</label>
                    <div class="col-sm-5">21,922.00</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['派彩时间']}：</label>
                    <div class="col-sm-5">2015-08-06 04:22:15</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['派彩']}：</label>
                    <div class="col-sm-5"><span class="co-red">-2.85</span></div>
                </div>
                <!--
                            <div class="clearfix m-l-lg line-hi34">
                                <label class="ft-bold col-sm-3 al-right">${views.report_auto['发送形式']}：</label>
                                <div class="col-sm-5 co-red3">-2.85</div>
                            </div>
                -->
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['有效交易量']}：</label>
                    <div class="col-sm-5">21,922.00</div>
                </div>
                <div class="clearfix m-l-lg line-hi34">
                    <label class="ft-bold col-sm-3 al-right">${views.report_auto['游戏API记录']}：</label>
                    <div class="col-sm-5">
                        <table class="table table-bordered">
                            <tbody><tr>
                                <td class="bg-gray al-right">${views.report_auto['账号']}</td>
                                <td class="al-left">bwin0122623</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['注单号码']}</td>
                                <td class="al-left">63845550</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['投注时间']}</td>
                                <td class="al-left">2015-08-06 04:22:15</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['局号']}</td>
                                <td class="al-left">72202211</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['场次']}</td>
                                <td class="al-left">3-8</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['游戏种类']}</td>
                                <td class="al-left">3001-${views.report_auto['百家乐']}</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['桌号']}</td>
                                <td class="al-left">1</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['开牌结果']}</td>
                                <td class="al-left"></td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['注单结果']}</td>
                                <td class="al-left"><span class="co-red">${views.report_auto['庄']}：</span>(0)<span class="co-blue3 m-l">${views.report_auto['闲']}：</span>(9)</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['结果牌']}</td>
                                <td class="al-left"></td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['投注额']}</td>
                                <td class="al-left">$10</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['派彩']}</td>
                                <td class="al-left">$-10</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['币别']}</td>
                                <td class="al-left">RMB</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['与人民币的汇率']}</td>
                                <td class="al-left">$1</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['有效投注']}</td>
                                <td class="al-left">$10</td>
                            </tr>
                            <tr>
                                <td class="bg-gray al-right">${views.report_auto['下单装置']}</td>
                                <td class="al-left">-</td>
                            </tr>
                            </tbody></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<soul:import type="edit"/>
