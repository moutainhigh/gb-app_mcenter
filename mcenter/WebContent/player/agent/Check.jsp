<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserAgentVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/userAgentRebate/check.html" method="post">
<div class="row">
    <!-- 面包屑 开始 -->
    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['角色']}</span>
        <span>/</span><span>${views.sysResource['代理管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>
    <!-- 面包屑 结束 -->
    <div class="col-lg-12">
        <div style="display: none" id="validateRule">${validateRule}</div>
        <div class="wrapper white-bg shadow">
            <div class="present_wrap"><b>${views.role['Agent.detail.check.title']}</b></div>
            <!-- 工具栏 开始 -->
            <div class="clearfix">
                <!--表格内容 开始-->
                <div id="editable_wrapper" class="dataTables_wrapper" role="grid">

                    <!-- 表格 开始 -->
                    <div class="table-responsive">
                        <div class="panel-body">
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <table class="table dataTable m-b-none">
                                        <tbody><tr class="tab-title">
                                            <th class="bg-tbcolor"> ${views.column['VUserAgentManage.createChannel']}：</th>
                                            <td>${dicts.player.create_channel[map.create_channel]}</td>
                                            <th class="bg-tbcolor"> ${views.column['VUserAgentManage.registCode']}：</th>
                                            <td>${map.regist_code}</td>
                                            <th class="bg-tbcolor">${views.role['agent.topAgent']}：</th>
                                            <td><span class="co-red">${map.general_name}</span></td>
                                            <th class="bg-tbcolor">${views.role['agent.account']}：</th>
                                            <td>${map.username}</td>
                                        </tr>
                                        <tr class="tab-title">
                                            <th class="bg-tbcolor">${views.column['VUserAgentManage.createTime']}：</th>
                                            <td>${soulFn:formatDateTz(map.create_time, DateFormat.DAY_SECOND,timeZone)}</td>
                                            <th class="bg-tbcolor">${views.column['VUserAgentManage.registerIp']}：</th>
                                            <td>${soulFn:formatIp(map.register_ip)}</td>
                                            <th class="bg-tbcolor">${views.role['agent.defaultCurrency']}：</th>
                                            <td>${dicts.common.currency[map.default_currency]}  ${map.default_currency}</td>
                                            <th class="bg-tbcolor">${views.column['VUserAgentManage.defaultTimezone']}：</th>
                                            <td>${map.default_timezone}</td>
                                        </tr>
                                        <tr class="tab-title">
                                            <th class="bg-tbcolor">${views.column['VUserAgentManage.sex']}：</th>
                                            <td>${dicts.common.sex[map.sex]}</td>
                                            <th class="bg-tbcolor">${views.column['VUserAgentManage.birthday']}：</th>
                                            <td>${soulFn:formatDateTz(map.birthday, DateFormat.DAY,timeZone)}</td>
                                            <%--<th class="bg-tbcolor">${views.column['VUserAgentManage.defaultLocale']}：</th>
                                            <td>${dicts.common.local[map.default_locale]}</td>--%>
                                            <%--<th class="bg-tbcolor">${views.column['VUserAgentManage.country']}：</th>
                                            <td>${dicts.region.region[map.country]}-${dicts.state[map.country][map.region]}<c:set var="_key" value='${map.country.concat("_").concat(map.region)}'></c:set>-${dicts.city[_key][map.city]}</td>--%>
                                            <th class="bg-tbcolor">${views.column['VUserAgentManage.mobilePhone']}：</th>
                                            <td>
                                                    ${phone.contactValue} <span class="${phone.status=='12'?'co-grayc2':'co-green'} m-r-sm fs12">${dicts.notice.contact_way_status[phone.status]}</span>
                                            </td>
                                            <th class="bg-tbcolor">${views.player_auto['微信']}：</th>
                                            <td>
                                                    ${weixin.contactValue}
                                            </td>
                                        </tr>
                                        <tr class="tab-title">
                                            <th class="bg-tbcolor">${views.column['VUserAgentManage.mail']}：</th>
                                            <td>${email.contactValue} <span class="${email.status=='12'?'co-grayc2':'co-green'} m-r-sm fs12">${dicts.notice.contact_way_status[email.status]}</span></td>
                                            <th class="bg-tbcolor">QQ：</th>
                                            <td>${qq.contactValue}</td>
                                            <th></th><td></td><th></th><td></td>
                                        </tr>
                                        <tr class="tab-title">

                                            <th class="bg-tbcolor">${views.column['UserAgent.promotionResources']}：</th>
                                            <td colspan="7">${map.promotion_resources}</td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 表格 结束 -->
                    <!-- 分页 开始 -->
                    <hr class=" m-b-md m-t-none">
                    <div class="form-group clearfix col-lg-6 m-b-sm">
                        <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.column['VUserAgentManage.rebateName']} :</label>
                        <div class="col-sm-8">
                            <div  class="input-group date">
                                <gb:select name="userAgentRebate.rebateId" ajaxListPath="${root}/userAgent/getProgram.html?search.userId=${map.parent_id}&search.type=rebate" value="${rebate.programId}" listKey="programId" listValue="name" cssClass="btn-primary"/>
                                <span tabindex="0" class=" help-popover input-group-addon" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top" data-html="true"  data-content="${views.role['agent.check.rebate_remark1']}；<br>${views.role['agent.check.rebate_remark2']}；<br><a href='/rebateSet/list.html' nav-target='mainFrame'>${views.role['agent.check.rebate_set']}</a>"><i class="fa fa-question-circle"></i></span></div>
                        </div>
                    </div>

                    <div class="form-group clearfix m-b-sm col-lg-6">
                        <label class="col-sm-3 al-right line-hi34 ft-bold"><span class="co-red m-r-sm">*</span>${views.column['UserAgent.playerRankId']} :</label>
                        <div class="col-sm-8">
                            <div  class="input-group date">
                                <gb:select name="result.playerRankId" ajaxListPath="${root}/vNoticeEmailInterface/queryUsableList.html" value="${map.player_rank_id}" listKey="id" listValue="rankName" cssClass="btn-primary"/>
                                <span tabindex="0" class=" help-popover input-group-addon" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="top" data-html="true"  data-content="${views.role['agent.check.rank_remark']}<br><a href='/vPlayerRankStatistics/list.html' nav-target='mainFrame'>${views.role['agent.check.rank_set']}</a>"><i class="fa fa-question-circle"></i></span></div>
                        </div>
                    </div>
                    <input type="hidden" name="userAgentRebate.id" value="${rebate.id}">
                    <input type="hidden" name="result.id" value="${map.id}">
                    <input type="hidden" id="freeze_status" value="${map.freeze_status}">
                    <input type="hidden" id="nextCheckAgentId" value="${nextCheckAgentId}">
                    <!-- 分页 结束 -->
                </div>
                <!--表格内容 结束-->
            </div>
            <div class="operate-btn al-center">
                <soul:button target="${root}/userAgent/check.html?realNameAffirm=${map.username}&bo=true" text="${views.role['agent.check.ok']}" tt="success" cssClass="btn btn-filter btn-lg" precall="myValidateForm" opType="ajax" callback="showNextRecord" post="getCurrentFormData" title="">${views.role['agent.check.ok']}</soul:button>
                <soul:button target="${root}/userAgent/check.html?realNameAffirm=${map.username}&bo=false" text="${views.role['agent.check.cancel']}" tt="failure" cssClass="btn btn-outline btn-filter btn-lg" opType="ajax" callback="showNextRecord" post="getCurrentFormData" title="">${views.role['agent.check.cancel']}</soul:button>
                <c:if test="${not empty nextCheckAgentId}">
                    <soul:button target="showNextRecord" text="${views.role['agent.check.next']}" opType="function" permission="role:agent_check" cssClass="pull-right btn btn-outline btn-filter btn-lg"></soul:button>
                    <%--<shiro:hasPermission name="role:agent_check">
                        <a href="/userAgent/toCheck.html?search.id=${nextCheckAgentId}" nav-target="mainFrame"
                           class="pull-right btn btn-outline btn-filter btn-lg" id="nextAudit-btn">${views.role['agent.check.next']}</a>
                    </shiro:hasPermission>--%>
                </c:if>
                <c:if test="${empty nextCheckAgentId}">
                    <a href="/vUserAgentManage/list.html" nav-target="mainFrame" class="pull-right btn btn-outline btn-filter btn-lg" id="nextAudit-btn">${views.fund['withdraw.agent.toList']}</a>
                </c:if>
            </div>
        </div>
    </div>
</form:form>
    <!--代理审核-->
<%--<%@ in  clude file="/include/include.js.jsp" %>--%>
<!--//region your codes 4-->
<soul:import res="site/player/agent/Check"/>
