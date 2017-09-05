<%--@elvariable id="sup" type="so.wwb.gamebox.model.company.lottery.vo.SiteLotteryOddVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <form:form method="post">
        <div id="validateRule" style="display: none">${oddRule}</div>
        <div id="${id}" class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['彩票']}</span><span>/</span><span>${views.lottery_auto['赔率设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="sys_tab_wrap clearfix">
                    <div class="m-sm">
                        <a  href="javascript:void(0)" code="cqssc" class="label ssc-label">${dicts.lottery.lottery['cqssc']}</a>
                        <a  href="javascript:void(0)" code="tjssc" class="label ssc-label">${dicts.lottery.lottery['tjssc']}</a>
                        <a  href="javascript:void(0)" code="xjssc" class="label ssc-label">${dicts.lottery.lottery['xjssc']}</a>
                        <a  href="javascript:void(0)" code="hklhc" class="label ssc-labe.cl">${dicts.lottery.lottery['hklhc']}</a>
                        <a  href="javascript:void(0)" code="bjpk10" class="label ssc-label">${dicts.lottery.lottery['bjpk10']}</a>
                        <a  href="javascript:void(0)" code="jsk3" class="label ssc-label">${dicts.lottery.lottery['jsk3']}</a>
                        <a  href="javascript:void(0)" code="hbk3" class="label ssc-label">${dicts.lottery.lottery['hbk3']}</a>
                        <a  href="javascript:void(0)" code="ahk3" class="label ssc-label">${dicts.lottery.lottery['ahk3']}</a>
                        <a  href="javascript:void(0)" code="gxk3" class="label ssc-label">${dicts.lottery.lottery['gxk3']}</a>
                        <a  href="javascript:void(0)" code="xyft" class="label ssc-label">${dicts.lottery.lottery['xyft']}</a>
                        <a  href="javascript:void(0)" code="xy28" class="label ssc-label">${dicts.lottery.lottery['xy28']}</a>
                        <a  href="javascript:void(0)" code="cqxync" class="label ssc-label">${dicts.lottery.lottery['cqxync']}</a>
                        <a  href="javascript:void(0)" code="gdkl10" class="label ssc-label">${dicts.lottery.lottery['gdkl10']}</a>
                        <a  href="javascript:void(0)" code="bjkl8" class="label ssc-label">${dicts.lottery.lottery['bjkl8']}</a>
                        <a  href="javascript:void(0)" code="fc3d" class="label ssc-label">${dicts.lottery.lottery['fc3d']}</a>
                        <a  href="javascript:void(0)" code="tcpl3" class="label ssc-label">${dicts.lottery.lottery['tcpl3']}</a>
                        <a  href="javascript:void(0)" code="efssc" class="label ssc-label">${dicts.lottery.lottery['efssc']}</a>
                        <a  href="javascript:void(0)" code="sfssc" class="label ssc-label">${dicts.lottery.lottery['sfssc']}</a>
                        <a  href="javascript:void(0)" code="wfssc" class="label ssc-label">${dicts.lottery.lottery['wfssc']}</a>
                        <a  href="javascript:void(0)" code="ffssc" class="label ssc-label">${dicts.lottery.lottery['ffssc']}</a>
                        <a  href="javascript:void(0)" code="jspk10" class="label ssc-label">${dicts.lottery.lottery['jspk10']}</a>
                    </div>
                </div>
                <div id="lot_two_menu" >

                </div>
                <div id="lot_three_menu" class="lot_three_menu">

                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="editable_wrapper">

                </div>

                <div class="operate-btn" style="text-align: center">
                    <soul:button cssClass="btn btn-filter btn-lg" text="${views.lottery_auto['确认修改']}" opType="function" target="saveLotteryOdd"/>
                </div>
            </div>
        </div>

    </form:form>
</div>
<soul:import res="site/lottery/odds/Index"/>