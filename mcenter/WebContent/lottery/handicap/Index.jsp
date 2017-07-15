<%--@elvariable id="command" type="so.wwb.gamebox.model.company.lottery.vo.LotteryHandicapListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<form:form action="${root}/lotteryHandicap/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <div class="panel panel-default">
        <div class="panel-body">
            <!--//region your codes 2-->
            <div class="row">
                <label class="col-md-1 control-label" for="search.code">${views.lottery_auto['彩种代号']}</label>
                <div class="col-md-2">
                    <form:input class="form-control" path="search.code" placeholder="${views.lottery_auto['请输入彩种代号']}"/>
                </div>
                <label class="col-md-1 control-label" for="search.expect">${views.lottery_auto['期数']}</label>
                <div class="col-md-2">
                    <form:input class="form-control" path="search.expect" placeholder="${views.lottery_auto['请输入期数']}"/>
                </div>

                <div class="col-md-1">
                    <soul:button target="query" opType="function" text="${views.lottery_auto['查询']}" cssClass="btn btn-default" />
                </div>
                <div class="col-md-1">
                    <soul:button target="${root}/lotteryHandicap/create.html" opType="dialog" text="${views.lottery_auto['新增']}" cssClass="btn btn-default" />
                </div>
            </div>

            <br/>
            <div class="search-list-container">
                <%@ include file="IndexPartial.jsp" %>
            </div>
            <!--//endregion your codes 2-->
        </div>
    </div>
</form:form>

<!--//region your codes 3-->
<soul:import type="list"/>
<!--//endregion your codes 3-->