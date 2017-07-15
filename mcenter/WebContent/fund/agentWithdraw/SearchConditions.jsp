<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VAgentWithdrawOrderListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>

<div class="m-t-md">
    <div class="m-b-xs clearfix">
        <div class="col-sm-3 clearfix search_1" style="padding-left: 0;">

            <div class="search-wrapper form-group clearfix pull-left col-md-12 col-sm-12 m-b-sm padding-r-none-sm searchType defaultSelect">
                <div class="input-group">
                    <div class="input-group-btn">

                        <c:choose>
                            <c:when test="${!empty command.search.transactionNo}">
                                <c:set var="searchVal" value="${command.search.transactionNo}"/>
                                <c:set var="searchkey" value="search.transactionNo"/>
                            </c:when>
                            <c:when test="${!empty command.search.realName}">
                                <c:set var="searchVal" value="${command.search.realName}"/>
                                <c:set var="searchkey" value="search.realName"/>
                            </c:when>
                            <c:when test="${!empty command.search.agentBankcard}">
                                <c:set var="searchVal" value="${command.search.payeeName}"/>
                                <c:set var="searchkey" value="search.payeeName"/>
                            </c:when>

                            <c:when test="${!empty command.search.remark}">
                                <c:set var="searchVal" value="${command.search.remark}"/>
                                <c:set var="searchkey" value="search.remark"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="searchVal" value="${command.search.username}"/>
                                <c:set var="searchkey" value="search.username"/>
                            </c:otherwise>
                        </c:choose>

                        <gb:select name="stSel" list="${command.searchType}" listKey="key" listValue="value" value="${searchkey}" callback="selectListChange" prompt="" cssClass="chosen-select-no-single"/>
                    </div>
                    <input type="text" class="form-control list-search-input-text searchKey" name="${searchkey}" value="${searchVal}" placeholder="${views.fund_auto['多个账号，用半角逗号隔开']}">
                </div>
            </div>
            <%--玩家账号--%>
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm hide senior username">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">${views.fund['代理账号']}</span>
                    <input  class="form-control search" type="text" name="search.username" placeholder="${views.fund_auto['多个账号，用半角逗号隔开']}" value="${command.search.username}"/>
                </div>
            </div>



            <%--审核时间--%>
            <div class="form-group clearfix pull-left col-md-7 col-sm-12 m-b-sm padding-r-none-sm senior hide checkTime">
                <div class="input-group date time-select-a">
                    <span class="input-group-addon bg-gray">${views.fund['审核时间']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" minDate="${minDate}" maxDate="${maxDate}" useRange="true" style="width:38%;" useToday="true" btnClass="search" startName="search.checkTimeStart" endName="search.checkTimeEnd" startDate="${command.search.checkTimeStart}" endDate="${command.search.checkTimeEnd}"/>
                </div>
            </div>

            <%--创建时间--%>
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm  hide senior createTime">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.fund['创建时间']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" minDate="${minDate}" maxDate="${maxDate}" useRange="true" style="width:38%;" useToday="true" btnClass="search" startName="search.createStart" endName="search.createEnd" startDate="${command.search.createStart}" endDate="${command.search.createEnd}"/>
                </div>
            </div>



            <%--交易号--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm  hide senior transactionNo">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">&nbsp;${views.fund['交易号']}&nbsp;&nbsp;</span>
                    <input  class="form-control search" type="text" name="search.transactionNo" value="${command.search.transactionNo}"/>
                </div>
            </div>




            <%--审核人--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm  hide senior checkUserName">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">${views.fund['审核人']}</span>
                    <input  class="form-control search" type="text" name="search.auditname" value="${command.search.auditname}"/>
                </div>
            </div>

            <%--存款IP--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm  hide senior ipStr">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">&nbsp;&nbsp;${views.fund['存款IP']}&nbsp;&nbsp;</span>
                    <input  class="form-control search" type="text" name="search.ipStr" value="${command.search.ipStr}"/>
                </div>
            </div>



            <%--金额--%>
            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm  hide senior rechargeAmount">
                <div class="input-group time-select-a">
                    <span class="input-group-addon bg-gray">${views.fund['取款金额']}</span>
                    <span class="input-group-addon time-select-ico">${views.fund['起']}</span>
                    <input class="form-control search" type="text" name="search.beginAmount" value="${command.search.beginAmount}"/>
                    <span class="input-group-addon time-select-t">~</span>
                    <span class="input-group-addon time-select-ico">${views.fund['止']}</span>
                    <input class="form-control search" type="text" name="search.endAmount" value="${command.search.endAmount}"/>
                </div>
            </div>

            <%--高级搜索下拉框--%>
            <div class="search-wrapper form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm senior  hide seniorSearch defaultSelect">
                <div class="input-group">
                    <div class="input-group-btn">
                        <c:choose>
                            <c:when test="${!empty command.search.agentBankcard}">
                                <c:set var="searchVal" value="${command.search.agentBankcard}"/>
                                <c:set var="searchkey" value="search.agentBankcard"/>
                            </c:when>
                            <c:when test="${!empty command.search.auditRemark}">
                                <c:set var="searchVal" value="${command.search.auditRemark}"/>
                                <c:set var="searchkey" value="search.auditRemark"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="searchVal" value="${command.search.realName}"/>
                                <c:set var="searchkey" value="search.realName"/>
                            </c:otherwise>
                        </c:choose>
                        <gb:select name="stSel" list="${command.seniorSearch}" listKey="key" listValue="value" value="${searchkey}" callback="selectListChange" prompt="" cssClass="chosen-select-no-single"/>
                    </div>
                    <input type="text" class="form-control list-search-input-text searchKey" name="${searchkey}" value="${searchVal}" placeholder="${views.fund_auto['账户名称']}">
                </div>
            </div>
        </div>

        <div class="col-sm-9 clearfix  search_2 m-b-xs">
            <div class="btn-group pull-right">
                <select class="btn-group chosen-select-no-single" app="btn btn-info-hide dropdown-toggle radius_3" name="toneSwitch" callback="toneSwitch">
                    <option value="0" ${command.tone.active ? 'selected' : ''}>${views.fund['启用声音']}</option>
                    <option value="1" ${command.tone.active ? '' : 'selected'}>${views.fund['禁用声音']}</option>
                </select>
                <input type="hidden" name="switchVal" value="${command.tone.active ? 0 : 1}" />
                <span class="switchTip hide"></span>
            </div>

            <%@include file="/fund/Refresh.jsp"%>
            <div class="pull-right line-hi34 m-r-sm" hidden>${views.fund['共']}<span class="co-red3">${siteCurrencySign}<span id="totalSumTarget">${command.totalSum}</span></span></div>
            <div class="pull-right line-hi34 m-r-sm" hidden>${views.fund['今日成功']}<span class="co-red3">${siteCurrencySign}<span id="todayTotal">0.00</span></span></div>
            <soul:button target="query" opType="function" text="${views.fund_auto['搜索']}" cssClass="btn btn-filter search_btn pull-left m-r-sm agentWithdrawSearch"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.fund_auto['搜索']}</span></soul:button>
            <span class="btn btn-filter btn-outline pull-left show-demand-b m-r-sm">
                <i class="fa fa-chevron-down"></i>${views.common['advancedFilter']}
            </span>
            <%@include file="/sysSearchTemplate/SearchTemplate.jsp"%>

        </div>


    </div>
</div>