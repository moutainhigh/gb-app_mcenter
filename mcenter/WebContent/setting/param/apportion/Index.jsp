<%--
  Created by IntelliJ IDEA.
  User: cj
  Date: 15-9-15
  Time: 下午4:53
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.RakebackSetListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/param/apportion.html" method="post">
    <div id="validateRule" style="display: none">${rule}</div>
    <input type="hidden" name="pv[0].id" value="${p0.id}">
    <input type="hidden" name="pv[1].id" value="${p1.id}">
    <input type="hidden" name="pv[2].id" value="${p2.id}">
    <input type="hidden" name="pv[3].id" value="${p3.id}">
    <input type="hidden" name="pv[4].id" value="${p4.id}">
    <input type="hidden" name="pv[5].id" value="${p5.id}">
    <input type="hidden" name="pv[6].id" value="${p6.id}">
    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span><span>${views.sysResource['分摊设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="present_wrap"><b>${views.setting['apportion.page.title']}</b></div>
                <div class="line-hi34 col-sm-12 bg-gray m-t m-b-sm">
                    <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.setting['apportion.page.agent.fee']}
                </div>
                <div class="clearfix m-l m-r">
                    <soul:button cssClass="pull-right" text="${views.common.updatePercent}" opType="function"
                                 target="switchEdit"/>
                </div>
                <div class="m">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover border">
                            <thead>
                            <tr class="bg-gray">
                                <th width="33%">${views.setting['apportion.page.item.apportion.type']}</th>
                                <th width="33%">${views.setting['apportion.page.item.self']}%</th>
                                <th>${views.setting['apportion.page.item.agent.percent']}%</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${views.setting['apportion.page.column.rakeback']}
                                    <span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body"
                                          data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-html="true"
                                          data-content="${views.setting['apportion.page.column.rakeback.popover']}"><i
                                            class="fa fa-question-circle"></i></span></td>
                                <td>
                                    <span class="sp1display">${empty p0.paramValue ? 100 : (100 - p0.paramValue)}</span>%
                                </td>
                                <td>
                                    <div><span>${empty p0.paramValue ? 0 : p0.paramValue}</span>%</div>
                                    <div class="input-group content-width-limit-10 hide">
                                        <input type="text" class="form-control input-sm" name="pv[0].paramValue"
                                               value="${empty p0.paramValue?0:p0.paramValue}" maxlength="5">
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>${views.setting['apportion.page.column.promotions']}
                                    <span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body"
                                          data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-html="true"
                                          data-content="${views.setting['apportion.page.column.promotions.popover']}"><i
                                            class="fa fa-question-circle"></i></span></td>
                                <td>
                                    <span class="sp2display">${empty p1.paramValue ? 100 : (100 - p1.paramValue)}</span>%
                                </td>
                                <td>
                                    <div><span>${empty p1.paramValue ? 0 : p1.paramValue}</span>%</div>
                                    <div class="input-group content-width-limit-10 hide">
                                        <input type="text" class="form-control input-sm" name="pv[1].paramValue"
                                               value="${empty p1.paramValue?0:p1.paramValue}" maxlength="5">
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>${views.setting['apportion.page.column.fee']}
                                    <span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body"
                                          data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-html="true"
                                          data-content="${views.setting['apportion.page.column.fee.popover']}"><i
                                            class="fa fa-question-circle"></i></span></td>
                                <td>
                                    <span class="sp3display">${empty p2.paramValue ? 100 : (100 - p2.paramValue)}</span>%
                                </td>
                                <td>
                                    <div><span>${empty p2.paramValue ? 0 : p2.paramValue}</span>%</div>
                                    <div class="input-group content-width-limit-10 hide">
                                        <input type="text" class="form-control input-sm" name="pv[2].paramValue"
                                               value="${empty p2.paramValue?0:p2.paramValue}" maxlength="5">
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="line-hi34 col-sm-12 bg-gray m-t-lg m-b-sm">
                    <span class="co-yellow"><i class="fa fa-exclamation-circle"></i></span>
                        ${views.setting['apportion.page.topagent.fee']}
                </div>
                <div class="clearfix m-l m-r">
                    <soul:button cssClass="pull-right" text="${views.common.updatePercent}" opType="function"
                                 target="switchEdit"/>
                </div>
                <div class="m">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover border">
                            <thead>
                            <tr class="bg-gray">
                                <th width="33%">${views.setting['apportion.page.item.apportion.type']}</th>
                                <th width="33%">${views.setting['apportion.page.item.self']}%</th>
                                <th>${views.setting['apportion.page.item.topagent.percent']}%</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${views.setting['apportion.page.column.rakeback']}
                                        <%--<span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top" data-content="${views.setting['apportion.page.column.rakeback.popover']}"><i class="fa fa-question-circle"></i></span></td>--%>
                                <td>
                                    <span class="sp4display">${empty p3.paramValue ? 100 : (100 - p3.paramValue)}</span>%
                                </td>
                                <td>
                                    <div><span>${empty p3.paramValue ? 0 : p3.paramValue}</span>%</div>
                                    <div class="input-group content-width-limit-10 hide">
                                        <input type="text" class="form-control input-sm" name="pv[3].paramValue"
                                               value="${empty p3.paramValue?0:p3.paramValue}" maxlength="5">
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>${views.setting['apportion.page.column.promotions']}
                                        <%--<span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top" data-content="${views.setting_auto['待补充']}"><i class="fa fa-question-circle"></i></span></td>--%>
                                <td>
                                    <span class="sp5display">${empty p4.paramValue ? 100 : (100 - p4.paramValue)}</span>%
                                </td>
                                <td>
                                    <div><span>${empty p4.paramValue ? 0 : p4.paramValue}</span>%</div>
                                    <div class="input-group content-width-limit-10 hide">
                                        <input type="text" class="form-control input-sm" name="pv[4].paramValue"
                                               value="${empty p4.paramValue?0:p4.paramValue}" maxlength="5">
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>${views.setting['apportion.page.column.fee']}
                                        <%--<span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top" data-content="${views.setting_auto['待补充']}"><i class="fa fa-question-circle"></i></span></td>--%>
                                <td>
                                    <span class="sp6display">${empty p5.paramValue ? 100 : (100 - p5.paramValue)}</span>%
                                </td>
                                <td>
                                    <div><span>${empty p5.paramValue ? 0 : p5.paramValue}</span>%</div>
                                    <div class="input-group content-width-limit-10 hide">
                                        <input type="text" class="form-control input-sm" name="pv[5].paramValue"
                                               value="${empty p5.paramValue?0:p5.paramValue}" maxlength="5">
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>${views.setting['apportion.page.column.rebate']}
                                    <span tabindex="0" class="help-popover m-l-xs" role="button" data-container="body"
                                          data-toggle="popover" data-trigger="focus" data-placement="top"
                                          data-content="${views.setting['apportion.page.column.rebate.popover']}"><i
                                            class="fa fa-question-circle"></i></span></td>
                                <td>
                                    <span class="sp7display">${empty p6.paramValue ? 100 : (100 - p6.paramValue)}</span>%
                                </td>
                                <td>
                                    <div><span>${empty p6.paramValue ? 0 : p6.paramValue}</span>%</div>
                                    <div class="input-group content-width-limit-10 hide">
                                        <input type="text" class="form-control input-sm" name="pv[6].paramValue"
                                               value="${empty p6.paramValue?0:p6.paramValue}" maxlength="5">
                                        <span class="input-group-addon">%</span>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="operate-btn hide">
                    <soul:button cssClass="btn btn-filter btn-lg" text="${views.common['OK']}" opType="ajax"
                                 dataType="json" target="${root}/param/apportion/save.html" precall="validateForm"
                                 callback="refreshPage" refresh="true" post="getCurrentFormData"/>
                    <soul:button target="refreshPage" cssClass="btn btn-outline btn-filter btn-lg m-l"
                                 text="${views.common['cancel']}" opType="function"
                                 refresh="true">${views.common['cancel']}</soul:button>
                </div>
            </div>
        </div>
    </div>
    <!--//endregion your codes 2-->
</form:form>

<!--//region your codes 3-->
<soul:import res="site/setting/param/apportion/Apportion"/>
<!--//endregion your codes 3-->