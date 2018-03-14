<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.po.vplayerwithdraw"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="row">
    <form:form name="withdrawPageForm" action="${root}/fund/withdraw/withdrawList.html" method="post">
    </form:form>
    <form:form name="withdrawForm" action="${root}/fund/withdraw/withdrawData.html" method="post">
        <div id="validateRule" style="display: none">${command.validateRule}</div>
        <input type="hidden" id="playerRanksMemory" value="">
        <span id="open" hidden>${command.open}</span>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['资金']}&nbsp;&nbsp;&nbsp;&nbsp;/ </span>
            <span>${views.sysResource['玩家取款审核']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <%@include file="SearchConditions.jsp"%>
            </div>
            <input type="hidden" name="search.playerId" value="${command.search.playerId}" />
        </div>
        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="dataTables_wrapper search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
                <div id="withdrawpageDiv"></div>
            </div>
        </div>
    </form:form>
</div>
<script type="text/javascript">
    curl(["site/fund/withdraw/Withdraw",'gb/sysSearchTemplate/SysSearchTemplateExtend','site/fund/FundSearch'], function(Page,SysSearchTemplate,FundSearch) {
        page =new Page();
        page.fundSearch = new FundSearch();
        page.bindButtonEvents();
        page.sysSearchTmp = new SysSearchTemplate();
    });
</script>
