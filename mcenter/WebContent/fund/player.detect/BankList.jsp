<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:if test="${fn:length(bankcards)>0}">
    <div class="detect-title">${views.fund['fund.playerDetect.index.bankRecord']}</div>
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-desc-list">
            <thead>
            <tr>
                <th>${views.column["UserBankcard.bankName"]}</th>
                <th>${views.column["UserBankcard.bankcardMasterName"]}</th>
                <th>${views.column["UserBankcard.bankcardNumber"]}</th>
                <th>${views.fund_auto['开户行']}</th>
                <th>${views.column["UserBankcard.createTime"]}</th>
                <th>${views.column["UserBankcard.useCount"]}</th>
                <th>${views.common['status']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${bankcards}" var="bank" varStatus="status">
                <tr>
                    <td><span class="pay-bank ${bank.bankName}"></span></td>
                    <td>${bank.bankcardMasterName}</td>
                    <td>${soulFn:formatBankCard(bank.bankcardNumber)}</td>
                    <td>${bank.bankDeposit}</td>
                    <td>${soulFn:formatDateTz(bank.createTime,DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${bank.useCount}</td>
                    <td>
                        <c:choose>
                            <c:when test="${bank.isDefault}">
                                <span class='btn btn-xs btn-danger'>${views.common['currentUse']}</span>
                            </c:when>
                            <c:otherwise>
                                ${views.common['historyUse']}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>
<c:if test="${fn:length(bankcards)>0&&fn:length(btnBanks)>0}">
    <div class="clearfix"></div>
    <br/>
</c:if>
<c:if test="${fn:length(btnBanks)>0}">
    <div class="detect-title">比特币地址记录</div>
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-desc-list">
            <thead>
            <tr>
                <th></th>
                <th>比特币地址</th>
                <th>${views.column["UserBankcard.createTime"]}</th>
                <th>${views.column["UserBankcard.useCount"]}</th>
                <th>${views.common['status']}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${btnBanks}" var="bank" varStatus="status">
                <tr>
                    <td><span class="pay-third ${bank.bankName}"></span></td>
                    <td>${soulFn:formatBankCard(bank.bankcardNumber)}</td>
                    <td>${soulFn:formatDateTz(bank.createTime,DateFormat.DAY_SECOND,timeZone)}</td>
                    <td>${bank.useCount}</td>
                    <td>
                        <c:choose>
                            <c:when test="${bank.isDefault}">
                                <span class='btn btn-xs btn-danger'>${views.common['currentUse']}</span>
                            </c:when>
                            <c:otherwise>
                                ${views.common['historyUse']}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>


