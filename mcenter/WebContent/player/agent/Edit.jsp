<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserAgentVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row" id="agent_main">
    <!-- 面包屑 开始 -->
    <form:form><%--persist--%>
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['角色']}</span>
        <span>/</span><span>${views.sysResource['代理管理']}</span>
        <soul:button tag="a" target="goToLastPage" text="" opType="function" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <!-- 面包屑 结束 -->
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="present_wrap"><b>${empty command.result.id ? views.role['agent.createTitle']:views.role['agent.editTitle']}</b></div>
                    <div class="clearfix m-t-sm">
                        <%--表单内容--%>
                        <div class="dataTables_wrapper" role="grid">
                            <%--先插入数据库中--%>
                                <form:hidden path="result.id"></form:hidden>
                                <form:hidden path="sysUser.id"></form:hidden>
                                <input type="hidden" value="${command.result.registCode}" class="form-control m-b" name="result.registCode">
                                <input type="hidden" value="${command.editType}" name="editType">
                                    <div id="validateRule" style="display: none">${command.validateRule}</div>
                                    <%--跳轉模板編輯--%>
                                    <a nav-target="mainFrame" style="display:none" name="editTmpl" href="/noticeTmpl/tmpIndex.html?lastPage=t"><span></span></a>
                                    <%--必填项--%>
                                    <input type="hidden" value='${command.required}' name='required'>
                                    <%--固定注册项--%>
                                    <input type="hidden" value="${command.editSelectAgent}" name="editSelectAgent">
                                    <%--<c:if test="${command.editSelectAgent && command.result.id eq null}">--%>
                                        <%--<div class="form-group clearfix  m-b-sm">--%>
                                            <%--<label class="col-sm-3 al-right line-hi34 ft-bold" for="agentUserName"><span class="co-red m-r-sm">*</span>所属总代 :</label>--%>
                                            <%--<div class="col-sm-5"><input type="text" class="form-control" id="agentUserName" ${command.result.id eq null?'':'readonly disabled'} value="${command.agentUserName}" name="agentUserName" autocomplete="off"></div>--%>
                                        <%--</div>--%>

                                        <div class="form-group clearfix  m-b-sm">
                                            <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.column['VUserAgentManage.parentUsername']} :</label>
                                            <div class="col-sm-5">
                                                <c:choose>
                                                    <c:when test="${empty command.result.id}">
                                                        <gb:select name="agentUserId" list="${command.topAgents}" prompt=""
                                                                   value="${empty command.agentUserId ? command._defaultAgent:command.agentUserId}"
                                                                   listValue="username" callback="changeAgent" cssClass="btn-group chosen-select-no-single input-sm" listKey="id"></gb:select>
                                                        <input type="hidden" value="${command._defaultAgent}" id="_defaultAgent">
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${command.topAgentName}
                                                        <input type="hidden" value="${command.result.parentId}" id="_defaultAgent">
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>
                                        </div>

                                    <%--</c:if>--%>

                                    <%--<c:if test="${command.result.id eq null}">--%>
                                        <div class="form-group clearfix m-b-sm">
                                            <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.username"><span class="co-red m-r-sm">*</span>${views.column['VPlayerRecharge.username']} :</label>
                                            <div class="col-sm-5">
                                                <c:choose>
                                                       <c:when test="${empty command.result.id}">
                                                             <input name="sysUser.username" value="${command.sysUser.username}" autocomplete="off" class="form-control m-b" id="sysUser.username"/>
                                                       </c:when>
                                                        <c:otherwise>
                                                             <%--<input name="sysUser.username" value="${command.sysUser.username}" autocomplete="off" class="form-control m-b" id="sysUser.username"/>--%>
                                                            ${command.sysUser.username}
                                                        </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    <%--</c:if>--%>

                                    <c:if test="${empty command.result.id}">
                                        <div class="form-group clearfix m-b-sm">
                                            <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.password"><span class="co-red m-r-sm">*</span>${views.column['password']} :</label>
                                            <div class="col-sm-5">
                                                <%--<input type="password" placeholder="" class="form-control m-b" name="sysUser.password" value="${command.sysUser.password}">--%>
                                                <input style="display: none;">
                                                <form:password path="sysUser.password" cssClass="form-control m-b"></form:password>
                                            </div>
                                        </div>

                                        <div class="form-group clearfix m-b-sm">
                                            <label class="col-sm-3 al-right line-hi34 ft-bold" for="confirmPassword"><span class="co-red m-r-sm">*</span>${views.role['TopAgent.edit.confirmPassword']} :</label>
                                            <div class="col-sm-5">
                                                <%--<form:password path=""--%>
                                                <form:password path="confirmPassword" cssClass="form-control"></form:password>
                                            </div>
                                        </div>
                                    </c:if>


                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.role['agent.edit.playerRank']} :</label>
                                        <div class="col-sm-3">
                                            <div class="input-group date">
                                                <input type="hidden" name="result.oldAgentRankId" value="${command.result.playerRankId}"/>
                                                <gb:select name="result.playerRankId" list="${command.somePlayerRanks}" prompt="${views.common['pleaseSelect']}"
                                                           value="${command.result.playerRankId}" listValue="rankName" cssClass="btn-group chosen-select-no-single input-sm" listKey="id"></gb:select>
                                                <span tabindex="0" class=" help-popover input-group-addon" role="button" data-container="body" data-toggle="popover"
                                                      data-trigger="focus" data-placement="top" data-html="true"  data-content="${views.role['Agent.edit.rankTip']}<br>
                                                      <a nav-target='mainFrame' href='/vPlayerRankStatistics/list.html'>${views['Agent.edit.setRank']}</a>">
                                                    <i class="fa fa-question-circle"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <select class="hide chooseAOption">
                                        <option value="">${views.common['pleaseSelect']} </option>
                                    </select>
                                    <select class="hide chooseAAgent">
                                        <option value="">${views.role["agent.chooseAgentTop"]}</option>
                                    </select>
                                    <select class="hide chooseAgentNoData">
                                        <option value="">${views.role['agent.edit.chooseNoData']}</option>
                                    </select>

                                    <div class="form-group clearfix m-b-sm">
                                        <label class="col-sm-3 al-right line-hi34 ft-bold" for="userAgentRebate.rebateId"><span class="co-red m-r-sm">*</span>${views.role['topAgent.edit.rebatePlan']} :</label>
                                        <div class="col-sm-3">
                                            <div  class="input-group date rebate">
                                                <%--userAgentRebate--%>
                                                    <input type="hidden" value="${command.userAgentRebate.rebateId}" name="oldRebateId" id="oldRebateId">
                                                    <form:hidden path="userAgentRebate.id"></form:hidden>
                                                    <form:hidden path="userAgentRebate.userId"></form:hidden>
                                                    <gb:select name="userAgentRebate.rebateId" prompt="${views.role['agent.chooseAgentRebate']}"
                                                               value="${command.userAgentRebate.rebateId}" list="${command.vPrograms['rebate']}" listKey="programId"
                                                               listValue="name" cssClass="btn-group chosen-select-no-single input-sm forAgentSelect"></gb:select><%--TODO--%>
                                                <span tabindex="0" class=" help-popover input-group-addon" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top" data-html="true"  data-content="${views.role['Agent.edit.agentRabateTip']}<br>${views.role['Agent.edit.agentChangeRabateTip']}<br><a href='/rebateSet/list.html' nav-target='mainFrame'>${views.role['Agent.edit.setRebate']}</a>"><i class="fa fa-question-circle"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <%--编辑时不显示时区--%>
                                    <c:if test="${empty command.sysUser.id}">
                                        <div class="form-group clearfix m-b-sm">
                                            <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.column['defaultTimezone']}<%--defaultTimezone--%> :</label>
                                            <div class="col-sm-3">
                                                <gb:select name="sysUser.defaultTimezone" prompt="" value="${command.sysUser.defaultTimezone}" list="${command.timeZone}" cssClass="btn-group chosen-select-no-single input-sm"></gb:select>
                                                <div class="m-t-xs "><i class="fa fa-exclamation-circle co-orange "></i>&nbsp;&nbsp;${views.role['agent.defaultTimezone.tips']}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty command.sysUser.id}">
                                        <input class="hide" name="sysUser.defaultTimezone" value="${command.sysUser.defaultTimezone}">
                                    </c:if>
                                    <c:set value="0" var="c_index"></c:set>
                                    <c:set value="0" var="c_index_1"></c:set>
                                    <c:forEach items="${command.fieldSorts}" varStatus="" var="f">
                                        <%--${views.column[f.name]}&nbsp;${f.name}<br>--%>
                                        <c:choose>
                                            <c:when test="${f.name eq 'defaultLocale'}">
                                                <%--主语言--%>
                                                <div class="form-group clearfix m-b-sm">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm">*</span>
                                                        </c:if>
                                                        ${views.column[f.name]} :
                                                    </label>
                                                    <div class="col-sm-5">
                                                        <gb:select name="sysUser.defaultLocale" value="${command.sysUser.defaultLocale}" ajaxListPath="${root}/userAgent/getDefaultLocale.html" prompt="${views.common['pleaseSelect']}" listValue="status" listKey="language" cssClass="btn-group chosen-select-no-single input-sm"/>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:when test="${f.name eq 'sex'}">
                                                <%--性别--%>
                                                <div class="form-group clearfix m-b-sm">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm">*</span>
                                                        </c:if>
                                                        ${views.column[f.name]} :
                                                    </label>

                                                    <div class="col-sm-5 ${command.sysUser.sex eq ''}">
                                                        <gb:select name="sysUser.sex" value="${command.sysUser.sex}" ajaxListPath="${root}/userAgent/getSex.html" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:when test="${f.name eq 'mainCurrency'}">
                                                <%--主货币 default_currency--%>
                                                <%--编辑时不显示主货币--%>
                                                <c:if test="${empty command.sysUser.id}">
                                                    <div class="form-group clearfix m-b-sm">
                                                        <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                            <c:if test="${f.isRequired ne '2'}">
                                                                <span class="co-red m-r-sm">*</span>
                                                            </c:if>
                                                            ${views.column[f.name]} :
                                                        </label>

                                                        <div class="col-sm-5">
                                                            <c:choose>
                                                                <c:when test="">

                                                                </c:when>
                                                                <c:otherwise>
                                                                  <gb:select name="sysUser.defaultCurrency" value="${command.sysUser.defaultCurrency}" ajaxListPath="${root}/userAgent/getMainCurrency.html" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>

                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty command.sysUser.id}">
                                                    <input type="hidden" name="sysUser.defaultCurrency" value="${command.sysUser.defaultCurrency}">
                                                </c:if>
                                            </c:when>
                                            <c:when test="${f.name eq 'birthday'}">
                                                <%--生日 birthday--%>
                                                <div class="form-group clearfix m-b-sm">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm">*</span>
                                                        </c:if>
                                                        ${views.column[f.name]} :</label>
                                                    <div class="col-sm-5">
                                                        <div class="input-group date"> <span class="">
                                                            <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" opens="right" showDropdowns="true"
                                                                          name="sysUser.birthday" position="up" useRange="false"
                                                                          value="${command.sysUser.birthday}" ></gb:dateRange>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>


                                            <c:when test="${f.name eq 'securityIssues'}">
                                                <%--安全问题1--%>
                                                <div class="form-group clearfix m-b-sm">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm">*</span>
                                                        </c:if>
                                                            ${views.player_auto['安全问题']} :
                                                    </label>

                                                    <div class="col-sm-5 input-group">
                                                        <span class="input-group-btn">
                                                            <gb:select name="sysUserProtection.question1" ajaxListPath="${root}/userAgent/getMasterQuestion/question1.html" value="${command.sysUserProtection.question1}" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>
                                                        </span>
                                                        <input type="text" class="form-control" name="sysUserProtection.answer1" value="${command.sysUserProtection.answer1}">
                                                        <input type="hidden" name="sysUserProtection.id" value="${command.sysUserProtection.id}">
                                                    </div>
                                                </div>
                                                <%--安全问题2--%>
                                                <%--<div class="form-group clearfix m-b-sm">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm">*</span>
                                                        </c:if>
                                                            ${views.column['question2']} :
                                                    </label>

                                                    <div class="col-sm-5 input-group">
                                                        <span class="input-group-btn">
                                                            <gb:select name="sysUserProtection.question2" ajaxListPath="${root}/userAgent/getMasterQuestion/question2.html" value="${command.sysUserProtection.question2}" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>
                                                        </span>
                                                        <input type="text" class="form-control" name="sysUserProtection.answer2" value="${command.sysUserProtection.answer2}">
                                                        <input type="hidden" name="sysUserProtection.id" value="${command.sysUserProtection.id}">
                                                    </div>
                                                </div>--%>
                                                <%--安全问题3--%>
                                                <%--<div class="form-group clearfix m-b-sm">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm">*</span>
                                                        </c:if>
                                                            ${views.column['question3']} :
                                                    </label>

                                                    <div class="col-sm-5 input-group">
                                                        <span class="input-group-btn">
                                                            <gb:select name="sysUserProtection.question3" ajaxListPath="${root}/userAgent/getMasterQuestion/question3.html" value="${command.sysUserProtection.question3}" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>
                                                        </span>
                                                        <input type="text" class="form-control" name="sysUserProtection.answer3" value="${command.sysUserProtection.answer3}">
                                                        <input type="hidden" name="sysUserProtection.id" value="${command.sysUserProtection.id}">
                                                    </div>
                                                </div>--%>
                                            </c:when>

                                            <c:when test="${f.name eq 'username'}">
                                                <%--用户名 --%>
                                                <div class="form-group clearfix m-b-xxs">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.${f.name}">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                        </c:if>${views.column[f.name]} :
                                                    </label>
                                                    <div class="col-sm-5">
                                                        <input value="${sysUser.username}" type="text" class="form-control m-b" name="sysUser.${f.name}">
                                                    </div>
                                                </div>


                                            </c:when>

                                            <c:when test="${f.name eq 'password'}">
                                                <%--密码 --%>
                                                <div class="form-group clearfix m-b-xxs">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.${f.name}">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                        </c:if>${views.column[f.name]} :
                                                    </label>
                                                    <div class="col-sm-5">
                                                        <input value="" type="text" class="form-control m-b" name="sysUser.${f.name}">
                                                    </div>
                                                </div>


                                            </c:when>

                                            <c:when test="${f.name eq 'paymentPassword'}">
                                                <%--权限密码 --%>
                                                <c:if test="${ empty command.result.id}">
                                                    <div class="form-group clearfix m-b-xxs">
                                                        <label class="col-sm-3 al-right line-hi34 ft-bold">
                                                            <c:if test="${f.isRequired ne '2'}">
                                                                <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                            </c:if>${views.column[f.name]} :
                                                        </label>
                                                        <div class="col-sm-5">
                                                            <input value="" type="password" class="form-control m-b" name="sysUser.permissionPwd">
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:when>
                                            <c:when test="${f.name eq 'realName'}">
                                                <%--真实姓名 --%>
                                                <div class="form-group clearfix m-b-sm">
                                                    <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.${f.name}">
                                                        <c:if test="${f.isRequired ne '2'}">
                                                            <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                        </c:if>${views.column[f.name]} :
                                                    </label>
                                                    <div class="col-sm-5">
                                                        <div  class="input-group date">
                                                            <input type="text" class="form-control m-b" value="${command.sysUser.realName}" name="sysUser.${f.name}">
                                                            <span class="input-group-addon abroder-no "><i class="fa fa-exclamation-circle co-orange"></i>&nbsp;&nbsp;${views.role['agent.realname.tips']}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>

                                            <%--联系方式--%>
                                            <c:when test="${f.name eq '301'}">
                                                <%--qq--%>
                                                    <div class="form-group clearfix m-b-xxs">
                                                         <label class="col-sm-3 al-right line-hi34 ft-bold" for="qq.contactValue">
                                                            <c:if test="${f.isRequired ne '2'}">
                                                                <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                            </c:if>${dicts.notice.contact_way_type[f.name]} :
                                                        </label>
                                                        <div class="col-sm-5">
                                                            <input type="hidden" value="${f.name}" name="qq.contactType">

                                                            <c:set value="" var="contactValue_301"/>
                                                            <c:forEach items="${command.noticeContactWays}" var="notice">
                                                                <c:if test="${notice.contactType eq '301'}">
                                                                    <c:set value="${notice.contactValue}" var="contactValue_301"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <input type="text" value="${contactValue_301}" class="form-control m-b" id="qq.contactValue" name="qq.contactValue">
                                                            <input type="hidden" name="qq.userId" value="${command.result.id}">
                                                        </div>
                                                    </div>
                                            </c:when>
                                            <c:when test="${f.name eq '304'}">
                                                    <div class="form-group clearfix m-b-xxs">
                                                         <label class="col-sm-3 al-right line-hi34 ft-bold" for="weixin.contactValue">
                                                            <c:if test="${f.isRequired ne '2'}">
                                                                <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                            </c:if>${dicts.notice.contact_way_type[f.name]} :
                                                        </label>
                                                        <div class="col-sm-5">
                                                            <input type="hidden" value="${f.name}" name="weixin.contactType">

                                                            <c:set value="" var="contactValue_304"/>
                                                            <c:forEach items="${command.noticeContactWays}" var="notice">
                                                                <c:if test="${notice.contactType eq '304'}">
                                                                    <c:set value="${notice.contactValue}" var="contactValue_304"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <input type="text" value="${contactValue_304}" class="form-control m-b" id="weixin.contactValue" name="weixin.contactValue">
                                                            <input type="hidden" name="weixin.userId" value="${command.result.id}">
                                                        </div>
                                                    </div>
                                            </c:when>
                                            <c:when test="${f.name eq '201'}">
                                                <%--email--%>
                                                    <div class="form-group clearfix m-b-xxs">
                                                         <label class="col-sm-3 al-right line-hi34 ft-bold" for="email.contactValue">
                                                            <c:if test="${f.isRequired ne '2'}">
                                                                <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                            </c:if>${dicts.notice.contact_way_type[f.name]} :
                                                        </label>
                                                        <div class="col-sm-5">
                                                            <input type="hidden" value="${f.name}" name="email.contactType">

                                                            <c:set value="" var="contactValue_201"/>
                                                            <c:forEach items="${command.noticeContactWays}" var="notice">
                                                                <c:if test="${notice.contactType eq '201'}">
                                                                    <c:set value="${notice.contactValue}" var="contactValue_201"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <input type="text" value="${contactValue_201}" class="form-control m-b inputMailList" id="email.contactValue" name="email.contactValue">
                                                            <input type="hidden" name="email.userId" value="${command.result.id}">
                                                        </div>
                                                    </div>
                                            </c:when>
                                            <c:when test="${f.name eq '110'}">
                                                <%--phone--%>
                                                    <div class="form-group clearfix m-b-xxs">
                                                         <label class="col-sm-3 al-right line-hi34 ft-bold" for="phone.contactValue">
                                                            <c:if test="${f.isRequired ne '2'}">
                                                                <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                            </c:if>${dicts.notice.contact_way_type[f.name]} :
                                                        </label>
                                                        <div class="col-sm-5">
                                                            <input type="hidden" value="${f.name}" name="phone.contactType">

                                                            <c:set value="" var="contactValue_110"/>
                                                            <c:forEach items="${command.noticeContactWays}" var="notice">
                                                                <c:if test="${notice.contactType eq '110'}">
                                                                    <c:set value="${notice.contactValue}" var="contactValue_110"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <input type="text" value="${contactValue_110}" class="form-control m-b" id="phone.contactValue" name="phone.contactValue">
                                                            <input type="hidden" name="phone.userId" value="${command.result.id}">
                                                        </div>
                                                    </div>
                                            </c:when>

                                            <c:when test="${f.name eq 'constellation'}">
                                                <div class="form-group clearfix m-b-sm">
                                                    <label  class="col-sm-3 al-right line-hi34 ft-bold">${views.role['TopAgent.edit.constellation']} :</label>
                                                    <div class="col-sm-3">
                                                        <gb:select name="sysUser.constellation" value="${command.sysUser.constellation}" list="${command.dictConstellation}" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single constellation"/>
                                                    </div>
                                                </div>
                                            </c:when>

                                            <c:otherwise>
                                                <%--其他都是联系方式--%>
                                                <div class="form-group clearfix m-b-xxs">

                                                    <c:forEach items="${command.contact}" var="c" varStatus="status">
                                                        <c:if test="${c.value.dictCode eq f.name}">
                                                            <c:set value="0" var="isNotice"></c:set>
                                                            <c:forEach items="${command.noticeContactWays}" var="notice">
                                                                <c:if test="${notice.contactType eq c.value.dictCode}">

                                                                    <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.${f.name}">
                                                                        <c:if test="${f.isRequired ne '2'}">
                                                                            <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                                        </c:if>${dicts.notice.contact_way_type[c.value.dictCode]} :
                                                                    </label>
                                                                    <div class="col-sm-5">
                                                                        <input type="hidden" value="${c.value.dictCode}" name="noticeContactWays[${status.index}].contactType">
                                                                        <input type="text" value="${notice.contactValue}" class="form-control m-b" name="noticeContactWays[${status.index}].contactValue">
                                                                        <input type="hidden" name="noticeContactWays[${status.index}].id"  value="${notice.id}">
                                                                        <input type="hidden" name="noticeContactWays[${status.index}].userId" value="${notice.userId}">
                                                                    </div>
                                                                    <c:set value="1" var="isNotice"></c:set>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${isNotice eq 0}">

                                                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.${f.name}">
                                                                    <c:if test="${f.isRequired ne '2'}">
                                                                        <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                                                    </c:if>${dicts.notice.contact_way_type[c.value.dictCode]} :
                                                                </label>
                                                                <div class="col-sm-5">
                                                                    <input type="hidden" value="${c.value.dictCode}" name="noticeContactWays[${status.index}].contactType">
                                                                    <input type="text" class="form-control m-b" name="noticeContactWays[${status.index}].contactValue">
                                                                </div>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                            </div>
                        <%--表单内容 end--%>
                    </div>

                <%--按钮--%>
                <div class="operate-btn">
                        <%--<a href="javascript:void(0)" class="btn btn-filter btn-lg">${views.player_auto['确认']}</a>--%>
                    <soul:button target="${root}/userAgent/updateAgent.html" text="${views.common['OK']}" cssClass="btn btn-filter btn-lg" precall="myValidateForm" opType="ajax" post="getCurrentFormData" callback="goToLastPage" refresh="true">${views.common['OK']}</soul:button>
                    <soul:button target="goToLastPage"  text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter btn-lg" opType="function">${views.common['cancel']}</soul:button>

                </div>
            </div>
        </div>
    </form:form>
</div>

<%--<%@ include file="/include/include.js.jsp" %>--%>
<!--//region your codes 4-->
<soul:import res="site/player/agent/Edit"/>
