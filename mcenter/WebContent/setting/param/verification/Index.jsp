<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VPayAccountListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/param/verification.html" method="post">
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
                    <div class="form-group clearfix m-t-lg">
                        <label class="col-xs-3 al-right line-hi34 ft-bold">${views.setting['SiteParam.verification.style']}：</label>
                        <div class="col-xs-5">
                            <div class="btn-group" style="margin-top: -34px;">
                                <button type="button" class="btn btn-default verification-btn">
                                    <img id="yzm" src="${resComRoot}/images/captcha/${empty result.paramValue?result.defaultValue:result.paramValue}.jpg" height="32"></button>
                                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="caret"></span>
                                    <span class="sr-only">Toggle Dropdown</span>
                                </button>
                                <input type="hidden" value="${yzm.id}" name="yzmId" id="yzmId">
                                <input type="hidden" value="${yzm.paramValue}" name="yzmValue" id="yzmValue">
                                <input type="hidden" value="${exclusions.id}" name="exclusionsId" id="exclusionsId">
                                <ul class="dropdown-menu verification-menu">
                                    <c:forEach items="${list}" var="p" varStatus="status">
                                        <li class="yzmSelect"><a href="javascript:void(0)"><img tt="${p.paramCode}" height="34" width="93" src="${resComRoot}/${p.defaultValue}"></a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-xs-3 al-right line-hi34 ft-bold">${views.setting['SiteParam.verification.excludeContent']}：</label>
                        <div class="col-xs-5">
                            <div class="input-group date">
                                <input type="text" name="exclusionsValue" value="${exclusions.paramValue}" class="form-control">
                                <span class="input-group-addon"></span>
                                <!--                            <span class="input-group-addon bdn">&nbsp;&nbsp;<i class="fa fa-search"></i></span>-->
                            </div>
                        </div>
                    </div>



                </div>
                <div class="operate-btn">
                    <soul:button cssClass="btn btn-filter btn-lg m-r" text="${views.setting['common.save']}" opType="ajax" dataType="json"
                                 target="${root}/param/saveYzm.html" post="getCurrentFormData"/>
                </div>
            </div>

        </div>
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/param/verification/Index"/>
<!--//endregion your codes 3-->