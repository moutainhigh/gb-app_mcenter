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
                        <a  href="javascript:void(0)" code="cqssc" class="label ssc-label">${views.lottery_auto['重庆时时彩']}</a>
                        <a  href="javascript:void(0)" code="tjssc" class="label ssc-label">${views.lottery_auto['天津时时彩']}</a>
                        <a  href="javascript:void(0)" code="xjssc" class="label ssc-label">${views.lottery_auto['新疆时时彩']}</a>
                        <a  href="javascript:void(0)" code="hklhc" class="label ssc-labe.cl">${views.lottery_auto['香港六合彩']}</a>
                        <a  href="javascript:void(0)" code="bjpk10" class="label ssc-label">${views.lottery_auto['北京PK10']}</a>
                        <a  href="javascript:void(0)" code="jsk3" class="label ssc-label">${views.lottery_auto['江苏快三']}</a>
                        <a  href="javascript:void(0)" code="hbk3" class="label ssc-label">${views.lottery_auto['湖北快三']}</a>
                        <a  href="javascript:void(0)" code="ahk3" class="label ssc-label">${views.lottery_auto['安徽快三']}</a>
                        <a  href="javascript:void(0)" code="gxk3" class="label ssc-label">${views.lottery_auto['广西快三']}</a>
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