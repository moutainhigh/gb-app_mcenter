<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vCttDraft/list.html" method="post">
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
                    <soul:button tag="button" callback="goNext" target="${root}/cttDraft/create.html"
                                 cssClass="btn btn-info btn-addon" opType="dialog" title="${views.content_auto['新增大项']}" text="${views.content_auto['新增项目']}">
                        <i class="fa fa-plus"></i><span class="hd">${views.content['新增项目']}</span>
                    </soul:button>
                    <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>
                    <div class="function-menu-show hide">
                        <soul:button tag="button" text="${views.setting['common.delete']}" target="${root}/vSiteContacts/batchDelete.html" post="getSelectIds" opType="ajax" cssClass="btn btn-danger-hide" callback="query"><i class="fa fa-trash-o"></i><span class="hd">${views.setting['common.delete']}</span></soul:button>
                    </div>
                </div>
                <!--表格内容-->
                <dl class="clearfix filter-conditions p-xxs p-b-xs m-b-none border-b-1 hide">
                    <dt>${views.common['filterCondition']}（<a href="javascript:void(0)">${views.common['clear']}</a>）</dt>
                </dl>
                <div class="search-list-container">
                    <%@ include file="IndexPartial.jsp" %>
                </div>
            </div>
        </div>
        <!--//endregion your codes 2-->
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/content/cttdraft/Index"/>
<!--//endregion your codes 3-->