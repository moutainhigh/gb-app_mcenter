<%--@elvariable id="command" type="so.wwb.gamebox.model.master.setting.vo.RebateSetVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<style>
    ::-webkit-scrollbar {
        width: 14px;
        height: 7px;
    }

    ::-webkit-scrollbar-track {
        background-color: #eee;
    }

    ::-webkit-scrollbar-thumb {
        background-color: #c1c1c1
    }

    ::-webkit-scrollbar-thumb:hover {
        background-color: #c1c1c1
    }

    ::-webkit-scrollbar-thumb:active {
        background-color: #c1c1c1
    }

    .scrollInner {
        float: left;
        width: calc(100% - 831px);
        overflow-x: scroll
    }

    /* >1920*/
    @media screen and (min-width: 1920px) {
        .scrollInner {
            float: left;
            width: calc(100% - 320px);
            overflow-x: scroll
        }
    }

    /*1680 - 1920*/
    @media only screen and (min-width: 1680px) and (max-width: 1920px) {
        .scrollInner {
            float: left;
            width: calc(100% - 330px);
            overflow-x: scroll
        }

    }

    /*1440 - 1680*/
    @media only screen and (min-width: 1440px) and (max-width: 1680px) {
        .scrollInner {
            float: left;
            width: calc(100% - 560px);
            overflow-x: scroll
        }

    }

    /*1366 - 1440*/
    @media only screen and (min-width: 1366px) and (max-width: 1440px) {
        .scrollInner {
            float: left;
            width: calc(100% - 800px);
            overflow-x: scroll
        }

    }

    /*1280 - 1366*/
    @media only screen and (min-width: 1280px) and (max-width: 1366px) {
        .scrollInner {
            float: left;
            width: calc(100% - 883px);
            overflow-x: scroll
        }

    }

    /*1024- 1280*/
    /* @media only screen and (min-width: 1024px) and (max-width: 1280px) {
         .scrollInner{
             float: left;width: calc(100% - 883px);overflow-x: scroll
         }

     }*/

