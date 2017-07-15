<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/siteCustomerService/list.html" method="post">
            <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['系统设置']}</span><span>/</span><span>${views.sysResource['站点参数']}</span>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                    <%@ include file="../ParamTop.jsp" %>
                    <div class="clearfix">
                        <div class="col-lg-12 site-switch">
                            <h3>${views.setting['switch.operate_manage']}</h3>
                            <ul class="content clearfix">
                                <c:forEach items="${list1}" var="m">
                                    <li class="clearfix">
                                        <label class="ft-bold">${views.setting['operate_manage.'.concat(m.paramCode)]}：</label>
                                        <span class="co-grayc2">${views.setting['operate_manage.msg.'.concat(m.paramCode)]}</span>
                                        <div class="pull-right">
                                            <input id="${m.id}" paramType="${m.paramType}" paramCode="${m.paramCode}" ${m.paramValue=='true'?'checked':''} type="checkbox" name="my-checkbox" data-size="mini">
                                            <span tabindex="0" class=" help-popover m-l-sm on-off-hint-hide" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top"  data-content="${views.setting['operate_manage.msg.line']}"><i class="fa fa-question-circle"></i></span>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="col-lg-12 site-switch">
                            <h3>${views.setting['switch.system_settings']}</h3>
                            <ul class="content clearfix">
                                <c:forEach items="${list2}" var="m">
                                    <li class="clearfix">
                                        <label class="ft-bold">${views.setting['system_settings.'.concat(m.paramCode)]}：</label>
                                        <span class="co-grayc2">${views.setting['system_settings.msg.'.concat(m.paramCode)]}</span>
                                        <div class="pull-right">
                                            <input id="${m.id}" paramType="${m.paramType}" paramCode="${m.paramCode}" ${m.paramValue=='true'?'checked':''} type="checkbox" name="my-checkbox" data-size="mini">
                                            <span tabindex="0" class=" help-popover m-l-sm on-off-hint-hide" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top"  data-content="${views.setting['operate_manage.msg.line']}"><i class="fa fa-question-circle"></i></span>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <a href="/operation/massInformation/chooseType.html" nav-target="mainFrame" id="massInformation" hidden/>
    </div>

</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/param/switch/Index"/>
<!--//endregion your codes 3-->