<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-14
  Time: 下午2:10
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.company.sys.vo.SysDomainVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <form:form>
    <div class="modal-body">
        <h3 class="al-center co-orange"><i class="fa fa-exclamation-circle"></i>${messages.content['sysdomain.toSetDomain.prompt.1']}</h3>
        <div class="line-hi25">${messages.content['sysdomain.toSetDomain.prompt.2'].replace("#",soulFn:formatDateTz(create, DateFormat.DAY,timeZone))}<span class="co-orange">${messages.content['sysdomain.toSetDomain.prompt.3']}</span>${messages.content['sysdomain.toDefaultDomain.prompt.4']}</div>
    </div>
    <div class="modal-footer">
        <soul:button target="toSetting" title="${views.content['sysDoamin.createTitle']}"  text="${views.content['domain.to.add']}" opType="function" callback="" cssClass="btn btn-filter"/>
    </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/mainManager/ToIndex"/>
</html>
