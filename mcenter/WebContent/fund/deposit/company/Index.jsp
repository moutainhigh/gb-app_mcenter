<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<form name="companyDepositForm" action="${root}/fund/deposit/company/doData.html" templateUrl="${root}/fund/deposit/company/list.html" method="post">
    <div class="row">
        <div id="validateRule" style="display: none">${command.validateRule}</div>

        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['资金']}</span>
            <span>/</span>
            <span>${views.sysResource['公司入款审核']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>

        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <%@include file="SearchConditions.jsp"%>
            </div>
        </div>
        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow">
                <div class="dataTables_wrapper search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
                <div id="companyDepositpageDiv"></div>
            </div>
        </div>

    </div>
</form>

<script type="text/javascript">
    curl(["site/fund/deposit/company/Index",'gb/sysSearchTemplate/SysSearchTemplateExtend','site/fund/FundSearch'], function(Page,SysSearchTemplate,FundSearch) {
        page =new Page();
        page.fundSearch = new FundSearch();
        page.bindButtonEvents();
        page.sysSearchTmp = new SysSearchTemplate();
    });
</script>