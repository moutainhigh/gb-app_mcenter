<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.RebateSetVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <gb:token/>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span><span>${views.sysResource['返佣设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            <soul:button tag="a" target="goToLastPage" refresh="true"  text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <c:choose>
                    <c:when test="${empty command.result.id}">
                        <div class="present_wrap"><b>${views.setting['rebate.edit.create']}</b></div>
                    </c:when>
                    <c:otherwise>
                        <div class="present_wrap">
                            <b>${views.setting['rebate.edit.edit']}</b>
                            <a href="/rebateSet/copyRebateSet.html?search.id=${command.result.id}" nav-target="mainFrame">${views.setting_auto['复制本方案']}</a>
                        </div>

                    </c:otherwise>
                </c:choose>
                <div class="form-group clearfix m-t">
                    <label class="ft-bold col-sm-3 al-right line-hi34" for="result.name">${views.setting['rebate.edit.name']}</label>
                    <div class="col-sm-5 input-group">
                        <form:input path="result.name" cssClass="form-control" readonly="${command.result.id eq 0?true:false}"></form:input>
                        <form:hidden path="result.id"></form:hidden>
                    </div>

                </div>
                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34" for="result.validValue">${views.setting['rebate.edit.validValue']}</label>
                    <div class="col-sm-5 input-group">
                        <form:input path="result.validValue" cssClass="form-control"></form:input>
                        <span data-content="${views.role['paylimit.setting.tips.validValue']}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="input-group-addon help-popover" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34" for="result.remark">${views.setting['rebate.edit.remark']}:</label>
                    <div class="col-sm-5">
                        <form:textarea path="result.remark" cssClass="form-control"></form:textarea>
                    </div>
                </div>
                <div class="clearfix m">
                    <div class="table-responsive _tables">
                        <c:choose>
                            <c:when test="${empty command.rebateGrads}">
                                <table class="table table-striped table-bordered table-hover dataTable m-b-none">
                                    <tr role="row" class="bg-color">
                                        <td rowspan="2">&nbsp;</td>
                                        <td rowspan="2">
                                            <h3>${views.setting['rebate.edit.totalProfit']}
                                                <i data-content="${views.setting['rebate.edit.showTitle']}" class="m-l-sm help-popover"
                                                   data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                                   role="button" tabindex="0" data-original-title="" title="">
                                                    <i class="fa fa-question-circle"></i>
                                                </i>
                                            </h3>
                                        </td>
                                        <td rowspan="2"><h3>${views.setting['rebate.edit.validPlayerNum']}</h3></td>
                                        <td rowspan="2"><h3>${views.setting['rebate.edit.max']}</h3></td>
                                        <td rowspan="2"><h3>${views.operation_auto["设置返佣分摊比例"]}</h3></td>
                                        <td colspan="${command.apiIds.size()}">
                                            <h3>${views.setting['rebate.edit.ratio']}
                                                <i data-content="${views.setting['rebate.edit.rakeback']}" class="m-l-sm help-popover"
                                                   data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                                   role="button" tabindex="0" data-original-title="" title="">
                                                    <i class="fa fa-question-circle"></i>
                                                </i>
                                            </h3>
                                        </td>


                                    </tr>
                                    <tr class="bg-color">
                                        <c:forEach items="${command.apiIds}" var="api">
                                            <td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
                                        </c:forEach>
                                    </tr>
                                    <tr class="bg-color apiGrad">
                                        <td>
                                            <div class="ratio_area"></div>
                                            <button type="button" class="btn btn-danger disabled">${views.common['delete']}</button>
                                            <soul:button target="batchUpdateRatio" text="${views.setting_auto['批量调整比例']}" opType="function" cssClass="btn batch_ratio" tag="button"></soul:button>
                                            <soul:button target="createPlan" text="${views.setting_auto['插入']}" opType="function" cssClass="btn btn-info" tag="button"></soul:button>
                                        </td>
                                        <td>
                                            <input type="hidden" name="rebateGrads[0].id" data-name="rebateGrads[{n}].id" value="">
                                            <input type="text" name="rebateGrads[0].totalProfit" data-name="rebateGrads[{n}].totalProfit" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.profit']}"></td>
                                        <td><input type="text" name="rebateGrads[0].validPlayerNum" data-name="rebateGrads[{n}].validPlayerNum" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.validPlayer']}"></td>
                                        <td><input type="text" class="form-control content-width-limit-8" name="rebateGrads[0].maxRebate" data-name="rebateGrads[{n}].maxRebate" placeholder="${views.setting['rebate.edit.max']}${views.setting['rebate.edit.canBlank']}"></td>
                                        <td>
                                            <div class="_game input-group date content-width-limit-200 m-b-xs">
                                                <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['返水费用']}</b></span>
                                                <input type="number" class="form-control _ratio" name="rebateGrads[0].rakebackRatio" data-name="rebateGrads[{n}].rakebackRatio" value="">
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
                                            <div class="_game input-group date content-width-limit-200 m-b-xs">
                                                <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['优惠费用']}</b></span>
                                                <input type="number" class="form-control _ratio" name="rebateGrads[0].favorableRatio" data-name="rebateGrads[{n}].favorableRatio" value="">
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
                                            <div class="_game input-group date content-width-limit-200 m-b-xs">
                                                <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['其它费用']}</b></span>
                                                <input type="number" class="form-control _ratio" name="rebateGrads[0].otherRatio" data-name="rebateGrads[{n}].otherRatio" value="">
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
                                        </td>
                                        <c:set var="game_status_index" value="0"/>
                                        <c:forEach items="${command.apiIds}" var="api">
                                            <td>
                                                <c:forEach items="${command.someGames}" var="game" varStatus="game_status">
                                                    <c:if test="${game['apiId'] eq api}">

                                                        <div class="4 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
                                                            <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                                                <%--<input type="text" class="form-control">--%>
                                                                <%--TODO--%>
                                                            <input type="hidden" value="${game.apiTypeId}" name="rebateGrads[0].rebateGradsApis[${game_status_index}].apiTypeId" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiTypeId">
                                                            <input type="hidden" value="${api}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiId" name="rebateGrads[0].rebateGradsApis[${game_status_index}].apiId">
                                                            <input type="hidden" value="${game['gameType']}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].gameType" name="rebateGrads[0].rebateGradsApis[${game_status_index}].gameType">
                                                            <input type="text" class="form-control _ratio _batch_ratio" value="${rga.ratio}" name="rebateGrads[0].rebateGradsApis[${game_status_index}].ratio"  data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].ratio">
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
                            </c:when>
                            <c:otherwise>
                                <table class="table table-striped table-bordered table-hover dataTable m-b-none">
                                    <tr role="row" class="bg-color">
                                        <td rowspan="2">&nbsp;</td>
                                        <td rowspan="2">
                                            <h3>${views.setting['rebate.edit.totalProfit']}
                                                <i data-content="${views.setting['rebate.edit.showTitle']}" class="m-l-sm help-popover"
                                                   data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                                   role="button" tabindex="0" data-original-title="" title="">
                                                    <i class="fa fa-question-circle"></i>
                                                </i>
                                            </h3>
                                        </td>
                                        <td rowspan="2"><h3>${views.setting['rebate.edit.validPlayerNum']}</h3></td>
                                        <td rowspan="2"><h3>${views.setting['rebate.edit.max']}</h3></td>
                                        <td rowspan="2">
                                            <h3>${views.operation_auto["设置返佣分摊比例"]}</h3>
                                        </td>
                                        <td colspan="${command.apiIds.size()}">
                                            <h3>${views.setting['rebate.edit.ratio']}
                                                <i data-content="${views.setting['rebate.edit.rakeback']}" class="m-l-sm help-popover"
                                                   data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                                                   role="button" tabindex="0" data-original-title="" title="">
                                                    <i class="fa fa-question-circle"></i>
                                                </i>
                                            </h3>
                                        </td>


                                    </tr>
                                    <tr class="bg-color">
                                        <c:forEach items="${command.apiIds}" var="api">
                                            <td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
                                        </c:forEach>
                                    </tr>
                                    <c:forEach items="${command.rebateGrads}" var="rebateGrad" varStatus="status">
                                        <tr class="bg-color apiGrad">
                                            <td>
                                                <div class="ratio_area"></div>

                                                <c:choose>
                                                    <c:when test="${command.showDeleteBtn}">
                                                        <soul:button target="deletePlan" text="" opType="function" cssClass="btn btn-danger${status.first ? ' disabled ui-button-disable':''}" tag="button">
                                                            ${views.common['delete']}
                                                        </soul:button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-danger disabled">${views.common['delete']}</button>
                                                    </c:otherwise>
                                                </c:choose>
                                                <soul:button target="batchUpdateRatio" text="${views.setting_auto['批量调整比例']}" opType="function" cssClass="btn batch_ratio" tag="button"></soul:button>
                                                <soul:button target="createPlan" text="${views.setting_auto['插入']}" opType="function" cssClass="btn btn-info" tag="button"></soul:button>
                                            </td>
                                            <td>
                                                <input type="hidden" name="rebateGrads[${status.index}].id" data-name="rebateGrads[{n}].id" value="${rebateGrad.id}">
                                                <input type="text"value="${rebateGrad.totalProfit}" name="rebateGrads[${status.index}].totalProfit" data-name="rebateGrads[{n}].totalProfit" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.profit']}"></td>
                                            <td><input type="text"value="${rebateGrad.validPlayerNum}" name="rebateGrads[${status.index}].validPlayerNum" data-name="rebateGrads[{n}].validPlayerNum" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.validPlayer']}"></td>
                                            <td><input type="text" value="${rebateGrad.maxRebate}" class="form-control content-width-limit-8" name="rebateGrads[${status.index}].maxRebate" data-name="rebateGrads[{n}].maxRebate" placeholder="${views.setting_auto['可为空']}"></td>
                                            <td>
                                                <div class="_game input-group date content-width-limit-200 m-b-xs">
                                                    <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['返水费用']}</b></span>
                                                    <input type="number" class="form-control _ratio" name="rebateGrads[${status.index}].rakebackRatio" data-name="rebateGrads[{n}].rakebackRatio" value="${rebateGrad.rakebackRatio}">
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
                                                <div class="_game input-group date content-width-limit-200 m-b-xs">
                                                    <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['优惠费用']}</b></span>
                                                    <input type="number" class="form-control _ratio" name="rebateGrads[${status.index}].favorableRatio" data-name="rebateGrads[{n}].favorableRatio" value="${rebateGrad.favorableRatio}">
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
                                                <div class="_game input-group date content-width-limit-200 m-b-xs">
                                                    <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['其它费用']}</b></span>
                                                    <input type="number" class="form-control _ratio" name="rebateGrads[${status.index}].otherRatio" data-name="rebateGrads[{n}].otherRatio" value="${rebateGrad.otherRatio}">
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
                                            </td>
                                            <c:set var="game_status_index" value="0"/>
                                            <c:forEach items="${command.apiIds}" var="api">
                                                <td>
                                                    <c:forEach items="${command.someGames}" var="game" varStatus="game_status">
                                                        <c:set var="_someGame" value="0" />
                                                        <c:if test="${game['apiId'] eq api}">
                                                            <c:forEach items="${rebateGrad.rebateGradsApis}" var="rga" varStatus="apiStatus">
                                                                <c:if test="${game['apiId'] eq rga.apiId && game['gameType'] eq rga.gameType}">
                                                                    <c:set var="_someGame" value="1" />
                                                                    <div class="1 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
                                                                        <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                                                        <input type="hidden" value="${api}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiId" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].apiId">
                                                                        <input type="hidden" value="${game['gameType']}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].gameType" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].gameType">
                                                                        <input type="hidden" value="${game['apiTypeId']}" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].apiTypeId" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiTypeId">
                                                                        <input type="text" class="form-control _ratio _batch_ratio" value="${rga.ratio}" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].ratio"  data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].ratio">
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
                                                                <div class="2 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
                                                                    <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                                                    <input type="hidden" value="${api}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiId" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].apiId">
                                                                    <input type="hidden" value="${game['gameType']}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].gameType" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].gameType">
                                                                    <input type="text" class="form-control _ratio _batch_ratio" value="${rga.ratio}" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].ratio"  data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].ratio">
                                                                    <input type="hidden" value="${game.apiTypeId}" name="rebateGrads[${status.index}].rebateGradsApis[${game_status_index}].apiTypeId" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiTypeId">
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
                        <soul:button target="${root}/rebateSet/persist.html" refresh="true" callback="goToLastPage"  cssClass="btn btn-filter btn-lg m-r" post="getCurrentFormData" text="" opType="ajax" tag="button" precall="validateForm">
                            ${views.common['OK']}
                        </soul:button>
                    </div>
            </div>
        </div>
    </div>
