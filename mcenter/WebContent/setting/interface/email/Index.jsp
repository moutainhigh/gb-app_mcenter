<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vNoticeEmailRank/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['接口设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <!--筛选条件-->
                <%@ include file="../InterfaceTop.jsp" %>
                <div class="clearfix filter-wraper border-b-1">
                    <soul:button tag="button" callback="query" target="${root}/vNoticeEmailInterface/createEmail.html" title="${views.setting['mail.Index.add']}"
                                 cssClass="btn btn-info btn-addon" opType="dialog" text="${views.setting['common.add']}">
                        <i class="fa fa-plus"></i><span class="hd">${views.setting['mail.Index.add']}</span>
                    </soul:button>
                    <div class="function-menu-show hide">
                       <soul:button tag="button" confirm="${messages.common['delete.deleteConfirm']}" text="${views.setting['common.delete']}d" target="${root}/vNoticeEmailInterface/batchDelete.html" post="getSelectIds" opType="ajax" cssClass="btn btn-danger-hide" callback="query"><i class="fa fa-trash-o"></i><span class="hd">${views.setting['common.delete']}</span></soul:button>
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
<soul:import res="site/setting/interface/email/Index"/>
<!--//endregion your codes 3-->