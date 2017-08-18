<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerRankVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<html lang="zh-CN">
<head>
    <title>${views.content['数据权限']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!--//region your codes 2-->

    <!--//endregion your codes 2-->
</head>

<body>

<form:form id="editDataRightForm" action="" method="post">
    <gb:token/>
    <input type="hidden" name="result.userId" value="${userId}">
    <div class="modal-body">
        <div class="al-center bg-gray line-hi34">
                ${views.content['子账号:']}${subAccountName}
        </div>

        <c:if test="${isCompanyDeposit}">
            <div class="clearfix m-t-md line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.content['公司入款审核：']}</label>

                <soul:button target="checkAll" text="${views.common_report['全选']}"
                             opType="function" tag="button" cssClass="btn btn-filter btn-xs"/>
                <soul:button target="clearAll" text="${views.common_report['取消']}" opType="function"
                             tag="button" cssClass="btn btn-outline btn-filter btn-xs"/>
                <div class="col-sm-5 col-sm-offset-3">
                    <c:set var="c" value="${sysUserDataRightMap['companyDeposit']}"></c:set>
                    <c:forEach items="${playerRanks}" var="a">
                        <span class="m-r-sm">
                            <input type="checkbox" class="i-checks" name="companyDepositRank" value="${a.id}" ${c[a.id].entityId eq a.id ?"checked":""}>
                            ${a.rankName}
                        </span>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <c:if test="${isOnlineDeposit}">
            <div class="clearfix m-t-md line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.content['线上支付记录：']}</label>
                <soul:button target="checkAll" text="${views.common_report['全选']}"
                             opType="function" tag="button" cssClass="btn btn-filter btn-xs"/>
                <soul:button target="clearAll" text="${views.common_report['取消']}" opType="function"
                             tag="button" cssClass="btn btn-outline btn-filter btn-xs"/>
                <div class="col-sm-5 col-sm-offset-3">
                    <c:set var="c" value="${sysUserDataRightMap['onlineDeposit']}"></c:set>
                    <c:forEach items="${playerRanks}" var="a">
                    <span class="m-r-sm">
                        <input type="checkbox" class="i-checks" name="onlineDepositRank" value="${a.id}" ${c[a.id].entityId eq a.id ?"checked":""}>
                        ${a.rankName}
                    </span>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <c:if test="${isPlayerWithdraw}">
            <div class="clearfix m-t-md line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.content['玩家取款审核：']}</label>
                <soul:button target="checkAll" text="${views.common_report['全选']}"
                             opType="function" tag="button" cssClass="btn btn-filter btn-xs"/>
                <soul:button target="clearAll" text="${views.common_report['取消']}" opType="function"
                             tag="button" cssClass="btn btn-outline btn-filter btn-xs"/>
                <div class="col-sm-5 col-sm-offset-3">
                    <c:set var="c" value="${sysUserDataRightMap['playerWithdraw']}"></c:set>
                    <c:forEach items="${playerRanks}" var="a">
                    <span class="m-r-sm">
                        <input type="checkbox" class="i-checks" name="playerWithdrawRank" value="${a.id}" ${c[a.id].entityId eq a.id ?"checked":""}>
                        ${a.rankName}
                    </span>
                    </c:forEach>
                </div>
            </div>
        </c:if>

    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="function"
                     target="saveAndUpdate"/>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage" text="${views.common['cancel']}"/>
    </div>
    <!--//endregion your codes 3-->

</form:form>

</body>
<%@ include file="/include/include.js.jsp" %>
<!--//region your codes 4-->
<soul:import res="site/dataRight/Edit"/>
<!--//endregion your codes 4-->
</html>