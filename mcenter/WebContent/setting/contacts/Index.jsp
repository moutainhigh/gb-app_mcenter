<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/vSiteContacts/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
        <!--//region your codes 2-->
        <div class="row">
            <div class="position-wrap clearfix">
                <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
                <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['联系人管理']}</span>
            </div>
            <div class="col-lg-12">
                <div class="wrapper white-bg shadow">
                    <!--筛选条件-->
                    <div class="clearfix filter-wraper border-b-1">
                        <soul:button tag="button" callback="query" target="${root}/vSiteContacts/create.html"
                                     cssClass="btn btn-info btn-addon" opType="dialog" text="${views.setting['contacts.Index.add']}">
                            <i class="fa fa-plus"></i><span class="hd">${views.setting['contacts.Index.add']}</span>
                        </soul:button>
                        <div class="function-menu-show hide">
                            <soul:button tag="button" text="${views.setting['common.delete']}" target="${root}/vSiteContacts/batchDelete.html" post="getSelectIds" opType="ajax" precall="confirmDel" cssClass="btn btn-danger-hide" callback="query"><i class="fa fa-trash-o"></i><span class="hd">${views.setting['common.delete']}</span></soul:button>
                        </div>
                        <div class="search-wrapper btn-group pull-right m-r-n-xs">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <select id="searchSelect" data-placeholder="${views.setting['contacts.Index.name']}" class="btn-group chosen-select-no-single" tabindex="9" callback="searchSelectChange">
                                        <option value="search.name">${views.setting['contacts.Index.name']}</option>
                                        <option value="search.mail">${views.setting['contacts.Index.mail']}</option>
                                        <option value="search.phone">${views.setting['contacts.Index.phone']}</option>
                                    </select>
                                </div>
                                <input type="text" id="searchName" name="search.name" class="form-control">
                                <span class="input-group-btn">
                                    <soul:button text="${views.setting['common.query']}" tag="button" cssClass="btn btn-filter _enter_submit" opType="function" target="query"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.setting['common.query']}</span></soul:button>
                                </span>
                            </div>
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
<soul:import res="site/setting/contacts/Index"/>
<!--//endregion your codes 3-->