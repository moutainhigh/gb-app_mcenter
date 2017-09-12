<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <link href="${resComRoot}/themes/${curTheme}/style.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/content.css" rel="stylesheet">
</head>
<body>
<!--编辑弹窗-->
<div class="row" name="playerViewDiv">
<form:form id="editForm" action="${root}/player/updateUserPlayerAndPlayerTag.html" method="post">
<form:hidden path="result.id"></form:hidden>
        <gb:token></gb:token>
<input value="${command.parentRakebackId}" type="hidden" id="parentRakebackId">
<form:hidden path="required"/>
<form:hidden path="comeFrom"></form:hidden>
<div id="validateRule" style="display: none">${command.validateRule}</div>
<a href="/player/getVUserPlayer.html?search.id=${command.result.id}" nav-target="mainFrame" name="returnView" style="display: none"></a>
<!-- 面包屑 开始 -->
<div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
    <span>${views.sysResource['角色']}</span>
    <span>/</span><span>${views.sysResource['玩家管理']}</span>
    <c:if test="${command.comeFrom=='detail'}">
        <soul:button target="toPlayerDetail" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </c:if>
    <c:if test="${command.comeFrom!='detail'}">
        <soul:button target="goToLastPage" refresh="true"
                     cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </c:if>

</div>
<!-- 面包屑 结束 -->
    <div class="col-lg-12">
