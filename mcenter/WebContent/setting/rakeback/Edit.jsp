<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.RakebackSetVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row"><%--TODO 默认梯度？？？--%>
    <form:form>
        <gb:token/>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span><span>${views.setting['rakeback.edit.title']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="present_wrap"><b>${empty command.result.id?views.setting['rakeback.edit.createPlan']:views.setting['rakeback.edit.editPlan']}</b></div>
                <div class="form-group clearfix m-t">
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.setting['rakeback.edit.planName']}</label>
                    <div class="col-sm-5">
                        <form:input path="result.name" cssClass="form-control" readonly="${command.result.id eq 0?true:false}"/>
                        <form:hidden path="result.id" cssClass="form-control"/>
                            <%--<input type="text" class="form-control" value="${command.result.name}" name="result.name">--%>
                    </div>
                    <div id="validateRule" style="display: none">${command.validateRule}</div>
                </div>

                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34">
                        <span title="" data-original-title="" data-content="1、${views.setting_auto['优惠稽核倍数为空']}<br>2、${views.setting_auto['玩家在取款时']}<br>3、${views.setting_auto['当没有通过存款申请获得优惠']}" data-html="true" data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body" role="button" class="help-popover m-l-sm" tabindex="0"><i class="fa fa-question-circle"></i></span>
                            ${views.setting['rakeback.edit.auditNum']}
                    </label>
                    <div class="col-sm-5 input-group">
                        <input type="text" class="form-control" placeholder="${views.setting['rakeback.edit.canBlank']}" value="${command.result.auditNum}" name="result.auditNum">
                            <%--<form:input path="" cssClass="form-control" p/>--%>
                        <span class="input-group-addon bdn">&nbsp;&nbsp;${views.setting['rakeback.edit.times']}</span>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34">${views.setting['rakeback.edit.remark']}</label>
                    <div class="col-sm-5"><textarea class="form-control" name="result.remark">${command.result.remark}</textarea></div>
                </div>
                <div class="clearfix m">
                    <div class="table-responsive _tables">
                        <c:choose>
                            <c:when test="${empty command.rakebackGrads}">
                                <table class="table table-striped table-bordered table-hover dataTable m-b-none" >
                                    <tr role="row" class="bg-color">
                                        <td style="width: 150px">&nbsp;</td>
                                        <td style="width: 150px"><h3>${views.setting['rakeback.edit.validValue']}</h3></td>
                                        <td style="width: 150px"><h3>${views.setting['rakeback.edit.maxRakeback']}</h3></td>
                                        <td colspan="${command.apiIds.size()}"><h3>${views.setting['rakeback.edit.grads']}</h3></td>
                                    </tr>

                                    <tr class="bg-color apiGrad">
                                        <td>
                                            <div class="ratio_area"></div>
                                            <soul:button target="" text="" opType="function" cssClass="btn btn-w-m btn-danger disabled" tag="button">
                                                ${views.common['delete']}
                                            </soul:button>
                                            <soul:button target="batchUpdateRatio" text="${views.setting_auto['批量调整比例']}" opType="function" cssClass="btn batch_ratio" tag="button"></soul:button>
                                        </td>
                                        <td><input type="text" class="form-control content-width-limit-8" placeholder="" name="rakebackGrads[0].validValue" data-name="rakebackGrads[{n}].validValue"></td>
                                        <td><input type="text" class="form-control content-width-limit-8" placeholder="${views.setting['rakeback.edit.laveBlank']}" name="rakebackGrads[0].maxRakeback" data-name="rakebackGrads[{n}].maxRakeback"></td>
                                        <td>
                                            <div class="scrollInner hide" style="overflow-x: auto;overflow-y: hidden">
                                                <table class="table table-bordered">
                                                    <tr class="bg-color">
                                                        <c:forEach items="${command.apiIds}" var="api">
                                                            <td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
                                                        </c:forEach>
                                                    </tr>
                                                    <tr>
                                                    <c:set var="game_status_index" value="0"/>
                                                    <c:forEach items="${command.apiIds}" var="api">
                                                        <td style="vertical-align: top">
                                                            <c:forEach items="${command.someGames}" var="game" varStatus="game_status">
                                                                <c:if test="${game['apiId'] eq api}">
                                                                    <div class="input-group m-b-xs content-width-limit-200 _game">
                                                                        <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                                                        <input type="hidden" value="${api}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].apiId" name="rakebackGrads[0].rakebackGradsApis[${game_status_index}].apiId">
                                                                        <input type="hidden" value="${game['gameType']}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].gameType" name="rakebackGrads[0].rakebackGradsApis[${game_status_index}].gameType">
                                                                        <input type="text" class="form-control _ratio" value="${rga.ratio}" name="rakebackGrads[0].rakebackGradsApis[${game_status_index}].ratio"  data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].ratio">
                                                                        <span class="input-group-addon border-left-n">%</span>
                                                                        <span class="input-group-addon adjust">
                                                                <soul:button tag="a" target="changeRatio" post="add" text="" cssClass="adjust up" opType="function">
                                                                    <i class="fa fa-angle-up"></i>
                                                                </soul:button>
                                                                <soul:button tag="a" target="changeRatio" post="sub" text="" cssClass="adjust down" opType="function">
                                                                    <i class="fa fa-angle-down"></i>
                                                                </soul:button>
                                                            </span>
                                                                    </div>
                                                                    <c:set var="game_status_index" value="${game_status_index+1}"/>
                                                                </c:if>
                                                            </c:forEach>

                                                        </td>
                                                    </c:forEach>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>

                                    </tr>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <table class="table table-striped table-bordered table-hover dataTable m-b-none" ${rake.id} ${rake.maxRakeback}>
                                    <tr role="row" class="bg-color">
                                        <td style="width: 150px">&nbsp;</td>
                                        <td style="width: 150px"><h3>${views.setting['rakeback.edit.validValue']}</h3></td>
                                        <td style="width: 150px"><h3>${views.setting['rakeback.edit.maxRakeback']}</h3></td>
                                        <td colspan="${command.apiIds.size()}"><h3>${views.setting['rakeback.edit.grads']}</h3></td>
                                    </tr>

                                    <c:forEach items="${command.rakebackGrads}" var="rake" varStatus="status">
                                        <tr class="bg-color apiGrad">
                                            <input value="${rake.rakebackId}" name="rakebackGrads[${status.index}].rakebackId" data-name="rakebackGrads[{n}].rakebackId" type="hidden">
                                            <td>
                                                <div class="ratio_area"></div>
                                                <soul:button target="${status.first ? '':'deletePlan'}" text="" opType="function" cssClass="btn btn-w-m btn-danger ${status.first ? 'disabled':''}" tag="button">
                                                    ${views.common['delete']}
                                                </soul:button>
                                                <soul:button target="batchUpdateRatio" text="${views.setting_auto['批量调整比例']}" opType="function" cssClass="btn batch_ratio" tag="button"></soul:button>
                                            </td>
                                            <td><input type="text" class="form-control content-width-limit-8" value="${rake.validValue}" name="rakebackGrads[${status.index}].validValue" data-name="rakebackGrads[{n}].validValue"></td>
                                            <td><input type="text" class="form-control content-width-limit-8" placeholder="${views.setting['rakeback.edit.laveBlank']}" value="${rake.maxRakeback}" name="rakebackGrads[${status.index}].maxRakeback" data-name="rakebackGrads[{n}].maxRakeback"></td>
                                            <td>
                                                <div class="scrollInner hide" style="overflow-x: auto;overflow-y: hidden">
                                                    <table class="table table-bordered">
                                                        <tr class="bg-color">
                                                            <c:forEach items="${command.apiIds}" var="api">
                                                                <td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
                                                            </c:forEach>
                                                        </tr>
                                                        <tr>
                                                            <c:set var="game_status_index" value="0"/>
                                                            <c:forEach items="${command.apiIds}" var="api">
                                                                <td style="vertical-align: top">
                                                                    <c:forEach items="${command.someGames}" var="game">
                                                                        <c:set value="0" var="_someGame"></c:set>
                                                                        <c:if test="${game['apiId'] eq api}">
                                                                            <c:forEach items="${rake.rakebackGradsApis}" var="rga" varStatus="apiStatus">
                                                                                <c:if test="${game['apiId'] eq rga.apiId && game['gameType'] eq rga.gameType}">
                                                                                    <c:set value="1" var="_someGame"></c:set>
                                                                                    <div class="input-group m-b-xs content-width-limit-200 _game">
                                                                                        <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                                                                        <input type="hidden" value="${api}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].apiId" name="rakebackGrads[${status.index}].rakebackGradsApis[${game_status_index}].apiId">
                                                                                        <input type="hidden" value="${game['gameType']}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].gameType" name="rakebackGrads[${status.index}].rakebackGradsApis[${game_status_index}].gameType">
                                                                                        <input type="text" class="form-control _ratio" value="${rga.ratio}" name="rakebackGrads[${status.index}].rakebackGradsApis[${game_status_index}].ratio"  data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].ratio">
                                                                                        <span class="input-group-addon border-left-n">%</span>
                                                                                        <span class="input-group-addon adjust">
                                                                    <soul:button tag="a" target="changeRatio" post="add" text="" cssClass="adjust up" opType="function">
                                                                        <i class="fa fa-angle-up"></i>
                                                                    </soul:button>
                                                                    <soul:button tag="a" target="changeRatio" post="sub" text="" cssClass="adjust down" opType="function">
                                                                        <i class="fa fa-angle-down"></i>
                                                                    </soul:button>
                                                                </span>
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <c:if test="${_someGame eq 0}">
                                                                                <div class="input-group m-b-xs content-width-limit-200 _game">
                                                                                    <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                                                                    <input type="hidden" value="${api}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].apiId" name="rakebackGrads[${status.index}].rakebackGradsApis[${game_status_index}].apiId">
                                                                                    <input type="hidden" value="${game['gameType']}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].gameType" name="rakebackGrads[${status.index}].rakebackGradsApis[${game_status_index}].gameType">
                                                                                    <input type="text" class="form-control _ratio" value="${rga.ratio}" name="rakebackGrads[${status.index}].rakebackGradsApis[${game_status_index}].ratio"  data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].ratio">
                                                                                    <span class="input-group-addon border-left-n">%</span>
                                                                                    <span class="input-group-addon adjust">
                                                                    <soul:button tag="a" target="changeRatio" post="add" text="" cssClass="adjust up" opType="function">
                                                                        <i class="fa fa-angle-up"></i>
                                                                    </soul:button>
                                                                    <soul:button tag="a" target="changeRatio" post="sub" text="" cssClass="adjust down" opType="function">
                                                                        <i class="fa fa-angle-down"></i>
                                                                    </soul:button>
                                                                </span>
                                                                                </div>
                                                                            </c:if>
                                                                            <c:set var="game_status_index" value="${game_status_index+1}"/>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </td>
                                                            </c:forEach>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <soul:button tag="button" target="createPlan" text="${views.common['create']}" opType="function" cssClass="btn btn-info btn-addon m-t pull-right">
                        <i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span>
                    </soul:button>
                </div>
                <div class="operate-btn">
                    <soul:button target="${root}/setting/rakebackSet/backWaterSave.html" refresh="true" callback="goToLastPage"  cssClass="btn btn-filter btn-lg m-r _enter_submit" post="getCurrentFormData" text="" opType="ajax" tag="button" precall="validateForm">
                        ${views.common['OK']}
                    </soul:button>
                </div>
            </div>
        </div>
    </form:form>
