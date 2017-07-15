<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <%--<title>玩家管理-玩家列表</title>--%>
    <!-- Gritter -->
    <link href="${resComRoot}/themes/${curTheme}/style.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/content.css" rel="stylesheet">
</head>
<body>
<!--账号冻结预览-->
<form:form id="editForm" method="post" >
    <div class="modal-content animated bounceInRight family">
        <div class="modal-header">
            <span class="filter"><i class="fa fa-key"></i>&nbsp;&nbsp;${flag eq '01' ?views.player['page.frozen.account.frozen']:views.player['page.frozen.balance.frozen']}</span>
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${views.common['page.frozen.cancel']}</span> </button>
        </div>
        <div class="modal-body">
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right">${views.role['Player.detail.frozen.playerAccount']}</label>
                <div class="col-xs-9">${sysUserPlayerFrozenVo.result.username}<span class="m-l-sm co-green">${views.role['Player.detail.frozen.online']}</span><span class="m-l-sm co-grayc2">${views.role['Player.detail.frozen.unonline']}</span></div>
            </div>
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right">${flag eq '01' ?views.player['page.frozen.account.frozen']:views.player['page.frozen.balance.frozen']}：</label>
                <div class="col-xs-9">
                    <input type="checkbox" name="status" id="status" data-size="mini" checked>
                </div>
            </div>
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${views.role['page.frozen.time']}：</label>
                <div class="col-xs-9">
                    <div class="input-group">
                        <select data-placeholder="${views.role['page.frozen.permanent']}" class="btn-group chosen-select-no-single" tabindex="9" name="frozeTimeType" id="frozeTimeType" disabled>
                            <c:forEach items="${selectList}" var="ft">
                                <option value="${ft.key}" <c:if test="${ft.key eq frozeTimeType}">selected</c:if> >${views.role[ft.value]}</option>
                            </c:forEach>
                        </select>
                        <c:set value="${flag eq '01' ?sysUserPlayerFrozenVo.freezeEndTime:sysUserPlayerFrozenVo.balanceFreezeEndTime}" var="endTime"/>
                        <span class="input-group-addon bdn"><span class="m-l-sm">${views.role['Player.detail.frozen.endTime']}：${soulFn:formatDateTz(endTime, DateFormat.DAY_SECOND,timeZone)}</span></span>
                    </div>
                </div>
            </div>
            <div class="form-group line-hi34 clearfix m-b-sm">
                <label class="col-xs-3 al-right">${views.role['page.frozen.reason']}：</label>
                <div class="col-xs-9">
                    ${sysUserPlayerFrozenVo.title}
                    <div class="clearfix">${views.role['Player.detail.frozen.content']}：</div>
                    <textarea class="form-control" disabled>${sysUserPlayerFrozenVo.reason}</textarea>
                </div>
            </div>
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${views.role['Player.detail.frozen.remark']}：</label>
                <div class="col-xs-9">
                    <textarea class="form-control" disabled>${sysUserPlayerFrozenVo.remarks}</textarea>
                </div>
            </div>
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right">${views.role['Player.detail.frozen.optionUser']}：</label>
                <div class="col-xs-9">${sysUserPlayerFrozenVo.sysUser.username}&nbsp;&nbsp; ${soulFn:formatDateTz(currentDate, DateFormat.DAY_SECOND,timeZone)}</div>
            </div>

        </div>
        <div class="modal-footer">
            <soul:button target="closePage" text="${messages['common']['lastStep']}" cssClass="btn btn-outline btn-filter" opType="function"/>
            <soul:button target="previewOk" text="${messages['common']['OK']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/FrozenAccountEditPage"/>
</html>
