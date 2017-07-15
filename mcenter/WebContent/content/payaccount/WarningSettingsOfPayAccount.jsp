<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerRankVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">
    <form:form id="editForm" action="" method="post">
        <%@include file="WarningSettingsOfPayAccountEdit.jsp" %>
    </form:form>
    <form:form id="queryForm" action="${root}/payAccount/warningSettings/logs/2.html" method="post">
        <div class="col-lg-12 m-t">
            <div class="wrapper white-bg shadow clearfix">
                <div class="present_wrap m-b"><b>${views.content['warningSetting.warning.logs']}</b></div>
                <div class="clearfix">
                    <div class="col-xs-5">
                        <div class="pull-left">
                            <gb:dateRange format="${DateFormat.DAY}" style="width:100px" useRange="true" useToday="true"
                                          callback="query"
                                          startName="search.operatorBegin" endName="search.operatorEnd"
                                          minDate="${dateQPicker.dayBefore3Month}"
                                          maxDate="${dateQPicker.today}"></gb:dateRange>
                        </div>
                    </div>
                </div>
                <!--表格内容-->
                <div id="editable_wrapper" class="search-list-container" role="grid">
                    <%@ include file="WarningSettingsPartial.jsp" %>
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/content/payaccount/WarningSettingsOfPayAccount"/>
<!--//region your codes 4-->
<!--//endregion your codes 4-->