</form:form>
<table class="table table-striped table-bordered table-hover dataTable m-b-none hide" id="foolishlyTable">
    <tr role="row" class="bg-color">
        <td rowspan="2">&nbsp;</td>
        <td rowspan="2"><h3>${views.setting['rebate.edit.totalProfit']} <i class="fa fa-question-circle m-l-sm"></i></h3></td>
        <td rowspan="2"><h3>${views.setting['rebate.edit.validPlayerNum']} <i class="fa fa-question-circle m-l-sm"></i></h3></td>
        <td rowspan="2"><h3>${views.setting['rebate.edit.max']}</h3></td>
        <td></td>
        <td colspan="${command.apiIds.size()}"><h3>${views.setting['rebate.edit.ratio']} <i class="fa fa-question-circle m-l-sm"></i></h3></td>


    </tr>
    <tr class="bg-color">
        <c:forEach items="${command.apiIds}" var="api">
            <td class="bg-gray"><b>${gbFn:getSiteApiName(api.toString())}</b></td>
        </c:forEach>
    </tr>
    <tr class="bg-color apiGrad">
        <td>
            <div class="ratio_area"></div>
            <soul:button target="deletePlan" text="" opType="function" cssClass="btn btn-danger" tag="button">
                ${views.common['delete']}
            </soul:button>
            <soul:button target="batchUpdateRatio" text="${views.setting['rebate.edit.batchRatio']}" opType="function" cssClass="btn batch_ratio" tag="button"></soul:button>
            <soul:button target="createPlan" text="${views.setting_auto['插入']}" opType="function" cssClass="btn btn-info" tag="button"></soul:button>
        </td>
        <td>
            <input type="hidden" name="rebateGrads[0].id" data-name="rebateGrads[{n}].id" value="">
            <input type="text" name="rebateGrads[0].totalProfit" data-name="rebateGrads[{n}].totalProfit" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.profit']}"></td>
        <td><input type="text" name="rebateGrads[0].validPlayerNum" data-name="rebateGrads[{n}].validPlayerNum" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.validPlayer']}"></td>
        <td><input type="text" class="form-control content-width-limit-8" name="rebateGrads[0].maxRebate" data-name="rebateGrads[{n}].maxRebate" placeholder="${views.setting_auto['可为空']}"></td>
        <td>
            <div class="_game input-group date content-width-limit-200 m-b-xs">
                <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['返水费用']}</b></span>
                <input type="number" class="form-control _ratio" name="rebateGrads[0].rakebackRatio" data-name="rebateGrads[{n}].rakebackRatio" value="">
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
            <div class="_game input-group date content-width-limit-200 m-b-xs">
                <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['优惠费用']}</b></span>
                <input type="number" class="form-control _ratio" name="rebateGrads[0].favorableRatio" data-name="rebateGrads[{n}].favorableRatio" value="">
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
            <div class="_game input-group date content-width-limit-200 m-b-xs">
                <span class="input-group-addon abroder-no" style="padding-left: 0;"><b>${views.operation_auto['其它费用']}</b></span>
                <input type="number" class="form-control _ratio" name="rebateGrads[0].otherRatio" data-name="rebateGrads[{n}].otherRatio" value="">
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
        </td>
        <c:set var="game_status_index" value="0"/>
        <c:forEach items="${command.apiIds}" var="api">
            <td>
                <c:forEach items="${command.someGames}" var="game" varStatus="game_status">
                    <c:if test="${game['apiId'] eq api}">

                        <div class="3 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
                            <span class="input-group-addon abroder-no" style="padding-left: 0;">
                                <b title="${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%>">
                                        ${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%>
                                </b>
                            </span>
                                <%--<input type="text" class="form-control">--%>
                                <%--TODO--%>
                            <input type="hidden" value="${api}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiId" name="rebateGrads[0].rebateGradsApis[${game_status_index}].apiId">
                            <input type="hidden" value="${game['gameType']}" data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].gameType"  name="rebateGrads[0].rebateGradsApis[${game_status_index}].gameType">
                            <input type="hidden" value="${game.apiTypeId}"   data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiTypeId" name="rebateGrads[0].rebateGradsApis[${game_status_index}].apiTypeId">
                            <input type="text" class="form-control _ratio _batch_ratio" value="${rga.ratio}" name="rebateGrads[0].rebateGradsApis[${game_status_index}].ratio"  data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].ratio">
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
<soul:import res="site/setting/rebate/Edit"/>