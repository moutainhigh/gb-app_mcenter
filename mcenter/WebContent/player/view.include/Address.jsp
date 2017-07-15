<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerAddressListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--地址-->
<div class="clearfix line-hi25">
    <input name="playerId" value="${command.search.playerId}" type="hidden"/>
    <c:if test="${fn:length(command.result)>0}">
        <soul:button cssClass="pull-right" target="${root}/player/view/addressEdit.html?search.playerId=${command.search.playerId}" text="${views.role['player.view.address.editAddress']}" opType="dialog" callback="address.queryAddress"/>
    </c:if>
</div>
<table class="table table-striped table-bordered table-hover  dataTable" aria-describedby="editable_info">
    <thead>
    <tr>
        <th>${views.column['PlayerAddress.consignee']}</th>
        <th>${views.column['PlayerAddress.area']}</th>
        <th>${views.column['PlayerAddresss.address']}</th>
        <th>${views.column['PlayerAddress.zipCode']}</th>
        <th>${views.column['PlayerAddress.phone']}</th>
        <th>${views.column['PlayerAddress.mobile']}</th>
        <th>${views.column['PlayerAddress.useStauts']}&nbsp;</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${command.result}" var="i" varStatus="status">
        <tr>
            <td>${i.consignee}</td>
            <td>${i.localeNation}&nbsp;&nbsp;${i.localeProvince}&nbsp;&nbsp;${i.localeCity}&nbsp;&nbsp;${i.area}</td>
            <td>${i.address}</td>
            <td>${i.zipCode}</td>
            <td>${i.phone}</td>
            <td>${i.mobile}</td>
            <td>
                <c:choose>
                    <c:when test="${i.isDefault}">
                        <a href="javascript:void(0)" class="btn btn-xs btn-danger">${views.role['player.view.address.currentUse']}</a>
                    </c:when>
                    <c:otherwise>
                        <span>${views.role['player.view.address.historicalUse']}</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script type="text/javascript">
    curl(['site/player/view.include/Address'], function(Address) {
      page.address = new Address();
    });
</script>