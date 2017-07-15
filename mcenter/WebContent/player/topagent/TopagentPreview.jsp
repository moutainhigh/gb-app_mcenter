<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="wrapper white-bg shadow" id="preview-div">
    <div class="present_wrap"><b>${views.role['topAgent.edit.createAgent']}—${views.common['preview']}</b></div>
    <div class="clearfix m-t-sm">
        <!--表格内容 开始-->
        <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
            <!-- 表格 开始 -->
            <div class="p-md">
                <div class="m-b fw-none-b clearfix">
                    <b class="fs16">${views.role['topAgent.edit.basics']}</b>
                </div>
                <div class="gray-chunk clearfix">

                    <div class="form-group clearfix m-b-sm line-hi34 ">
                        <label class="col-sm-3 al-right ft-bold">${views.column['VPlayerRecharge.username']} :</label>
                        <div class="clearfix col-sm-6">
                            ${command.sysUser.username}
                        </div>
                    </div>

                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">${views.role['topAgent.edit.rebatePlan']} :</label>
                        <div class="clearfix col-sm-6">
                            <c:forEach items="${rebate}" var="p">
                                    ${p.name}&nbsp;
                            </c:forEach>
                        </div>
                    </div>

                    <%--时区开始--%>
                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">${views.column['defaultTimezone']} :</label>
                        <div class="clearfix col-sm-6">
                            ${command.sysUser.defaultTimezone}
                        </div>
                    </div>
                <%--时区结束--%>
                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold"> ${views.column['realName']} :</label>
                        <div class="clearfix col-sm-6">${command.sysUser.realName}</div>
                    </div>
                    <%--主货币--%>
                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">
                            ${views.column['mainCurrency']} :
                        </label>
                        <div class="clearfix col-sm-6">
                            ${dicts.common.conpany[command.sysUser.defaultCurrency]}
                        </div>
                    </div>
                    <%--主货币结束--%>

                    <%--主语言--%>
                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">
                            ${views.column['defaultLocale']} :
                        </label>
                        <div class="clearfix col-sm-6">
                            ${dicts.common.local[command.sysUser.defaultLocale]}
                        </div>
                    </div>
                    <%--主语言 开始--%>
                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">${dicts.content.contact_way_type['110']} :</label>
                        <div class="clearfix col-sm-6">
                            ${command.phone.contactValue}
                        </div>
                    </div>

                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">${dicts.content.contact_way_type['201']} :</label>
                        <div class="clearfix col-sm-6">
                            ${command.email.contactValue}
                        </div>
                    </div>
                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">${views.column['sex']} :</label>
                        <div class="clearfix col-sm-6">
                            ${dicts.common.sex[command.sysUser.sex]}
                        </div>
                    </div>

                    <div class="form-group clearfix m-b-sm line-hi34">
                        <label class="col-sm-3 al-right ft-bold">${views.column['resource']} :</label>
                        <div class="clearfix col-sm-6">
                            ${command.result.promotionResources}
                        </div>
                    </div>

                </div>
                <!-- 表格 结束 -->
                <div class="m-t m-b fw-none-b clearfix">
                    <b class="fs16">${views.role['topAgent.edit.ratio']}</b>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover dataTable m-b-none" aria-describedby="editable_info">
                        <thead>
                        <tr>
                            <th class="bg-gray">${views.role['TopAgent.edit.ratioProject']}</th>
                            <th class="bg-gray">${views.role['TopAgent.edit.ratioNumber']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="ratio" items="${command.userAgentApis}" varStatus="status">
                            <tr>
                                <td>${gbFn:getSiteApiName(ratio.apiId)}</td>
                                <td>
                                    <label class="al-right"><span class="m-r-sm"></span>${command.gameTypeMap[ratio.gameType].value}</label>
                                    <label class="al-right"><span class="m-r-sm"></span>${views.role['topAgent.detail.ratioEdit.self']} :</label><span class="co-red"> ${100.0-ratio.ratio}%</span>
                                    <label class="al-right"><span class="m-r-sm"></span>${views.role['topAgent.detail.ratioEdit.topAgent']} :</label><span class="co-red"> ${ratio.ratio}%</span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table></div></div>
        </div>
        <!--表格内容 结束-->
    </div>
    <div class="operate-btn">
        <soul:button target="preStep" text="" cssClass="btn btn-filter btn-lg" opType="function" refresh="true">${views.player_auto['上一步']}</soul:button>
        <%--<a class="btn btn-filter btn-outline btn-lg" href="role/added_genera_agency.html" nav-target="mainFrame">${views.player_auto['上一步']}</a>--%>
        <%--<a href="role/added_genera_agency-finish.html" class="btn btn-filter btn-lg" nav-target="mainFrame">${views.player_auto['提交']}</a>--%>
        <soul:button target="${root}/userAgent/persistTopAgent.html" text="" cssClass="btn btn-filter btn-lg" precall="myValidateForm" opType="ajax" post="getCurrentFormData" callback="goToLastPage" refresh="true">${views.common['commit']}</soul:button>
    </div>
</div>