<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <link href="${resComRoot}/themes/${curTheme}/chosen/chosen.css" rel="stylesheet">
</head>
<body>
    <form name="af" action="${root}/sysuser/frozen/${controller}" method="post">
        <div class="modal-body">
            <div class="form-group clearfix m-b-sm col-xs-12">
                <label class="col-xs-3 al-right">${views.role['Player.detail.frozen.playerAccount']}：</label>
                <div class="col-xs-9 p-x">${frozenEntityVo.result.username}<span class="${frozenEntityVo.result.onlineStatus>0?'m-l-sm co-green':'m-l-sm co-grayc2'}">${frozenEntityVo.result.onlineStatus>0?views.player['page.frozen.online']:views.player['page.frozen.offline']}</span></div>
            </div>

            <div class="form-group clearfix m-b-sm col-xs-12">
                <label class="col-xs-3 al-right">${flag eq '01'?views.player['page.frozen.account.frozen']:views.player['page.frozen.balance.frozen']}：</label>
                <div class="col-xs-8 p-x"><input type="checkbox" name="status" id="status" data-size="mini" ${frozenEntityVo.isCheck?'checked ':''} ${frozenEntityVo.disabled eq '1'?'disabled':''}></div>
                <%--<input type="checkbox" name="status" class="js-switch" id="status" ${frozenEntityVo.isCheck?'checked ':''} ${frozenEntityVo.disabled eq '1'?'disabled="disabled"':''}/>${views.role['page.frozen.enable']}--%>
            </div>

            <div class="form-group clearfix m-b-sm col-xs-12">
                <label class="col-xs-3 al-right line-hi34">${views.role['page.frozen.time']}：</label>
                <div class="col-xs-8 p-x">
                    <select data-placeholder="${views.role['page.frozen.permanent']}" class="btn-group chosen-select-no-single" tabindex="9" name="frozeTimeType" id="frozeTimeType" ${frozenEntityVo.isCheck?'':'disabled'} ${frozenEntityVo.disabled eq '1'?'disabled':''}>
                        <c:forEach items="${selectList}" var="ft">
                            <option value="${ft.key}" <c:if test="${ft.key eq frozenEntityVo.frozeTime}">selected</c:if> >${views.role[ft.value]}</option>
                        </c:forEach>
                    </select>
                </div>
                <span class="help-block m-b-none" id="tipTime" style="display:none;"><i class="fa fa-times-circle co-red3"></i> ${views.role['Player.detail.frozen.choosenTime']}</span>
            </div>

            <div class="form-group clearfix m-b-sm col-xs-12">
                <label class="col-xs-3 al-right line-hi34">${views.role['page.frozen.reason']}：</label>
                <div class="col-xs-8 p-x">
                    <div class="input-group date">
                        <select callback="freezeCodeChange" class="btn-group chosen-select-no-single" tabindex="9" id="freezeCode" ${frozenEntityVo.isCheck?'':'disabled'} ${frozenEntityVo.disabled eq '1'?'disabled="disabled"':''}>
                            <option value="">${views.role['page.frozen.choose.reason']}</option>
                            <c:forEach items="${noticeLocaleTmpls}" var="i">
                                <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}" >${i.title}</option>
                            </c:forEach>
                        </select>
                        <span class="input-group-addon bdn">
                            <soul:button target="showTmpl" text="${views.common['editTmpl']}" cssClass="m-l-sm" opType="function"/>
                        </span>
                    </div>
                    <span class="help-block m-b-none" id="tipReason" style="display:none;"><i class="fa fa-times-circle co-red3"></i> ${views.role['Player.detail.frozen.choosenReason']}</span>
                    <div class="clearfix m-t-sm">${views.role['Player.detail.frozen.content']}：<a class="dropdown-toggle account-pull-down pull-right btn-advanced-down"><i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}</a></div>
                    <textarea class="form-control m-t-xs" id="reason" name="reason" readonly disabled>${frozenEntityVo.isCheck?send.content:''}</textarea>
                </div>
            </div>

            <%--<div class="form-group clearfix">
                <label class="col-xs-3 al-right">${views.role['page.frozen.operator']}：</label>
                <div class="col-xs-9"><%=SessionManager.getUser().getUsername() %>&nbsp;&nbsp; <%= DateTool.formatDate(new Date(), DateTool.FMT_HYPHEN_DAY_CLN_SECOND) %> </div>
            </div>--%>
            <div class="form-group clearfix m-b-sm col-xs-12">
                <label class="col-xs-3 al-right">${views.role['page.frozen.remark']}：</label>
                <div class="col-xs-8 p-x">
                    <textarea class="form-control" maxlength="500" name="remarks" ${frozenEntityVo.disabled eq '1'?'disabled="disabled"':''}>${send.remarks}</textarea>
                </div>
            </div>
            <c:if test="${frozenEntityVo.isCheck}">
                <div class="form-group clearfix">${views.role['Player.detail.frozen.optionUser']}：${send.createUsername}&nbsp;&nbsp;${soulFn:formatDateTz(send.createTime,DateFormat.DAY_SECOND,timeZone)}</div>
            </c:if>
        </div>
        <div class="modal-footer">
            <input type="hidden" name="id" value="${frozenEntityVo.result.id}"/>
            <input type="hidden" name="playerId" value="${frozenEntityVo.result.playerId}"/>
            <input type="hidden" id="lockFlag" value="${frozenEntityVo.disabled}"/>
            <input type="hidden" id="controller" value="${controller}"/>
            <input type="hidden" id="title" name="title">
            <input type="hidden" name="username" value="${frozenEntityVo.result.username}"/>
            <input type="hidden" id="groupCode" name="groupCode"/>
            <c:if test="${!(frozenEntityVo.disabled eq '1')}"><soul:button target="${root}/sysuser/frozen/preview.html?id=${frozenEntityVo.result.id}&frozeTimeType={frozeTimeType}&freezeCode={freezeCode}&flag=${flag}" precall="replaceUrlParam" callback="saveFrozen" text="${views.role['page.frozen.preview.sumbit']}" cssClass="btn btn-filter" opType="dialog"/></c:if>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/FrozenAccountEditPage"/>
</html>
<%--
<script type="application/javascript">
    var jsonList = '${frozenEntityVo.jsonList}';
</script>--%>
