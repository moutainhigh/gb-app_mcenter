<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-9-11
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserAgentVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <!-- 面包屑 开始 -->
    <form:form>
        <gb:token></gb:token>
        <input type="hidden" name="required">
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['角色']}</span>
        <span>/</span><span>${views.sysResource['总代管理']}</span>
        <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <!-- 面包屑 结束 -->
    <div class="col-lg-12" id="editbody-div">
        <div class="wrapper white-bg shadow" id="editcontent-div">
            <div class="present_wrap">
                <b>${empty command.result.id ? views.role['topAgent.edit.createAgent']:views.role['topAgent.edit.editAgent']}</b>
            </div>
                    <div class="clearfix m-t-sm">
                        <form:hidden path="result.id"></form:hidden>
                        <form:hidden path="sysUser.id"></form:hidden>
                        <input type="hidden" name="result.addNewPlayer" value="false">
                        <input type="hidden" value="false" id="validate_ratio" name="validateRatio">
                        <div id="validateRule" style="display:none">${command.validateRule}</div>
                        <input type="hidden" value="topAgent" name="editType">
                        <div id="editable_wrapper" class="dataTables_wrapper" role="grid">
                            <div>
                                <div class="form-group clearfix m-b-sm line-hi34 ">
                                    <label class="col-sm-3 al-right ft-bold"><span class="co-red m-r-sm">*</span>${views.column['VPlayerRecharge.username']} :</label>
                                    <div class="col-sm-5">
                                        <c:choose>
                                            <c:when test="${empty command.result.id}">
                                                <input type="text" name="sysUser.username" value="${command.sysUser.username}" class="form-control">
                                            </c:when>
                                            <c:otherwise>
                                                ${command.sysUser.username}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <c:if test="${empty command.result.id}">
                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.column['password']} :</label>
                                        <div class="col-sm-5"><input type="password"  class="form-control" name="sysUser.password"></div>
                                    </div>
                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.role['TopAgent.edit.confirmPassword']} :</label>
                                        <div class="col-sm-5"><input type="password"  class="form-control" name="confirmPassword"></div>
                                    </div>
                                </c:if>

                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.role['topAgent.edit.rebatePlan']} :</label>
                                    <div class="col-sm-5 line-hi34">
                                        <c:forEach items="${command.rebateSets}" var="rebate" varStatus="status">
                                            <c:set var="_checked" value="0"></c:set>

                                            <c:forEach items="${command.vPrograms['rebate']}" var="m">
                                                <c:if test="${rebate.id eq m.programId}">
                                                  <span><input type="checkbox" name="rebateIds" checked class="i-checks" value="${rebate.id}">${rebate.name}</span>
                                                    <c:set var="_checked" value="1"></c:set>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${_checked eq '0'}">
                                                  <span><input type="checkbox" class="i-checks" name="rebateIds" value="${rebate.id}">${rebate.name}</span>
                                            </c:if>
                                        </c:forEach>
                                        <span tabindex="0" class=" help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.role['TopAgent.edit.rebateTip1']}<br>${views.role['TopAgent.edit.rebateTip2']}<br><a href='/rebateSet/list.html' nav-target='mainFrame'>${views.role['TopAgent.edit.rebateTip3']}</a>" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>
                                <%--<div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.role['topAgent.edit.rakebackPlan']} :</label>
                                    <div class="col-sm-5 line-hi34">
                                        <c:forEach items="${command.rakebackSets}" var="rakeback" varStatus="status">
                                        <c:set value="0" var="_checked"></c:set>
                                            <c:forEach items="${command.vPrograms['rakeback']}" var="r">
                                                <c:if test="${r.programId eq rakeback.id}">
                                                    <c:set value="1" var="_checked"></c:set>
                                                    <span><input type="checkbox" name="rakebackIds" checked class="i-checks" value="${rakeback.id}">${rakeback.name}</span>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${_checked eq '0'}">
                                                    <span><input type="checkbox" name="rakebackIds" class="i-checks" value="${rakeback.id}">${rakeback.name}</span>
                                            </c:if>
                                        </c:forEach>
                                        &lt;%&ndash;<label><input type="checkbox" class="i-checks" value="1">方案2</label>&ndash;%&gt;
                                        &lt;%&ndash;<label><input type="checkbox" class="i-checks" value="1">方案3</label>&ndash;%&gt;
                                        <span tabindex="0" class=" help-popover" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.role['TopAgent.edit.rebackTip1']}<br>${views.role['TopAgent.edit.rebackTip2']}<br><a href='/setting/vRakebackSet/list.html' nav-target='mainFrame'>${views.role['TopAgent.edit.rebackTip3']}</a>" data-original-title="" title=""><i class="fa fa-question-circle"></i></span>
                                    </div>
                                </div>--%>


                                    <%--时区开始--%>
                                <c:if test="${empty command.result.id}">
                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.column['defaultTimezone']} :</label>
                                    <div class="col-sm-3">
                                        <gb:select name="sysUser.defaultTimezone" prompt="" value="${command.sysUser.defaultTimezone}" list="${command.timeZone}" cssClass="btn-group chosen-select-no-single"></gb:select>
                                    </div>
                                </div>
                                </c:if>
                                <%--时区结束--%>
                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span> ${views.column['realName']} :</label>
                                    <div class="col-sm-5"><input type="text" name="sysUser.realName"  value="${command.sysUser.realName}" class="form-control"></div>
                                </div>
                                <%--主货币--%>
                                <c:if test="${empty command.result.id}">
                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                        <span class="co-red m-r-sm">*</span>
                                            ${views.column['mainCurrency']} :
                                    </label>
                                    <div class="col-sm-5">
                                        <c:choose>
                                            <c:when test="${empty command.result.id}">
                                                    <gb:select name="sysUser.defaultCurrency" value="${command.sysUser.defaultCurrency}" list="${command.dictCurrency}" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single input-sm"/>
                                            </c:when>
                                            <c:otherwise>
                                                ${dicts.common.currency[command.sysUser.defaultCurrency]}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                </c:if>
                                <%--主货币结束--%>

                                <%--主语言--%>
                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                            ${views.column['defaultLocale']} :
                                    </label>
                                        <%----%>
                                    <div class="col-sm-5">
                                        <gb:select name="sysUser.defaultLocale" value="${command.sysUser.defaultLocale}" ajaxListPath="${root}/userAgent/getDefaultLocale.html" prompt="${views.common['pleaseSelect']}" listValue="status" listKey="language" cssClass="btn-group chosen-select-no-single input-sm"/>
                                    </div>
                                </div>
                                <%--主语言 开始--%>
                                <c:set var="contact_index" value="0"></c:set>
                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold">${dicts.content.contact_way_type['110']} :</label>
                                    <div class="col-sm-5">
                                        <input type="text"  name="phone.contactValue" value="${command.noticeContactWayMap['110'].contactValue}" class="form-control">
                                        <input type="hidden" value="110" name="phone.contactType">
                                    </div>
                                </div>

                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold">${dicts.content.contact_way_type['201']} :</label>
                                    <div class="col-sm-5">
                                        <input type="text" placeholder="${views.role['agent.edit.mailPlaceholder']}" name="email.contactValue" value="${command.noticeContactWayMap['201'].contactValue}" class="form-control inputMailList">
                                        <input type="hidden" value="201" name="email.contactType">
                                    </div>
                                </div>
                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold">${views.column['sex']} :</label>
                                    <div class="col-sm-3">
                                        <gb:select name="sysUser.sex" value="${command.sysUser.sex}" ajaxListPath="${root}/userAgent/getSex.html" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single"/>
                                    </div>
                                </div>
                                <c:if test="${not empty command.result.id}">

                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold">${views.column['birthday']} :</label>
                                        <div class="col-sm-5">
                                            <div class="input-group date">
                                                <gb:dateRange format="${DateFormat.DAY}"  style="width:100px" callback="changeConstellation"
                                                              showDropdowns="true" opens="right"  position="up" useRange="false"
                                                              maxDate="${command.now}" name="sysUser.birthday" value="${command.sysUser.birthday}"></gb:dateRange>
                                            </div>
                                        </div>
                                    </div>
                                    <%--星座--%>
                                    <div class="form-group clearfix m-b-sm">
                                        <label  class="col-sm-3 al-right line-hi34 ft-bold">${views.role['TopAgent.edit.constellation']}</label>
                                        <div class="col-sm-3">
                                            <gb:select name="sysUser.constellation" value="${command.sysUser.constellation}" list="${command.dictConstellation}" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single constellation"/>
                                        </div>
                                    </div>

                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold" for="weixin.contactValue">${dicts.content.contact_way_type['304']} :</label>
                                        <div class="col-sm-5">
                                            <input type="text"  name="weixin.contactValue" id="weixin.contactValue" value="${command.noticeContactWayMap['304'].contactValue}" class="form-control">
                                            <input type="hidden" value="304" name="weixin.contactType" id="weixin.contactType">
                                        </div>
                                    </div>
                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold" for="qq.contactValue">${dicts.content.contact_way_type['301']} :</label>
                                        <div class="col-sm-5">
                                            <input type="text"  name="qq.contactValue" id="qq.contactValue" value="${command.noticeContactWayMap['301'].contactValue}" class="form-control">
                                            <input type="hidden" value="301" name="qq.contactType" id="qq.contactType">
                                        </div>
                                    </div>
                                    <%--<div class="form-group clearfix  m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold" for="msn.contactValue">${dicts.content.contact_way_type['302']} :</label>
                                        <div class="col-sm-5">
                                            <input type="text"  name="msn.contactValue" id="msn.contactValue" value="${command.noticeContactWayMap['302'].contactValue}" class="form-control">
                                            <input type="hidden" value="302" name="msn.contactType" id="msn.contactType">
                                        </div>
                                    </div>--%>
