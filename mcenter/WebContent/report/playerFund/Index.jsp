<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.RebateBillVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/userPlayerFund/search.html" method="post" name="userPlayerFund">
    <div id="validateRule" style="display: none">${validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['统计']}</span>
            <span>/</span><span>${views.fund['资金查询']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <%@include file="SearchConditions.jsp"%>
                <%--<soul:button tag="button" cssClass="btn btn-export-btn btn-primary-hide"
                             text="${views.common['export']}"
                             precall="validExportCount" post="getCurrentFormData"
                             title="${views.role['player.dataExport']}"
                             target="${root}/userPlayerFund/exportData.html" opType="ajax">
                    <i class="fa fa-sign-out"></i><span class="hd">${views.common['export']}</span>
                </soul:button>--%>
                <%--<a href="${root}/userPlayerFund/exportData.html" class="btn btn-export-btn btn-primary-hide" target="_blank">导出</a>--%>
                <div id="editable_wrapper" class="dataTables_wrapper white-bg m-t-md search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>
<!--//endregion your codes 2-->
<!--//region your codes 3-->
<%--<soul:import res="site/report/playerFund/Index"/>--%>
<script type="text/javascript">
    curl(["site/report/playerFund/Index",'site/report/playerFund/SysSearchTemplate'], function(Page,SysSearchTemplate) {
        page =new Page();
        page.bindButtonEvents();
        page.sysSearchTmp = new SysSearchTemplate();
    });
</script>
<!--//endregion your codes 3-->