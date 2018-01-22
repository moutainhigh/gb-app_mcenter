<%--@elvariable id="command" type="so.wwb.gamebox.model.report.operate.vo.SiteJackpotListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['统计']}</span><span>/</span><span>彩金对账</span>
        <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <form:form action="${root}/siteJackpot/jackpotSite.html" method="post">
        <div id="validateRule" style="display: none">${validateRule}</div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div id="editable_wrapper" class="dataTables_wrapper white-bg m-t-md search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </form:form>
</div>

<soul:import res="site/report/siteJackpot/Index"/>