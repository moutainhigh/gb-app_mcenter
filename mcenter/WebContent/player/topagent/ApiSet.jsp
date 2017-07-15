<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<%--//测试用的页面--%>
<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.common['edit']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form>
    <div class="modal-body" data-load="true" style="width: 1000px;">
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
        <%--<soul:button target="${root}/userAgent/persistTopAgent.html" text="" cssClass="btn btn-filter btn-lg" precall="validateForm" opType="ajax" post="getCurrentFormData" callback="goToLastPage" refresh="true">${views.common['OK']}</soul:button>--%>
            <%--<button type="button" class="btn btn-filter">${views.player_auto['确定']}</button>--%>
        <soul:button target="closePage"  text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter btn-lg" opType="function">${views.common['cancel']}</soul:button>
    </div>
</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/player/topagent/ApiSet"/>
<!--//endregion your codes 4-->
</html>