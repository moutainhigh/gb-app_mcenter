<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
    <div class="condition-wraper m-b-sm clearfix">
        <%--<strong>${views.home['addTitle']}</strong>--%>
        <soul:button target="revertDefault" text="" cssClass="pull-right co-blue3 revertDefault-btn" opType="function"  tag="a">
            ${views.home['ShortcutMenu.revertDefaultTitle']}
        </soul:button>
        <%--<a href="javascript:void(0)" class="pull-right co-blue3 revertDefault-btn">${views.home['revertDefaultTitle']}</a>--%>
    </div>
    <div class="condition-wraper m-b-sm clearfix" style="display: none;" id ="shotcutMenu_add_error_label">
        <span class="co-red3"><i class="fa fa-times-circle"></i>&nbsp;&nbsp;${views.home['ShortcutMenu.max20Error']}</span>
    </div>
    <div class="add-players">
        <input type="hidden" value="${userMaxShortcutMenu}" id="userMaxShortcutMenu">
        <c:forEach items="${vSysUserResources}" var="resource" >
            <%--如果子菜单不为空--%>
            <c:if test="${not empty resource.children}">
                <dl class="add-shortcut-menu clearfix">
                    <dt>${views.sysResource[resource.object.resourceName]}</dt>
                    <dd>
                        <c:forEach items="${resource.children}" var="c1">
                            <c:set var="isSelected" value="0"></c:set>
                            <%--第二级--%>
                            <%--<c:if test="${c1.object.resourceUrl ne null}">--%>
                                <%--判断是否都有选中--%>
                                <c:forEach items="${vUserShortcutMenuListVo.result}" var="vUserShortcutMenu" varStatus="status">
                                <input type="hidden" name="hidden" value="${vUserShortcutMenu.resourceId}">

                                        <c:if test="${vUserShortcutMenu.resourceId eq c1.object.id}">
                                            <c:set var="isSelected" value="1"></c:set>
                                            <a href="javascript:void(0)" class="selected" data-default="${vUserShortcutMenu.userId eq 0 ?'':vUserShortcutMenu.userId}" data-shortcut-id="${vUserShortcutMenu.id}" data-early="true" data-sort="${vUserShortcutMenu.sort}" data-id="${c1.object.id}">${views.sysResource[c1.object.resourceName]}<i class="fa fa-check"></i></a>
                                        </c:if>

                                        <c:if test="${status.last && isSelected eq 0}">
                                            <a href="javascript:void(0)" data-id="${c1.object.id}">${views.sysResource[c1.object.resourceName]}<i class="fa fa-check"></i></a>
                                        </c:if>

                                 </c:forEach>
                                <c:if test="${empty vUserShortcutMenuListVo.result}">
                                    <a href="javascript:void(0)" data-test="${views.sysResource[c1.object.resourceName]}" data-test1="${views.sysResource['玩家取款审核']}" data-id="${c1.object.id}">${views.sysResource[c1.object.resourceName]}<i class="fa fa-check"></i></a>
                                </c:if>
                            <%--</c:if>--%>

                            <%--第三级--%>
                            <c:forEach items="${c1.children}" var="c2">
                                <%--<c:if test="${c2.object.resourceUrl ne null}">--%>
                                    <c:forEach items="${vUserShortcutMenuListVo.result}" var="vUserShortcutMenu" varStatus="status">
                                        <c:if test="${vUserShortcutMenu.resourceId eq c2.object.id}">
                                            <c:set var="isSelected" value="1"></c:set>
                                            <a href="javascript:void(0)" class="selected" data-default="${vUserShortcutMenu.userId eq 0 ?'':vUserShortcutMenu.userId}"  data-shortcut-id="${vUserShortcutMenu.id}" data-early="true" data-sort="${vUserShortcutMenu.sort}" data-id="${c2.object.id}">${views.sysResource[c2.object.resourceName]}<i class="fa fa-check"></i></a>
                                        </c:if>
                                        <c:if test="${status.last && isSelected eq 0}">
                                            <a href="javascript:void(0)" data-id="${c2.object.id}">${views.sysResource[c2.object.resourceName]}<i class="fa fa-check"></i></a>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${empty vUserShortcutMenuListVo.result}">
                                            <a href="javascript:void(0)" data-test="n2" data-id="${c2.object.id}">${views.sysResource[c2.object.resourceName]}<i class="fa fa-check"></i></a>
                                    </c:if>
                                <%--</c:if>--%>
                            </c:forEach>
                        </c:forEach>
                    </dd>
                </dl>
            </c:if>
        </c:forEach>
    </div>
    <div class="modal-footer">
        <input type="hidden" name="position" value="${position}"/>
        <soul:button target="saveShortcutMenu" text="${views.common['confirm']}" opType="function" cssClass="btn btn-filter shortcut_menu_add_confim"  tag="button">
            ${views.common['confirm']}
        </soul:button>
        <soul:button target="closePage" text="${views.common['cancel']}" opType="function" cssClass="btn btn-outline btn-filter">
            ${views.common['cancel']}
        </soul:button>
    </div>
</body>
<%@ include file="/include/include.js.jsp" %>
</html>
<soul:import res="site/setting/shortcutmenu/AddShortcutMenu"/>