</div>
<table class="table table-striped table-bordered table-hover dataTable m-b-none hide" id="foolishlyTable" >
    <tr role="row" class="bg-color">
        <td style="width: 150px">
            <soul:button target="deletePlan" text="" opType="function" cssClass="btn btn-w-m btn-danger" tag="button">
                ${views.common['delete']}
            </soul:button>
        </td>
        <td style="width: 150px"><h3>${views.setting['rakeback.edit.validValue']}</h3></td>
        <td style="width: 150px"><h3>${views.setting['rakeback.edit.maxRakeback']}</h3></td>
        <td colspan="${command.apiIds.size()}"><h3>${views.setting['rakeback.edit.grads']}</h3></td>
    </tr>

    <tr class="bg-color apiGrad">
        <td>
            <div class="ratio_area"></div>
            <soul:button target="deletePlan" text="" opType="function" cssClass="btn btn-w-m btn-danger" tag="button">
                ${views.common['delete']}
            </soul:button>
            <soul:button target="batchUpdateRatio" text="${views.setting_auto['批量调整比例']}" opType="function" cssClass="btn batch_ratio" tag="button"></soul:button>
        </td>
        <td><input type="text" class="form-control content-width-limit-8" placeholder="" name="rakebackGrads[0].validValue" data-name="rakebackGrads[{n}].validValue"></td>
        <td><input type="text" class="form-control content-width-limit-8" placeholder="${views.setting['rakeback.edit.laveBlank']}" name="rakebackGrads[0].maxRakeback" data-name="rakebackGrads[{n}].maxRakeback"></td>
        <td>
            <div class="scrollInner hide" style="overflow-x: auto;overflow-y: hidden">
                <table class="table table-bordered">
                    <tr class="bg-color">
                        <c:forEach items="${command.apiIds}" var="api">
                            <td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <c:set var="game_status_index" value="0"/>
                        <c:forEach items="${command.apiIds}" var="api">
                            <td style="vertical-align: top">
                                <c:forEach items="${command.someGames}" var="game" varStatus="game_status">
                                    <c:if test="${game['apiId'] eq api}">
                                        <div class="input-group m-b-xs content-width-limit-200 _game">
                                            <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                            <input type="hidden" value="${api}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].apiId" name="rakebackGrads[0].rakebackGradsApis[${game_status_index}].apiId">
                                            <input type="hidden" value="${game['gameType']}" data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].gameType" name="rakebackGrads[0].rakebackGradsApis[${game_status_index}].gameType">
                                            <input type="text" class="form-control _ratio" value="${rga.ratio}" name="rakebackGrads[0].rakebackGradsApis[${game_status_index}].ratio"  data-name="rakebackGrads[{n}].rakebackGradsApis[${game_status_index}].ratio">
                                            <span class="input-group-addon border-left-n">%</span>
                                            <span class="input-group-addon adjust">
                                <soul:button tag="a" target="changeRatio" post="add" text="" cssClass="adjust up" opType="function">
                                    <i class="fa fa-angle-up"></i>
                                </soul:button>
                                <soul:button tag="a" target="changeRatio" post="sub" text="" cssClass="adjust down" opType="function">
                                    <i class="fa fa-angle-down"></i>
                                </soul:button>
                            </span>
                                        </div>
                                        <c:set var="game_status_index" value="${game_status_index+1}"/>
                                    </c:if>
                                </c:forEach>

                            </td>
                        </c:forEach>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<soul:import res="site/setting/rakeback/Edit"/>
