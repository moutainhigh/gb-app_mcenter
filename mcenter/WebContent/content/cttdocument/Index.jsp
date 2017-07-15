<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vCttDocument/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['文案管理']}</span>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <div class="clearfix filter-wraper border-b-1">
                    <soul:button tag="button" callback="goNext" target="${root}/cttDocumentI18n/create.html"
                                 cssClass="btn btn-info btn-addon" opType="dialog" title="${views.content['document.addParentProject']}" text="${views.content['document.addProject']}">
                        <i class="fa fa-plus"></i><span class="hd">${views.content['document.addProject']}</span>
                    </soul:button>

                    <%--<a href="/vCttDraft/list.html" nav-target="mainFrame">${views.content_auto['旧代码入口']}</a>--%>
                    <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>
                    <div class="function-menu-show hide">
                        <soul:button tag="button" text="${views.setting['common.delete']}" target="${root}/vCttDocument/batchDelete.html" post="getSelectIds" opType="ajax" cssClass="btn btn-danger-hide" callback="query"><i class="fa fa-trash-o"></i><span class="hd">${views.setting['common.delete']}</span></soul:button>
                    </div>
                    <div class="pull-right m-t-n-xxs">
                        <a class="btn btn-outline btn-filter orderChildCss" style="display: none" nav-target="mainFrame"
                            href="/vCttDocument/toOrderList.html?search.parentId=">
                            <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.content['document.orderChild']}
                        </a>
                        <!--                            <button class="btn btn-outline btn-filter m-r-sm">${views.content_auto['统计数据']}</button>-->
                        <a class="btn btn-outline btn-filter" nav-target="mainFrame" href="/vCttDocument/toOrderList.html">
                            <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.content['document.orderParent']}
                        </a>
                    </div>
                </div>

                <!--表格内容-->
                <dl class="clearfix filter-conditions p-xxs p-b-xs m-b-none border-b-1 hide">
                    <dt>${views.common['filterCondition']}（<a href="javascript:void(0)">${views.common['clear']}</a>）</dt>
                </dl>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
        <!--//endregion your codes 2-->
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/content/cttdocument/Index"/>
<!--//endregion your codes 3-->