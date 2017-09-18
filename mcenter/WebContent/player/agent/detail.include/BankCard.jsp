<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.UserBankcardListVo"--%>
<%--@elvariable id="banks" type="java.util.Map<java.lang.String,so.wwb.gamebox.model.company.po.Bank>"--%>
<!--银行卡-->
<div class="clearfix line-hi25">
    <c:if test="${fn:length(command.result)>0}">
        <c:choose>
            <c:when test="${bitcoin!=true}">
                <soul:button target="${root}/userAgent/agent/bankEdit.html?search.userId=${command.search.userId}"
                             userId="${command.search.userId}" text="${views.role['Player.detail.bank.editBankInfo']}"
                             opType="dialog" cssClass="pull-right" callback="bankcard.query"/>
            </c:when>
            <c:otherwise>
                <soul:button target="${root}/player/view/btcEdit.html?search.userId=${command.search.userId}"
                             userId="${command.search.userId}" text="${views.player_auto['修改比特币地址']}"
                              opType="dialog" cssClass="pull-right" callback="bankcard.query"/>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>
<div role="grid" class="dataTables_wrapper" id="editable_wrapper">
<div class="table-responsive">
<table class="table table-striped table-bordered table-hover dataTable" aria-describedby="editable_info">
    <thead>
    <tr>
        <c:choose>
            <c:when test="${bitcoin!=true}">
                <th>${views.column["UserBankcard.bankName"]}</th>
                <th>${views.column["UserBankcard.bankcardMasterName"]}</th>
                <th>${views.column["UserBankcard.bankcardNumber"]}</th>
            </c:when>
            <c:otherwise>
                <th></th>
                <th>${views.player_auto["比特币地址"]}</th>
            </c:otherwise>
        </c:choose>
        <th>${views.column["UserBankcard.createTime"]}</th>
        <th>${views.column["UserBankcard.useCount"]}</th>
        <th>${views.common['status']}</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${command.result}" var="l" varStatus="vs">
        <tr>
            <c:choose>
                <c:when test="${bitcoin!=true}">
                    <td>
                        <span class="pay-bank ${l.bankName}"></span>
                            <%--<img src="${resComRoot}${banks[l.bankName].bankIcon}">--%>
                    </td>
                    <td>${l.bankcardMasterName}</td>
                    <td>${l.bankcardNumber}</td>
                </c:when>
                <c:otherwise>
                    <td><span class="pay-third bitcoin"></span></td>
                    <td>${l.bankcardNumber}</td>
                </c:otherwise>
            </c:choose>
            <td>${soulFn:formatDateTz(l.createTime, DateFormat.DAY_SECOND,timeZone)}</td>
            <td class="co-red">${l.useCount}</td>
            <td>
                <c:if test="${l.isDefault}">
                    <span class="label label-danger">${views.common['currentUse']}</span>
                </c:if>
                <c:if test="${!l.isDefault}">
                    <span>${views.common['historyUse']}</span>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
</div>
<script type="text/javascript">
    curl(['site/player/agent/BankCard'], function(BankCard) {
        page.bankcard = new BankCard();
    });
</script>