<div class="wrapper white-bg shadow">
    <div class="present_wrap"><b>${views.common['edit']}</b></div>
    <!-- 工具栏 开始 -->
    <div class="clearfix m-t-sm">

        <!--

                        </div>
                        <!-- 工具栏 结束 -->

        <!-- 筛选条件 结束 -->
        <!--表格内容 开始-->
        <div id="editable_wrapper" class="dataTables_wrapper" role="grid">

            <!-- 表格 开始 -->
            <div class="">
                <div class="form-group clearfix m-b-sm">
                    <label class="col-sm-3  al-right line-hi34 ft-bold">${views.role['player.edit.sstx']} : </label>

                    <div class="col-sm-5 line-hi34" id="agent-rank-detail">
                        <a href="javascript:void(0)">
                            <c:if test="${command.result.generalAgentName=='defaulttopagent'}">
                                ${messages.player['player.defaulttopagent']}
                            </c:if>
                            <c:if test="${command.result.generalAgentName!='defaulttopagent'}">
                                ${command.result.generalAgentName}
                            </c:if>
                            <%--${command.result.generalAgentName}--%>
                            >
                            <c:if test="${command.result.agentName=='defaultagent'}">
                                ${messages.player['player.defaultagent']}
                            </c:if>
                            <c:if test="${command.result.agentName!='defaultagent'}">
                                ${command.result.agentName}
                            </c:if>
                            <%--${command.result.agentName}--%>
                            <input type="hidden" name="current-agentRank" id="current-agentRank" value="${command.result.agentId}">
                            <input type="hidden" id="userId" value="${command.result.id}">
                            <soul:button target="editAgentLine" text="${'修改代理'}" opType="function" cssClass="btn btn-link co-blue" permission="role:update_agent"></soul:button>
                            <shiro:hasPermission name="role:update_agent">
                                <div style="font-size: 12px;color: #9c9c9c; display: inline-block;">${messages.content['prompt.update.agent']}</div>
                            </shiro:hasPermission>
                            <c:if test="${not empty sysAuditLog}">
                                <div style="font-size: 14px;color: #9c9c9c;">${soulFn:formatLogDesc(sysAuditLog)}</div>
                            </c:if>
                        </a>
                    </div>

                    <div class="col-sm-5 line-hi34 hide" id="agent-rank-edit">
                        <gb:select name="search.agentRanks" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single"
                                   relSelect="result.agentId" value="" />
                        <gb:select name="result.agentId" prompt="${views.common['pleaseSelect']}" cssClass="btn-group chosen-select-no-single" callback="changeAgentLine"
                                   relSelectPath="${root}/player/getRank/#search.agentRanks#.html"  listKey="id" listValue="username" value=""/>
                        <soul:button target="updateAgentLine" text="${views.common['save']}" opType="function" cssClass="btn btn-link co-blue btn-save-agent hide" confirm="${messages.content['confirm.update.agent']}" callback="query"></soul:button>
                        <soul:button target="cancelEditAgentLine" text="${views.common['cancel']}" opType="function" cssClass="btn btn-link co-blue"></soul:button>
                    </div>
                </div>





                <c:forEach items="${command.fieldSorts}" varStatus="" var="f">
                    <%--${views.column[f.name]}&nbsp;${f.name}<br>--%>
                    <c:choose>
                        <c:when test="${f.name eq 'username'}">
                            <%--用户名 --%>
                            <div class="form-group clearfix m-b-sm">
                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.${f.name}">
                                    <c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                    </c:if>${views.column[f.name]} :
                                </label>

                                <div class="col-sm-5 line-hi34"><a
                                        href="javascript:void(0)">${command.result.username}</a></div>
                            </div>
                        </c:when>
                        <c:when test="${f.name eq 'realName'}">
                            <div class="form-group clearfix m-b-xxs">
                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="sysUser.${f.name}">
                                    <c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm" <%--data-value="${command.contactＷayType[f.name]}"--%>>*</span>
                                    </c:if>${views.column[f.name]} :
                                </label>

                                <div class="col-sm-5 line-hi34">
                                        ${command.result.realName}
                                    <soul:button cssClass="m-l"
                                                 permission="role:player_editusername"
                                                 target="${root}/player/updateRealName.html?result.id=${command.search.id}&result.realName=${command.result.realName}&result.username=${command.result.username}"
                                                 text="${views.role['Player.detail.info.editRealName']}" opType="dialog"
                                                 callback="editPlayerDetail"/>
                                    <input value="${command.result.realName}" type="hidden" class="form-control m-b"
                                           name="sysUser.${f.name}">
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

                                <div class="col-sm-5 ${command.result.sex eq ''}">
                                    <gb:select name="sysUser.sex" value="${command.result.sex}"
                                               ajaxListPath="${root}/userAgent/getSex.html"
                                               prompt="${views.common['pleaseSelect']}" listValue="remark"
                                               listKey="dictCode"
                                               cssClass="btn-group chosen-select-no-single input-sm"/>
                                </div>
                            </div>
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
                                            <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:160px" showDropdowns="true" opens="right"
                                                          value="${command.result.birthday}"
                                                          name="sysUser.birthday" position="up" useRange="false"></gb:dateRange>
                                    </div>
                                </div>
                            </div>
                        </c:when>

                        <c:when test="${f.name eq 'securityIssues'}">
                            <%--安全问题1--%>
                            <%--<div class="form-group clearfix m-b-sm">
                                <label class="col-sm-3 al-right line-hi34 ft-bold">
                                    &lt;%&ndash;<c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>&ndash;%&gt;
                                        ${views.column['question1']} :
                                </label>

                                <div class="col-sm-5 input-group">
                                                        <span class="input-group-btn">
                                                            <gb:select name="sysUserProtection.question1" ajaxListPath="${root}/userAgent/getMasterQuestion/question1.html" value="${command.sysUserProtection.question1}" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>
                                                        </span>
                                    <input type="text" class="form-control" name="sysUserProtection.answer1" value="${command.sysUserProtection.answer1}">
                                    <input type="hidden" name="sysUserProtection.id" value="${command.sysUserProtection.id}">
                                </div>
                            </div>--%>
                            <%--安全问题2--%>
                            <%--<div class="form-group clearfix m-b-sm">
                                <label class="col-sm-3 al-right line-hi34 ft-bold">
                                    &lt;%&ndash;<c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>&ndash;%&gt;
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
                                    &lt;%&ndash;<c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>&ndash;%&gt;
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

                            <div class="form-group clearfix m-b-sm">
                                <label class="col-sm-3 al-right line-hi34 ft-bold">
                                        <%--<c:if test="${f.isRequired ne '2'}">
                                            <span class="co-red m-r-sm">*</span>
                                        </c:if>--%>
                                        ${views.player_auto['安全问题']}:
                                </label>

                                <div class="col-sm-5 input-group">
                                    <span class="input-group-btn">
                                        <gb:select name="sysUserProtection.question1" ajaxListPath="${root}/selectCommonController/getMasterQuestions.html" value="${command.sysUserProtection.question1}" prompt="${views.common['pleaseSelect']}" listValue="remark" listKey="dictCode" cssClass="btn-group chosen-select-no-single input-sm"/>
                                    </span>
                                    <input type="text" class="form-control" name="sysUserProtection.answer1" value="${command.sysUserProtection.answer1}">
                                    <input type="hidden" name="sysUserProtection.id" value="${command.sysUserProtection.id}">
                                </div>
                            </div>
                        </c:when>

                        <c:when test="${f.name eq '110'}">
                            <%--phone--%>
                            <div class="form-group clearfix m-b-sm">
                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="phone.contactValue">
                                    <%--<c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>--%>
                                    ${dicts.notice.contact_way_type[f.name]} :
                                </label>

                                <div class="input-group col-sm-5">
                                    <div class="input-group-btn">
                                        <gb:select name="result.phoneCode" value="${empty command.result.phoneCode?'+86':command.result.phoneCode}"
                                                   ajaxListPath="${root}/player/getPhoneCode.html"
                                                   prompt="" listValue="remark"
                                                   listKey="remark"
                                                   cssClass="btn-group chosen-select-no-single input-sm"/>
                                    </div>
                                    <input type="hidden" value="${f.name}" name="phone.contactType">

                                    <c:set value="" var="contactValue_110"/>
                                    <c:forEach items="${command.noticeContactWays}" var="notice">
                                        <c:if test="${notice.contactType eq '110' && notice.status!='22'}">
                                            <c:set value="${notice.contactValue}" var="contactValue_110"/>
                                        </c:if>
                                    </c:forEach>
                                    <input type="text" value="${contactValue_110}" class="form-control m-b"
                                           id="phone.contactValue" name="phone.contactValue">
                                    <input type="hidden" name="phone.userId" value="${command.result.id}">
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${f.name eq '301'}">
                            <%--qq--%>
                            <div class="form-group clearfix m-b-xxs">
                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="qq.contactValue">
                                    <%--<c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>--%>
                                    ${dicts.notice.contact_way_type[f.name]} :
                                </label>

                                <div class="col-sm-5">
                                    <input type="hidden" value="${f.name}" name="qq.contactType">

                                    <c:set value="" var="contactValue_301"/>
                                    <c:forEach items="${command.noticeContactWays}" var="notice">
                                        <c:if test="${notice.contactType eq '301' && notice.status!='22'}">
                                            <c:set value="${notice.contactValue}" var="contactValue_301"/>
                                        </c:if>
                                    </c:forEach>
                                    <input type="text" value="${contactValue_301}" class="form-control m-b"
                                           id="qq.contactValue" name="qq.contactValue">
                                    <input type="hidden" name="qq.userId" value="${command.result.id}">
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${f.name eq '304'}">
                            <div class="form-group clearfix m-b-xxs">
                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="weixin.contactValue">
                                    <%--<c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>--%>
                                    ${dicts.notice.contact_way_type[f.name]} :
                                </label>

                                <div class="col-sm-5">
                                    <input type="hidden" value="${f.name}" name="weixin.contactType">

                                    <c:set value="" var="contactValue_304"/>
                                    <c:forEach items="${command.noticeContactWays}" var="notice">
                                        <c:if test="${notice.contactType eq '304' && notice.status!='22'}">
                                            <c:set value="${notice.contactValue}" var="contactValue_304"/>
                                        </c:if>
                                    </c:forEach>
                                    <input type="text" value="${contactValue_304}" class="form-control m-b"
                                           id="weixin.contactValue" name="weixin.contactValue">
                                    <input type="hidden" name="weixin.userId" value="${command.result.id}">
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${f.name eq '201'}">
                            <%--email--%>
                            <div class="form-group clearfix m-b-xxs">
                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="email.contactValue">
                                    <%--<c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>--%>
                                    ${dicts.notice.contact_way_type[f.name]} :
                                </label>

                                <div class="col-sm-5">
                                    <input type="hidden" value="${f.name}" name="email.contactType">

                                    <c:set value="" var="contactValue_201"/>
                                    <c:forEach items="${command.noticeContactWays}" var="notice">
                                        <c:if test="${notice.contactType eq '201' && notice.status!='22'}">
                                            <c:set value="${notice.contactValue}" var="contactValue_201"/>
                                        </c:if>
                                    </c:forEach>
                                    <input type="text" value="${contactValue_201}" class="form-control m-b inputMailList"
                                           id="email.contactValue" name="email.contactValue">
                                    <input type="hidden" name="email.userId" value="${command.result.id}">
                                </div>
                            </div>
                        </c:when>
                        <%--<c:when test="${f.name eq '303'}">
                            <div class="form-group clearfix m-b-xxs">
                                <label class="col-sm-3 al-right line-hi34 ft-bold" for="skype.contactValue">
                                    <c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm" &lt;%&ndash;data-value="${command.contactＷayType[f.name]}"&ndash;%&gt;>*</span>
                                    </c:if>${dicts.notice.contact_way_type[f.name]} :
                                </label>

                                <div class="col-sm-5">
                                    <input type="hidden" value="${f.name}" name="skype.contactType">

                                    <c:set value="" var="contactValue_303"/>
                                    <c:forEach items="${command.noticeContactWays}" var="notice">
                                        <c:if test="${notice.contactType eq '303'}">
                                            <c:set value="${notice.contactValue}" var="contactValue_303"/>
                                        </c:if>
                                    </c:forEach>
                                    <input type="text" value="${contactValue_303}" class="form-control m-b"
                                           id="skype.contactValue" name="skype.contactValue">
                                    <input type="hidden" name="skype.userId" value="${command.result.id}">
                                </div>
                            </div>
                        </c:when>--%>
                        <%--<c:when test="${f.name eq 'countryCity'}">
                            <div class="form-group clearfix m-b-sm">
                                <label class="col-sm-3 al-right line-hi34 ft-bold">
                                    <c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>
                                        ${views.column[f.name]}</label>

                                <div class="clearfix col-sm-5">
                                    <div class="col-xs-3 p-x">
                                        <div>
                                            <gb:select name="sysUser.country" value="${command.result.country}"
                                                       prompt="${views.common['pleaseSelect']}"
                                                       ajaxListPath="${root}/regions/site.html" listValue="remark"
                                                       listKey="dictCode"
                                                       relSelect="sysUser.region"
                                                       cssClass="btn-group chosen-select-no-single"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <div>
                                            <gb:select name="sysUser.region" prompt="${views.common['pleaseSelect']}"
                                                       value="${command.result.region}"
                                                       ajaxListPath="${root}/regions/states/${command.result.country}.html"
                                                       relSelectPath="${root}/regions/states/#sysUser.country#.html"
                                                       listValue="remark"
                                                       listKey="dictCode" relSelect="sysUser.city"
                                                       cssClass="btn-group chosen-select-no-single"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <div>
                                            <gb:select name="sysUser.city" prompt="${views.common['pleaseSelect']}"
                                                       value="${command.result.city}"
                                                       ajaxListPath="${root}/regions/cities/${command.result.country}-${command.result.region}.html"
                                                       relSelectPath="${root}/regions/cities/#sysUser.country#-#sysUser.region#.html"
                                                       listValue="remark"
                                                       listKey="dictCode" cssClass="btn-group chosen-select-no-single"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>--%>


                        <c:when test="${f.name eq 'defaultLocale'}">
                            <%--主语言--%>
                            <div class="form-group clearfix m-b-sm">
                                <label class="col-sm-3 al-right line-hi34 ft-bold">
                                    <c:if test="${f.isRequired ne '2'}">
                                        <span class="co-red m-r-sm">*</span>
                                    </c:if>
                                        ${views.column[f.name]} :
                                </label>
                                    <%----%>
                                <div class="col-sm-5">
                                    <gb:select name="sysUser.defaultLocale" value="${command.result.defaultLocale}"
                                               ajaxListPath="${root}/userAgent/getDefaultLocale.html"
                                               prompt="${views.common['pleaseSelect']}" listValue="status"
                                               listKey="language"
                                               cssClass="btn-group chosen-select-no-single input-sm"/>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                </c:forEach>




                <div class="form-group clearfix m-b-sm">
                    <label class="col-sm-3 al-right line-hi34 ft-bold"><span
                            class="co-red m-r-sm">*</span>${views.role['Player.addplayer.rank']} :</label>

                    <div class="col-sm-3">
                        <div class="input-group date">
                            <input type="hidden" name="result.oldRankId" value="${command.result.rankId}"/>
                            <gb:select name="result.rankId" list="${command.playerRankList}" callback="queryRank"
                                       prompt="${views.common['pleaseSelect']}" value="${command.result.rankId}"
                                       listValue="rankName" cssClass="btn-group chosen-select-no-single input-sm"
                                       listKey="id"></gb:select>
                            <span tabindex="0" class=" help-popover input-group-addon" role="button"
                                  data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top"
                                  data-html="true"
                                  data-content="${views.role['Player.edit.rankTip']}<br><a nav-target='mainFrame' href='/vPlayerRankStatistics/list.html'>${views.role['Player.edit.setRank']}</a>"><i
                                    class="fa fa-question-circle"></i></span>
                        </div>
                    </div>
                </div>


                <div class="form-group clearfix m-b-sm">
                    <label class="col-sm-3 al-right line-hi34 ft-bold">${views.role['Player.addplayer.fsyhfa']} :</label>
                    <div class="col-sm-3">
                        <div class="pull-left m-t-n-xs m-l-sm" style="padding: 10px 0px;height: 34px" id="rakebackName-div">${command.result.rakebackName}</div>
                    </div>
                </div>
