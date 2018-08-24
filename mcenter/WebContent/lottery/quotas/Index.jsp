<%--@elvariable id="sup" type="so.wwb.gamebox.model.company.lottery.vo.SiteLotteryQuotaVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <form:form method="post">
        <div id="validateRule" style="display: none">${quotaRule}</div>
        <div id="${id}" class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['彩票']}</span><span>/</span><span>${views.lottery_auto['限额设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <ul class="clearfix sys_tab_wrap" id="lotteryDiv">
                <li class="active" data-code="ssclottery" code="cqssc"><a href="javascript:void(0)">时时彩<span class="badge badge-blue m-l-sm">4种</span></a></li>
                <li data-code="k3lottery" code="jsk3"><a href="javascript:void(0)">快3<span class="badge badge-blue m-l-sm">4种</span></a></li>
                <li data-code="pk10lottery" code="bjpk10"><a href="javascript:void(0)">PK10<span class="badge badge-blue m-l-sm">3种</span></a></li>
                <li data-code="sfclottery" code="cqxync"><a href="javascript:void(0)">十分彩<span class="badge badge-blue m-l-sm">2种</span></a></li>
                <li data-code="otherlottery" code="hklhc"><a href="javascript:void(0)" >其它<span class="badge badge-blue m-l-sm">5种</span></a></li>
            </ul>
            <div class="wrapper white-bg shadow">

                <div class="sys_tab_wrap clearfix" id="searchDiv">
                    <div class="m-sm">
                        <a  href="javascript:void(0)"  code="cqssc" class="label ssc-label" data-code="ssclottery" >${dicts.lottery.lottery['cqssc']}</a>
                        <a  href="javascript:void(0)" code="tjssc" class="label ssc-label" data-code="ssclottery" >${dicts.lottery.lottery['tjssc']}</a>
                        <a  href="javascript:void(0)" code="xjssc" class="label ssc-label" data-code="ssclottery">${dicts.lottery.lottery['xjssc']}</a>
                        <a  href="javascript:void(0)" code="ffssc" class="label ssc-label" data-code="ssclottery">${dicts.lottery.lottery['ffssc']}</a>

                        <a  href="javascript:void(0)" code="jsk3" class="label ssc-label"   data-code="k3lottery" style="display: none">${dicts.lottery.lottery['jsk3']}</a>
                        <a  href="javascript:void(0)" code="hbk3" class="label ssc-label" data-code="k3lottery" style="display: none">${dicts.lottery.lottery['hbk3']}</a>
                        <a  href="javascript:void(0)" code="ahk3" class="label ssc-label" data-code="k3lottery" style="display: none">${dicts.lottery.lottery['ahk3']}</a>
                        <a  href="javascript:void(0)" code="gxk3" class="label ssc-label" data-code="k3lottery" style="display: none">${dicts.lottery.lottery['gxk3']}</a>

                        <a  href="javascript:void(0)" code="bjpk10" class="label ssc-label" data-code="pk10lottery" style="display: none">${dicts.lottery.lottery['bjpk10']}</a>
                        <a  href="javascript:void(0)" code="xyft" class="label ssc-label" data-code="pk10lottery" style="display: none">${dicts.lottery.lottery['xyft']}</a>
                        <a  href="javascript:void(0)" code="jspk10" class="label ssc-label" data-code="pk10lottery" style="display: none">${dicts.lottery.lottery['jspk10']}</a>

                        <a  href="javascript:void(0)" code="cqxync" class="label ssc-label" data-code="sfclottery" style="display: none" >${dicts.lottery.lottery['cqxync']}</a>
                        <a  href="javascript:void(0)" code="gdkl10" class="label ssc-label" data-code="sfclottery" style="display: none" >${dicts.lottery.lottery['gdkl10']}</a>

                        <a  href="javascript:void(0)" code="hklhc" class="label ssc-label" data-code="otherlottery" style="display: none">${dicts.lottery.lottery['hklhc']}</a>
                        <a  href="javascript:void(0)" code="xy28" class="label ssc-label" data-code="otherlottery" style="display: none">${dicts.lottery.lottery['xy28']}</a>
                        <a  href="javascript:void(0)" code="bjkl8" class="label ssc-label" data-code="otherlottery" style="display: none">${dicts.lottery.lottery['bjkl8']}</a>
                        <a  href="javascript:void(0)" code="fc3d" class="label ssc-label" data-code="otherlottery" style="display: none">${dicts.lottery.lottery['fc3d']}</a>
                        <a  href="javascript:void(0)" code="tcpl3" class="label ssc-label" data-code="otherlottery" style="display: none">${dicts.lottery.lottery['tcpl3']}</a>

                    </div>
                </div>

                <div id="editable_wrapper" ></div>

                <div class="operate-btn">
                    <soul:button cssClass="btn btn-filter btn-lg" text="${views.lottery_auto['确认修改']}" opType="function"
                                 target="saveSiteLotteryQuotas" />
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/lottery/quotas/Index"/>