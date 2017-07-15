<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

        <div class="clearfix al-center p-lg">
            <i class="fa fa-exclamation-circle co-orange fs36 caution-icon"></i>
            <div class="caution-content m-l-sm fs16">
                <span>${empty command.errormsg?command.msg:command.errormsg}</span>
            </div>
        </div>
        <div class="form-group al-center ${empty command.errormsg?'hide':''}">
            ${views.setting['userplayerImport.suggestImport']}&nbsp;
                <%--<a href\="\#{downloadUrl}" target\="_blank" class\="btn btn-filter" download="导入玩家资料.xlsx">--%>
            <a href="${resRoot}/template/user_player_template_zh_CN.xlsx" target="_blank" class="btn btn-filter" download="${views.setting_auto['导入玩家资料']}.xlsx">${views.common['download']}</a>
        </div>
        <c:if test="${not empty errorList}">
            <div class="panel-body">
                <div class="tab-content">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover dataTable m-b-none" aria-describedby="editable_info">
                            <thead>
                            <tr class="bg-gray">
                                <th colspan="3">
                                    <span class="pull-left">${views.setting['userplayerImport.inconformityPlayer']}：</span>
                                </th>
                            </tr>
                            <tr>
                                <th>${views.setting['userplayerImport.column']}</th>
                                <th>${views.setting['userplayerImport.playerAccount']}</th>
                                <th>${views.setting['userplayerImport.failReason']}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="errMap" items="${errorList}" varStatus="status">
                                <c:forEach items="${errMap}" var="err">
                                    <tr>
                                        <td width="80px">${fn:replace(views.setting['userplayerImport.numberRow'],"${rowindex}", err.key)}</td>
                                        <td width="120px">${empty err.value.account?"--":err.value.account}</td>
                                        <td style="WORD-WRAP: break-word" width="400px">
                                            <c:forEach items="${err.value.msgList}" var="msg">
                                                    ${msg}<br />
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
    <div style="padding-left: 20px">
        <soul:button target="toImportPlayer" text="${views.setting['userplayerImport.reimport']}" opType="function" cssClass="btn btn-filter m-l"></soul:button>
        <%--<a href="/userPlayerImport/playerImport.html" class="btn btn-filter btn-lg" nav-target="mainFrame"
           title="${views.setting['userplayerImport.reimportIntroduce']}">${views.setting['userplayerImport.reimport']}</a>--%>
    </div>