<%--

                <div class="form-group clearfix m-b-sm">
                    <label class="col-sm-3 al-right line-hi34 ft-bold">${views.column['VUserPlayer.label']}：</label>

                    <div class="col-sm-8 line-hi34">
                        <!--已选择标签显示区域-->
                            <span id="playerSelectTag">
                                <c:forEach var="item" items="${command.vPlayerTagAlls}">
                                    <c:if test="${item.id>0}">
                                        <span tagId=${item.tagId} id=tag_${item.tagId} class="label-del">${item.tagName}&nbsp <a
                                                href="javascript:void(0)" class="deleteTag"
                                                data-id="${item.id}">×</a></span>
                                    </c:if>
                                </c:forEach>
                            </span>
                        <a href="javascript:void(0)" class="compile-add"
                           id="addLebal">+ ${views.column['VUserPlayer.label']}</a>
                    </div>
                    <div class="form-group clearfix m-b-sm">
                        <label class="col-sm-3 al-right line-hi34 ft-bold"></label>

                        <div class="col-sm-5">
                            <!--所有标签，玩家已有标签高亮显示-->
                            <div class="col-sm-12 pull-left li-tag compile-li-tag clearfix m-t-n-xs m-l-sm">
                                <c:forEach var="item" items="${command.vPlayerTagAlls}">
                                    <c:choose>
                                        <c:when test="${item.id>0}">
                                            <a class="selected" href="javascript:void(0)"
                                               tagId="${item.tagId}">${item.tagName}<i
                                                    class="compile-add"></i></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="javascript:void(0)" tagId="${item.tagId}">${item.tagName}<i
                                                    class="compile-add"></i></a>
                                        </c:otherwise>
                                    </c:choose>


                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <input id="playerTag" name="tagsIdStr" value="" type="hidden"/>
                </div>