<%--                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                ${views.column['securityIssues']} :
                                        </label>

                                        <div class="col-sm-5 input-group">
                                            <span class="input-group-addon bdn al-left">
                                                <gb:select name="sysUserProtection.question1" ajaxListPath="${root}/userAgent/getMasterQuestion.html" value="${command.sysUserProtection.question1}" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>
                                            </span>
                                            <input type="text" class="form-control" name="sysUserProtection.answer1" value="${command.sysUserProtection.answer1}">
                                            <input type="hidden" name="sysUserProtection.id" value="${command.sysUserProtection.id}">
                                        </div>
                                    </div>--%>

                                </c:if>
                                <div class="form-group clearfix m-b-sm">
                                    <label class="col-sm-3 al-right line-hi34 ft-bold">${views.column['resource']} :</label>
                                    <div class="col-sm-5">
                                        <textarea class="form-control" name="result.promotionResources">${command.result.promotionResources}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="operate-btn">
                        <%--<button class="btn btn-filter btn-lg" data-toggle="modal"  data-dismiss="modal" data-target="#audit">下一步，设置占成</button>--%>
                        <c:choose>
                            <c:when test="${empty command.result.id}">
                                <soul:button target="openSetRatio" cssClass="btn btn-filter btn-lg" text="" opType="function" precall="validateForm">
                                    ${views.role['topAgent.edit.nextStep']}
                                </soul:button>
                                <%--//测试用--%>
                                <%--<soul:button target="${root}/userAgent/toApiSet.html" title="${views.role['topAgent.edit.nextStep']}"
                                             text="${views.role['topAgent.edit.nextStep']}" opType="dialog"/>--%>
                            </c:when>
                            <c:otherwise>
                                <soul:button target="${root}/userAgent/persistTopAgent.html" text="" cssClass="btn btn-filter btn-lg" precall="validateForm" opType="ajax" post="getCurrentFormData" callback="goToLastPage" refresh="true">${views.common['completed']}</soul:button>
                            </c:otherwise>
                        </c:choose>
                        <%--<a href="javascript:void(0)" class="btn btn-outline btn-filter btn-lg">${views.common_report['取消']}</a>--%>
                        <soul:button target="goToLastPage" text="" cssClass="btn btn-outline btn-filter btn-lg" opType="function" >${views.common['cancel']}</soul:button>
                    </div>
                </div>
        </div>
            <c:if test="${empty command.result.id}">
                <%--设置占成--%>
                <div class="modal inmodal bs-example-modal-lg fade" id="setRatio" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content animated bounceInRight unstyled family">
                            <%--可填充--%>
                                <div class="modal-header">
                                    <span class="filter">${views.role['topAgent.edit.createAgent']}—${views.role['topAgent.edit.setRatio']}</span>
                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">${views.comon['close']}</span> </button>
                                </div>
                                <div class="modal-body" data-load="true">
                                    <div class="clearfix">
                                        <div class="form-group clearfix m-b-sm col-xs-6 p-x">
                                            <label class="form_lab_block line-hi34 m-r-sm"><b>${views.role['topAgent.detail.ratioEdit.topAgentAccount']} : </b></label>
                                            <div class="col-xs-6 p-x line-hi34">
                                                <a href="javascript:void(0)" class="_userName"></a>
                                            </div>
                                        </div>
                                        <div class="form-group clearfix m-b-sm col-xs-4 p-x pull-right">
                                            <div class="input-group date">
                                                <input type="text" class="form-control" id="batchSetInput" name="batchSetInput">
                                                <span class="input-group-addon">%</span>
                                                <span class="input-group-btn">
                                                    <soul:button target="batchSet" text="" opType="function" cssClass="btn btn-filter">
                                                        <span class="hd">${views.role['topAgent.detail.ratioEdit.batchSet']}</span>
                                                    </soul:button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <%--为预览准备--%>
                                    <soul:button target="savePreview" text="" cssClass="btn btn-filter btn-lg" opType="function" refresh="true" precall="validateForm">${views.common['previewAndSave']}</soul:button>
                                    <%--<soul:button target="${root}/userAgent/persistTopAgent.html" text="" cssClass="btn btn-filter btn-lg" precall="myValidateForm" opType="ajax" post="getCurrentFormData" callback="goToLastPage" refresh="true">${views.common['OK']}</soul:button>--%>
                                        <%--<button type="button" class="btn btn-filter">${views.player_auto['确定']}</button>--%>
                                    <soul:button target="cancelSetting"  text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter btn-lg" opType="function">${views.common['cancel']}</soul:button>
                                </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </form:form>
</div>
<soul:import res="site/player/topagent/Edit"/>