</style>
<form:form>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <gb:token/>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['运营']}</span><span>/</span><span>${views.sysResource['返佣设置']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
            <soul:button tag="a" target="goToLastPage" refresh="true" text="" opType="function"
                         cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
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
                            <a href="/rebateSet/copyRebateSet.html?search.id=${command.result.id}"
                               nav-target="mainFrame">${views.setting_auto['复制本方案']}</a>
                        </div>

                    </c:otherwise>
                </c:choose>
                <div class="form-group clearfix m-t">
                    <label class="ft-bold col-sm-3 al-right line-hi34"
                           for="result.name">${views.setting['rebate.edit.name']}</label>
                    <div class="col-sm-5 input-group">
                        <form:input path="result.name" cssClass="form-control"
                                    readonly="${command.result.id eq 0?true:false}"></form:input>
                        <form:hidden path="result.id"></form:hidden>
                    </div>

                </div>
                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34"
                           for="result.validValue">${views.setting['rebate.edit.validValue']}</label>
                    <div class="col-sm-5 input-group">
                        <form:input path="result.validValue" cssClass="form-control"></form:input>
                        <span data-content="${views.role['paylimit.setting.tips.validValue']}"
                              data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                              role="button" class="input-group-addon help-popover" tabindex="0"
                              data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <label class="ft-bold col-sm-3 al-right line-hi34"
                           for="result.remark">${views.setting['rebate.edit.remark']}:</label>
                    <div class="col-sm-5">
                        <form:textarea path="result.remark" cssClass="form-control"></form:textarea>
                    </div>
                </div>

                <div class="clearfix m">
                    <div class="table-responsive-e _tables">
                        <c:choose>
                            <c:when test="${empty command.rebateGrads}">
                                <table class="table table-striped table-bordered table-hover dataTable m-b-none">
                                    <tr role="row" class="bg-color apiGrad" style="width: 831px">

                                        <td rowspan="2" style="height: 197px;width:300px">
                                            <div class="ratio_area"></div>
                                            <button type="button"
                                                    class="btn btn-danger disabled">${views.common['delete']}</button>
                                            <soul:button target="batchUpdateRatio"
                                                         text="${views.setting_auto['批量调整比例']}" opType="function"
                                                         cssClass="btn batch_ratio" tag="button"></soul:button>
                                            <soul:button target="insertRow" text="${views.setting_auto['插入']}"
                                                         opType="function" cssClass="btn btn-info"
                                                         tag="button"></soul:button>
                                        </td>

                                        <!-- 盈利总额 -->
                                        <td rowspan="2" class="td-list">

                                            <div class="td-cont">
                                                <h3>
                                                        ${views.setting['rebate.edit.totalProfit']}
                                                    <i data-content="${views.setting['rebate.edit.showTitle']}"
                                                       class="m-l-sm help-popover"
                                                       data-placement="top" data-trigger="focus" data-toggle="popover"
                                                       data-container="body"
                                                       role="button" tabindex="0" data-original-title="" title="">
                                                        <i class="fa fa-question-circle"></i>
                                                    </i>
                                                </h3>
                                            </div>
                                            <div>
                                                <input type="hidden" name="rebateGrads[0].id" data-name="rebateGrads[{n}].id" value="">
                                                <input type="text" name="rebateGrads[0].totalProfit" data-name="rebateGrads[{n}].totalProfit" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.profit']}">
                                            </div>
                                        </td>

                                        <!--有效投注人数-->
                                        <td rowspan="2" class="td-list">
                                            <div class="td-cont"><h3>${views.setting['rebate.edit.validPlayerNum']}</h3>
                                            </div>
                                            <div>
                                                <input type="text" name="rebateGrads[0].validPlayerNum" data-name="rebateGrads[{n}].validPlayerNum" class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.validPlayer']}">
                                            </div>

                                        </td>

                                        <!--上限-->
                                        <td rowspan="2" class="td-list">
                                            <div class="td-cont ceiling"><h3>${views.setting['rebate.edit.max']}</h3>
                                            </div>
                                            <div>
                                                <input type="text" class="form-control content-width-limit-8" name="rebateGrads[0].maxRebate" data-name="rebateGrads[{n}].maxRebate" placeholder="${views.setting['rebate.edit.max']}${views.setting['rebate.edit.canBlank']}">
                                            </div>
                                        </td>

                                        <!--设置返佣分摊比例-->
                                        <td rowspan="2" class="td-list">
                                            <div class="td-cont"><h3>${views.operation_auto["设置返佣分摊比例"]}</h3></div>
                                            <div class="proportion">
                                                <div class="4 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
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

                                                <div class="4 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
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
                                            </div>
                                        </td>

                                        <td colspan="4">
                                            <h3>
                                                    ${views.setting['rebate.edit.ratio']}
                                                <i data-content="${views.setting['rebate.edit.rakeback']}"
                                                   class="m-l-sm help-popover"
                                                   data-placement="top" data-trigger="focus" data-toggle="popover"
                                                   data-container="body"
                                                   role="button" tabindex="0" data-original-title="" title="">
                                                    <i class="fa fa-question-circle"></i>
                                                </i>
                                            </h3>
                                        </td>
                                    </tr>

                                    <!--滚动条 开始-->

                                    <!--<tr class="bg-color"></tr>-->
                                    <tr class="bg-color scrollInner" id="" style="width:800px">
                                        <c:set var="game_status_index" value="0"/>
                                        <c:forEach items="${command.apiIds}" var="api">
                                            <td style="height:197px;width:190px">
                                                <div class="bg-grayf"><b>${gbFn:getSiteApiName(api.toString())}</b>
                                                </div>

                                                <c:forEach items="${command.someGames}" var="game"
                                                           varStatus="game_status">
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

                            </c:otherwise>
                        </c:choose>


                    </div>
                    <soul:button tag="button" target="createPlan" text="${views.common['create']}" opType="function"
                                 cssClass="btn btn-info btn-addon m-t pull-right">
                        <i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span>
                    </soul:button>
                </div>

                    <div class="operate-btn">
                        <soul:button target="${root}/rebateSet/persist.html" refresh="true" callback="goToLastPage"
                                     cssClass="btn btn-filter btn-lg m-r" post="getCurrentFormData" text="" opType="ajax"
                                     tag="button" precall="validateForm">
                            ${views.common['OK']}
                        </soul:button>
                    </div>
            </div>
        </div>
    </div>
</form:form>
<table class="table table-striped table-bordered table-hover dataTable m-b-none hide" id="foolishlyTable">
    <tr role="row" class="bg-color apiGrad" style="width: 831px">
        <td rowspan="2" style="height: 197px;width:300px">
            <div class="ratio_area"></div>
            <soul:button target="deletePlan" confirm="${views.common['confirm.delete']}" text="" opType="function"
                         cssClass="btn btn-danger" tag="button">
                ${views.common['delete']}
            </soul:button>
            <soul:button target="batchUpdateRatio" text="${views.setting_auto['批量调整比例']}" opType="function"
                         cssClass="btn batch_ratio" tag="button"></soul:button>
            <soul:button target="insertRow" text="${views.setting_auto['插入']}" opType="function" cssClass="btn btn-info"
                         tag="button"></soul:button>
        </td>

        <!-- 盈利总额 -->
        <td rowspan="2" class="td-list">
            <div>
                <input type="hidden" name="rebateGrads[0].id" data-name="rebateGrads[{n}].id" value="">
                <input type="text" name="rebateGrads[0].totalProfit" data-name="rebateGrads[{n}].totalProfit"
                       class="form-control content-width-limit-8" placeholder="${views.setting['rebate.edit.profit']}">
            </div>
        </td>

        <!--有效投注人数-->
        <td rowspan="2" class="td-list">
            <div>
                <input type="text" value="${rebateGrad.validPlayerNum}"
                       name="rebateGrads[${status.index}].validPlayerNum" data-name="rebateGrads[{n}].validPlayerNum"
                       class="form-control content-width-limit-8"
                       placeholder="${views.setting['rebate.edit.validPlayer']}">
            </div>

        </td>

        <!--上限-->
        <td rowspan="2" class="td-list">
            <div><input type="text" value="${rebateGrad.maxRebate}" class="form-control content-width-limit-8"
                        name="rebateGrads[${status.index}].maxRebate" data-name="rebateGrads[{n}].maxRebate"
                        placeholder="${views.setting_auto['可为空']}"></div>
        </td>

        <!--设置返佣分摊比例-->
        <td rowspan="2" class="td-list">
            <div class="proportion">
                <div class="4 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
                    <span class="input-group-addon abroder-no"
                          style="padding-left: 0;"><b>${views.operation_auto['返水费用']}</b></span>
                    <input type="number" class="form-control _ratio" name="rebateGrads[${status.index}].rakebackRatio"
                           data-name="rebateGrads[{n}].rakebackRatio" value="${rebateGrad.rakebackRatio}">
                    <span class="input-group-addon border-left-n">%</span>
                    <span class="input-group-addon adjust">
                                                        <soul:button tag="a" target="changeRatio" post="add" text=""
                                                                     cssClass="adjust up" opType="function">
                                                            <i class="fa fa-angle-up"></i>
                                                        </soul:button>
                                                        <soul:button tag="a" target="changeRatio" post="sub" text=""
                                                                     cssClass="adjust down" opType="function">
                                                            <i class="fa fa-angle-down"></i>
                                                        </soul:button>
                                            </span>
                </div>

                <div class="4 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
                    <span class="input-group-addon abroder-no"
                          style="padding-left: 0;"><b>${views.operation_auto['优惠费用']}</b></span>
                    <input type="number" class="form-control _ratio" name="rebateGrads[${status.index}].favorableRatio"
                           data-name="rebateGrads[{n}].favorableRatio" value="${rebateGrad.favorableRatio}">
                    <span class="input-group-addon border-left-n">%</span>
                    <span class="input-group-addon adjust">
                                                    <soul:button tag="a" target="changeRatio" post="add" text=""
                                                                 cssClass="adjust up" opType="function">
                                                        <i class="fa fa-angle-up"></i>
                                                    </soul:button>
                                                    <soul:button tag="a" target="changeRatio" post="sub" text=""
                                                                 cssClass="adjust down" opType="function">
                                                        <i class="fa fa-angle-down"></i>
                                                    </soul:button>
                                            </span>
                </div>
                <div class="_game input-group date content-width-limit-200 m-b-xs">

                    <span class="input-group-addon abroder-no"
                          style="padding-left: 0;"><b>${views.operation_auto['其它费用']}</b></span>
                    <input type="number" class="form-control _ratio" name="rebateGrads[${status.index}].otherRatio"
                           data-name="rebateGrads[{n}].otherRatio" value="${rebateGrad.otherRatio}">
                    <span class="input-group-addon border-left-n">%</span>
                    <span class="input-group-addon adjust">
                                                    <soul:button tag="a" target="changeRatio" post="add" text=""
                                                                 cssClass="adjust up" opType="function">
                                                        <i class="fa fa-angle-up"></i>
                                                    </soul:button>
                                                    <soul:button tag="a" target="changeRatio" post="sub" text=""
                                                                 cssClass="adjust down" opType="function">
                                                        <i class="fa fa-angle-down"></i>
                                                    </soul:button>
                                            </span>
                </div>
            </div>
        </td>

        <td colspan="4">
            <h3>
                ${views.setting['rebate.edit.ratio']}
                <i data-content="${views.setting['rebate.edit.rakeback']}" class="m-l-sm help-popover"
                   data-placement="top" data-trigger="focus" data-toggle="popover" data-container="body"
                   role="button" tabindex="0" data-original-title="" title="">
                    <i class="fa fa-question-circle"></i>
                </i>
            </h3>
        </td>
    </tr>

    <tr class="bg-color apiGrad scrollInner" style="width:800px">
        <c:forEach items="${command.apiIds}" var="api">
            <td style="height:197px;width:190px">

                <c:forEach items="${command.someGames}" var="game" varStatus="game_status">
                    <c:if test="${game['apiId'] eq api}">
                        <div class="4 _game input-group date content-width-limit-200${game_status.last ? '':' m-b-xs'}">
                            <span class="input-group-addon abroder-no"
                                  style="padding-left: 0;"><b>${dicts.game.game_type[game['gameType']]}<%--${gbFn:getGameTypeName(game['gameType'])}--%></b></span>
                                <%--<input type="text" class="form-control">--%>
                                <%--TODO--%>
                            <input type="hidden" value="${game.apiTypeId}"
                                   name="rebateGrads[0].rebateGradsApis[${game_status_index}].apiTypeId"
                                   data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiTypeId">
                            <input type="hidden" value="${api}"
                                   data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].apiId"
                                   name="rebateGrads[0].rebateGradsApis[${game_status_index}].apiId">
                            <input type="hidden" value="${game['gameType']}"
                                   data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].gameType"
                                   name="rebateGrads[0].rebateGradsApis[${game_status_index}].gameType">
                            <input type="text" class="form-control _ratio _batch_ratio" value="${rga.ratio}"
                                   name="rebateGrads[0].rebateGradsApis[${game_status_index}].ratio"
                                   data-name="rebateGrads[{n}].rebateGradsApis[${game_status_index}].ratio">
                            <span class="input-group-addon border-left-n">%</span>
                            <span class="input-group-addon adjust">
                                                            <soul:button tag="a" target="changeRatio" post="add" text=""
                                                                         cssClass="adjust up" opType="function">
                                                                <i class="fa fa-angle-up"></i>
                                                            </soul:button>
                                                            <soul:button tag="a" target="changeRatio" post="sub" text=""
                                                                         cssClass="adjust down" opType="function">
                                                                <i class="fa fa-angle-down"></i>
                                                            </soul:button>
                                                        </span>
                        </div>
                    </c:if>
                </c:forEach>

            </td>
        </c:forEach>
    </tr>
</table>
<soul:import res="site/setting/rebate/Edit"/>