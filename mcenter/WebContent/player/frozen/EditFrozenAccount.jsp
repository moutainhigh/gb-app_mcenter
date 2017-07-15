<%@ page import="org.soul.commons.lang.DateTool" %>
<%@ page import="java.util.Date" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
    <%@ include file="/include/include.head.jsp" %>
    <link href="${resComRoot}/themes/${curTheme}/chosen/chosen.css" rel="stylesheet">
</head>
<body>
<div class="inmodal" id="unlock" tabindex="-1" aria-hidden="true">
    <form name="af" action="${root}/sysuser/frozen/${controller}" method="post">
        <div class="modal-body">
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right">${views.role['page.frozen.online.status']}：</label>
                <div class="col-xs-9">${frozenEntityVo.result.onlineStatus>0?views.player['page.frozen.online']:views.player['page.frozen.offline']}</div>
            </div>
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right">${flag eq '01'?views.player['page.frozen.account.frozen']:views.player['page.frozen.balance.frozen']}：</label>
                <div class="col-xs-9" style="height: 22px;"><input type="checkbox" name="status" id="status" data-size="mini" ${frozenEntityVo.isCheck?'checked ':''} ${frozenEntityVo.disabled eq '1'?'disabled':''}></div>
            </div>

            <div class="form-group over clearfix">
                <label class="col-xs-3 al-right line-hi34">${views.role['page.frozen.time']}：</label>
                <div class="col-xs-9">
                    <select data-placeholder="${views.role['page.frozen.permanent']}" class="btn-group chosen-select-no-single" tabindex="9" name="frozeTimeType" id="frozeTimeType" ${frozenEntityVo.disabled eq '1'?'disabled':''}>
                        <c:forEach items="${selectList}" var="ft">
                            <option value="${ft.key}" <c:if test="${ft.key eq frozenEntityVo.frozeTime}">selected</c:if> >${views.role[ft.value]}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${views.role['page.frozen.reason']}：</label>
                <div class="col-xs-9">
                    <select callback="freezeCodeChange" data-placeholder="${views.role['page.frozen.choose.reason']}" class="btn-group chosen-select-no-single" tabindex="9" name="freezeCode" id="freezeCode" ${frozenEntityVo.disabled eq '1'?'disabled="disabled"':''}>
                        <c:forEach items="${frozenEntityVo.sysUserFreezeReasonList}" var="fr">
                            <option value="${fr.code}" <c:if test="${fr.code eq frozenEntityVo.selectcode}">selected</c:if> >${fr.title}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${views.role['page.frozen.remark']}：</label>
                <div class="col-xs-9">
                    <textarea class="form-control" id="reason" name="reason" readonly disabled>${frozenEntityVo.reason}</textarea>
                </div>
            </div>
            <div class="form-group clearfix">
                <label class="col-xs-3 al-right">${views.role['page.frozen.operator']}：</label>
                <div class="col-xs-9"><%=SessionManager.getUser().getUsername() %>&nbsp;&nbsp; <%= DateTool.formatDate(new Date(), DateTool.FMT_HYPHEN_DAY_CLN_SECOND) %> </div>
            </div>


            <%--<div class="form-group over clearfix">
                <label class="control-label">${views.role['page.frozen.remark']}：</label>
                <div class="col-sm-12 p-x">
                    <c:if test="${flag eq '01'}">
                        <textarea class="form-control" name="accountFreezeRemark" ${frozenEntityVo.disabled eq '1'?'disabled="disabled"':''}>${frozenEntityVo.result.accountFreezeRemark}</textarea>
                    </c:if>
                    <c:if test="${flag eq '02'}">
                        <textarea class="form-control" name="balanceFreezeRemark" ${frozenEntityVo.disabled eq '1'?'disabled="disabled"':''}>${frozenEntityVo.result.balanceFreezeRemark}</textarea>
                    </c:if>
                </div>
            </div>--%>
        </div>
        <div class="modal-footer">
            <input type="hidden" name="id" value="${frozenEntityVo.result.id}"/>
            <input type="hidden" name="playerId" value="${frozenEntityVo.result.playerId}"/>
            <input type="hidden" id="lockFlag" value="${frozenEntityVo.disabled}"/>
            <input type="hidden" id="controller" value="${controller}"/>
            <c:if test="${!frozenEntityVo.disabled eq '1'}"><soul:button target="${root}/sysuser/frozen/preview.html?id=${frozenEntityVo.result.id}&frozeTimeType={frozeTimeType}&freezeCode={freezeCode}&flag=${flag}" precall="replaceUrlParam" callback="saveFrozen" text="${views.role['page.frozen.preview.sumbit']}" cssClass="btn btn-filter" opType="dialog"/></c:if>
            <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
        </div>
    </form>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/FrozenAccountEditPage"/>
</html>
<script type="application/javascript">
    var jsonList = '${frozenEntityVo.jsonList}';
</script>