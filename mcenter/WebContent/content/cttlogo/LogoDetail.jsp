<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<html lang="zh-CN">
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>

<body>

<form:form id="editForm" action="${root}/cttLogo/showLogoDetail.html" method="post">
    <form:hidden path="result.id" />
    <input type="hidden" value="${hasUsing}" id="hasUsing">
    <input hidden value="${command.logoId}" name="logoId" id="logoId">
    <div class="modal-body">
        <c:set value="${command.result}" var="p"></c:set>
        <br />
        <div class="form-group">
            <label>${views.column['CttLogo.path']}：</label>
            <div class="form-group m-b-sm">
                <c:if test="${not empty p.path}">
                <a href="javascript:void(0)">
                    <img data-src="${soulFn:getImagePath(domain,p.path)}" src="${soulFn:getThumbPath(domain,p.path,500,300)}" alt="${p.name}">
                </a>
                </c:if>
            </div>
        </div>
        <c:if test="${not empty p.flashLogoPath}">
            <div class="form-group">
                <label>${views.content['logo.flash']}：</label>
                <div class="form-group m-b-sm">
                    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="200" height="150" id="logo" align="middle">
                        <param name="movie" value="${soulFn:getImagePath(domain,p.flashLogoPath)}" />
                        <param name="wmode" value="transparent" />
                        <param name="menu" value="false" />
                        <object type="application/x-shockwave-flash" width="200" height="150" data="${soulFn:getImagePath(domain,p.flashLogoPath)}" >
                            <param name="movie" value="${soulFn:getImagePath(domain,p.flashLogoPath)}" />
                            <param name="wmode" value="transparent" />
                            <param name="menu" value="false" />
                        </object>
                    </object>
                </div>
            </div>
        </c:if>
        <div class="form-group">
            <label>${views.column['CttLogo.name']}：</label>
                ${p.name}
        </div>

        <div class="form-group ${p.isDefault == true?'hide':''}">
            <label>${views.column['CttLogo.useTime']}：</label>
            ${soulFn:formatDateTz(p.startTime, DateFormat.DAY_SECOND,timeZone)} ${views.content['logo.zhi']} ${p.isDefault?"----":soulFn:formatDateTz(p.endTime, DateFormat.DAY_SECOND,timeZone)}
        </div>
        <div class="form-group">
            <label>${views.column['CttLogo.status']}：</label>
            <c:if test="${p.isDefault == true}">
                <span id="default" class=""></span>
            </c:if>
            <c:if test="${p.isDefault != true}">
                <c:if test="${p.checkStatus!='1'}">－－</c:if>
                <c:if test="${p.checkStatus=='1'}">
                    <c:if test="${date>=p.startTime && date<=p.endTime}">
                        <span class="co-green">${views.content['logo.stauts.using']}</span>
                    </c:if>
                    <c:if test="${date<=p.startTime}">
                        <span class="_wait">${views.content['logo.status.toBeUse']}</span>
                    </c:if>
                    <c:if test="${date>p.endTime}">
                        <span class="co-grayd">${views.content['logo.status.past']}</span>
                    </c:if>
                </c:if>
            </c:if>
        </div>
        <div class="form-group">
            <label>${views.column['CttLogo.publishTime']}：</label>
                ${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}
        </div>
    </div>
    <div class="modal-footer">
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage" text="${views.common['cancel']}"/>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/cttlogo/Edit"/>
<!--//endregion your codes 1-->
</html>