--%>


                <!-- 表格 结束 -->
                <!-- 分页 开始 -->

                <!-- 分页 结束 -->
            </div>
            <!--表格内容 结束-->
        </div>
        <div class="operate-btn">
            <soul:button cssClass="btn btn-filter btn-lg" text="${views.common['OK']}" opType="ajax" dataType="json"
                         target="${root}/player/updateUserPlayerAndPlayerTag.html" precall="savePlayer"
                         post="getCurrentFormData"
                         callback="myCallback"/>
            <c:if test="${command.comeFrom=='detail'}">
                <soul:button target="toPlayerDetail" cssClass="btn btn-outline btn-filter btn-lg m-r" text="" opType="function">
                    ${views.common['cancel']}
                </soul:button>
            </c:if>
            <c:if test="${command.comeFrom!='detail'}">
                <a href="/player/list.html" class="btn btn-outline btn-filter btn-lg m-r" nav-target="mainFrame"> ${views.common['cancel']}</a>
            </c:if>
            <%--<soul:button target="goToLastPage" refresh="true" cssClass="btn btn-outline btn-filter btn-lg m-r"
                         text="${views.common['cancel']}" opType="function"/>--%>
        </div>
    </div>
    </div>
    </form:form>
    </div>
</body>
<soul:import res="site/player/vuserplayer/userPlayer"/>
</html>
