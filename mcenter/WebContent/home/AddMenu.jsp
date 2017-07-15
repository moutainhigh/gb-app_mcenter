<%@ page import="so.wwb.gamebox.model.enums.UserTypeEnum" %><%--@elvariable id="menus" type="java.util.List<org.soul.commons.tree.TreeNode<org.soul.model.security.privilege.po.VSysUserResource>>"--%>
<%--@elvariable id="menuListVo" type="so.wwb.gamebox.model.master.setting.vo.VUserShortcutMenuListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
</head>
<!--新增快捷菜单-->
<body>
    <c:set var="userType" value="<%=UserTypeEnum.MASTER_SUB.getCode()%>"/>
    <form:form method="post">
        <div class="modal-body">
            <div class="condition-wraper m-b-sm clearfix" style="display: none">
                <span class="co-red3"><i class="fa fa-times-circle"></i>&nbsp;&nbsp;${views.home_auto['操作无效，最多可添加20个快键方式']}</span>
            </div>
            <%--<div class="add-players">--%>
            <c:forEach items="${menus}" var="i">
                <c:if test="${!fn:contains(i.object.resourceUrl,'home/homeIndex.html')}">
                    <dl class="add-shortcut-menu clearfix">
                        <dt>${views.sysResource[i.object.resourceName]}</dt>
                        <dd>
                            <c:forEach items="${i.children}" var="j">
                                <%---非站长账号不展示子账号功能--%>
                                <c:if test="${!(j.object.id=='703' && sessionSysUser.userType == userType)}">
                                    <c:set var="isSelect" value="false"/>
                                    <c:forEach items="${menuListVo.result}" var="k">
                                        <c:if test="${k.resourceId==j.object.id}">
                                            <c:set var="isSelect" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                    <soul:button target="selectMenu" text="" opType="function" cssClass="${isSelect?'selected':''}" data="${j.object.id}">
                                        ${views.sysResource[j.object.resourceName]}<i class="fa fa-check"></i>
                                    </soul:button>
                                </c:if>
                            </c:forEach>
                        </dd>
                    </dl>
                </c:if>
            </c:forEach>
            <%--</div>--%>
        </div>
        <div class="modal-footer">
            <div class="pull-left short-cut-count-tips">${views.home_auto['最多可添加20个快捷方式，当前已添加']}<span id="selectCount">${fn:length(menuListVo.result)}</span> ${views.home_auto['个']}</div>
            <div class="pull-right">
                <soul:button target="confirmMenu" callback="saveCallbak" text="${views.home_auto['确认']}" opType="function" tag="button" cssClass="btn btn-filter"/>
                <soul:button target="closePage" text="${views.common['cancel']}" cssClass="btn btn-outline btn-filter" opType="function"/>
            </div>

        </div>
    </form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/home/AddMenu"/>
</html>