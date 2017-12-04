<%--@elvariable id="command" type="so.wwb.gamebox.model.master.fund.vo.VPlayerDepositListVo"--%>
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
                            <c:when test="${!empty command.search.payName}">
                                <c:set var="searchVal" value="${command.search.payName}"/>
                                <c:set var="searchkey" value="search.payName"/>
                            </c:when>
                            <c:when test="${!empty command.search.channelJson}">
                                <c:set var="searchVal" value="${command.search.channelJson}"/>
                                <c:set var="searchkey" value="search.channelJson"/>
                            </c:when>

                            <c:when test="${!empty command.search.checkRemark}">
                                <c:set var="searchVal" value="${command.search.checkRemark}"/>
                                <c:set var="searchkey" value="search.checkRemark"/>
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
            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm senior hide username" >
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">${views.fund['玩家账号']}</span>
                    <input  class="form-control search" type="text" name="search.username" value="${command.search.username}" placeholder="${views.fund_auto['多个账号，用半角逗号隔开']}"/>
                </div>
            </div>


            <%--审核时间--%>
            <div class="form-group clearfix pull-left col-md-5 col-sm-12 m-b-sm padding-r-none-sm senior hide checkTime">
                <div class="input-group date time-select-a">
                    <span class="input-group-addon bg-gray">${views.fund['审核时间']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" minDate="${minDate}" maxDate="${maxDate}" useRange="true" style="width:44%;" useToday="true" btnClass="search" startName="search.checkTimeStart" endName="search.checkTimeEnd" startDate="${command.search.checkTimeStart}" endDate="${command.search.checkTimeEnd}"/>
                </div>
            </div>

            <%--创建时间--%>
            <%--<div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm senior hide createTime">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.fund['创建时间']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" minDate="${minDate}" maxDate="${maxDate}" useRange="true" style="width:38%;" useToday="true" btnClass="search" startName="search.createStart" endName="search.createEnd" startDate="${command.search.createStart}" endDate="${command.search.createEnd}"/>
                </div>
            </div>--%>




            <%--交易号--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm senior hide transactionNo">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">&nbsp;${views.fund['交易号']}&nbsp;&nbsp;</span>
                    <input  class="form-control search" type="text" name="search.transactionNo" value="${command.search.transactionNo}"/>
                </div>
            </div>




            <%--审核人--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm senior hide checkUsername">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">&nbsp;&nbsp;&nbsp;&nbsp;${views.fund['审核人']}&nbsp;&nbsp;&nbsp;</span>
                    <input  class="form-control search" type="text" name="search.checkUsername" value="${command.search.checkUsername}"/>
                </div>
            </div>

            <%--存款IP--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm senior hide ipStr">
                <div class="input-group date">
                    <span class="input-group-addon bg-gray">&nbsp;&nbsp;${views.fund['存款IP']}&nbsp;&nbsp;</span>
                    <input  class="form-control search" type="text" name="search.ipStr" value="${command.search.ipStr}"/>
                </div>
            </div>

            <%--金额--%>
            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm senior hide rechargeAmount">
                <div class="input-group time-select-a">
                    <span class="input-group-addon bg-gray">${views.fund['金额']}</span>
                    <span class="input-group-addon time-select-ico">${views.fund['起']}</span>
                    <input class="form-control search jp_distance" type="text" name="search.beginAmount" value="${command.search.beginAmount}"/>
                    <span class="input-group-addon time-select-t">~</span>
                    <span class="input-group-addon time-select-ico">${views.fund['止']}</span>
                    <input class="form-control search jp_distance" type="text" name="search.endAmount" value="${command.search.endAmount}"/>
                </div>
            </div>

            <%--来源终端--%>
            <div class="form-group clearfix pull-left col-md-3 col-sm-12 m-b-sm padding-r-none-sm h-line-a senior hide origin">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.fund['来源终端']}</span>
                            <span class=" input-group-addon bdn  right-btn-down">
                            <div class="btn-group table-desc-right-t-dropdown">
                                <ul role="menu">
                                    <li role="presentation">
                                        <label><input type="radio" value="" name="search.origin" ${empty command.search.origin?'checked':''}> ${views.fund['全部']}</label>
                                    </li>
                                    <li role="presentation">
                                        <label><input type="radio" value="PC" name="search.origin" ${command.search.origin == 'PC'?'checked':''}> ${views.fund['PC端']}</label>
                                    </li>
                                    <li role="presentation">
                                        <label><input type="radio" value="MOBILE" name="search.origin" ${command.search.origin == 'MOBILE'?'checked':''}> ${views.fund['手机端']}</label>
                                    </li>
                                </ul>
                            </div>
                        </span>
                </div>
            </div>

            <%--账号类型--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm senior hide accountType">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.fund['支付类型']}</span>
                    <gb:select name="search.rechargeType" value="${command.search.rechargeType}" list="${command.rechargeType}" listKey="key" listValue="value" prompt="${views.fund_auto['全部']}"/>
                </div>
            </div>


            <%--高级搜索下拉框--%>
            <div class="search-wrapper form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm senior hide seniorSearch defaultSelect">
                <div class="input-group">
                    <div class="input-group-btn">
                        <c:choose>
                            <c:when test="${!empty command.search.checkRemark}">
                                <c:set var="searchVal" value="${command.search.checkRemark}"/>
                                <c:set var="searchkey" value="search.checkRemark"/>
                            </c:when>
                            <c:when test="${!empty command.search.channelJson}">
                                <c:set var="searchVal" value="${command.search.channelJson}"/>
                                <c:set var="searchkey" value="search.channelJson"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="searchVal" value="${command.search.payName}"/>
                                <c:set var="searchkey" value="search.payName"/>
                            </c:otherwise>
                        </c:choose>
                        <gb:select name="stSel" list="${command.seniorSearch}" listKey="key" listValue="value" value="${searchkey}" callback="selectListChange" prompt="" cssClass="chosen-select-no-single"/>
                    </div>
                    <input type="text" class="form-control list-search-input-text searchKey" name="${searchkey}" value="${searchVal}" placeholder="${views.fund_auto['账户名称']}">
                </div>
            </div>
            <%--层级--%>
            <div class="form-group clearfix pull-left col-md-2 col-sm-12 m-b-sm padding-r-none-sm senior hide">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.player_auto['层级']}</span>
                    <span class="bdn right-btn-down">
                        <div class="btn-group table-desc-right-t-dropdown" initprompt="10条"
                             callback="query">
                            <button type="button" class="btn btn btn-default right-radius rank-btn">
                                <span class="rankText" prompt="prompt">${views.player_auto['请选择']}</span>
                                <span class="caret-a pull-right"></span>
                            </button>
                            <c:forEach items="${command.search.rankIds}" var="p">
                                <input type="hidden" class="playerRanks" data-value="${p}"/>
                            </c:forEach>
                            <div class="dropdown-menu playerRank">
                                <div class="search-top-menu"
                                     style="margin-top: 10px;margin-left: 10px;">
                                    <button type="button" data-type="all"
                                            class="btn btn-filter btn-xs">${views.operation['backwater.settlement.choose.allChoose']}</button>
                                    <button type="button" data-type="clear"
                                            class="btn btn-outline btn-filter btn-xs">${views.operation['backwater.settlement.choose.clear']}</button>
                                </div>
                                <div class="m-t">
                                    <table class="table table-bordered m-b-xxs">
                                        <tr>
                                            <th class="al-left">
                                                <c:forEach items="${playerRanks}" var="pr"
                                                           varStatus="i">
                                                    <label class="m-r-sm">
                                                        <input type="checkbox" name="search.rankIds"
                                                               class="i-checks" value="${pr.id}">
                                                        <span class="m-l-xs">${pr.rankName}</span>
                                                    </label>
                                                </c:forEach>
                                            </th>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </span>
                </div>
            </div>

        </div>

        <div class="col-sm-9 clearfix  search_2 m-b-xs">
            <%--创建时间--%>
            <div class="form-group clearfix pull-left col-md-5 col-sm-12 m-b-sm padding-r-none-sm createTime">
                <div class="input-group">
                    <span class="input-group-addon bg-gray">${views.fund['创建时间']}</span>
                    <gb:dateRange format="${DateFormat.DAY_SECOND}" minDate="${minDate}" maxDate="${maxDate}" useRange="true" style="width:38%;" useToday="true" btnClass="search" startName="search.createStart" endName="search.createEnd" startDate="${command.search.createStart}" endDate="${command.search.createEnd}"/>
                </div>
            </div>

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
            <div class="pull-right line-hi34 m-r-sm" hidden>${views.fund['今日成功']}<span class="co-red3">${siteCurrencySign}<span id="todayTotal">0</span></span></div>
            <div>
                <soul:button target="queryByCondition" opType="function" text="${views.fund_auto['搜索']}" cssClass="btn btn-filter search_btn pull-left m-r-sm onlineSearchSpan"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.fund['搜索']}</span></soul:button>
            </div>
            <span class="btn btn-filter btn-outline pull-left show-demand-b m-r-sm">
                <i class="fa fa-chevron-down"></i>${views.common['advancedFilter']}
            </span>
            <%@include file="/sysSearchTemplate/SearchTemplate.jsp"%>

        </div>


    </div>
</div>