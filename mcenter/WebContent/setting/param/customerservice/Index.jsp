<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/siteCustomerService/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <a id="pic" hidden href="/cttFloatPic/list.html?hasReturn=true" nav-target="mainFrame"></a>
            <!--//region your codes 2-->
            <div class="row">
                <div class="position-wrap clearfix">
                    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
                    <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['客服参数']}</span>
                </div>
                <div class="col-lg-12">
                    <div class="wrapper white-bg shadow">
                        <div class="clearfix filter-wraper border-b-1">
                            <%--<soul:button tag="button" callback="query" title="${views.setting['customerservice.Index.addParam']}" target="${root}/siteCustomerService/create.html"
                                         cssClass="btn btn-info btn-addon" opType="dialog" text="${views.setting['customerservice.Index.add']}">
                                <i class="fa fa-plus"></i><span class="hd">${views.setting['customerservice.Index.add']}</span>
                            </soul:button>--%>
                            <a href="/cttFloatPic/list.html?hasReturn=true" nav-target="mainFrame" type="button" class="btn btn-primary-hide pull-left m-r-sm"><i class="fa fa-gear"></i><span class="hd">${views.setting['customerservice.Index.show']}</span></a>
                            <div class="function-menu-show hide">
                                <soul:button tag="button" text="${views.setting['siteCustomerService.Index.del.ONLY']}" precall="validateDelete" target="${root}/siteCustomerService/batchDel.html" post="getSelectIds" opType="ajax" cssClass="btn btn-danger-hide" callback="query"><i class="fa fa-trash-o"></i><span class="hd">${views.setting['common.delete']}</span></soul:button>
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
<soul:import res="site/setting/param/customerservice/Index"/>
<!--//endregion your codes 3-->