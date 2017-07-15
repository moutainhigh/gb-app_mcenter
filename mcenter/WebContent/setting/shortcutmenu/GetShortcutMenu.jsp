<%@ page import="org.soul.commons.lang.string.I18nTool" %>
<%@ page import="java.util.Locale" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
    <form id="shortcutMenu_form">
        <input name="search.resourceIds" value="" type="hidden" />
    </form>
        <c:set var="shortcutMenu_listvo_len" value="0"></c:set>

    <ol class="dd-list">
        <c:forEach items="${listVo.result}" var="s" varStatus="index">
        <c:set var="shortcutMenu_listvo_len" value="${shortcutMenu_listvo_len+1}"></c:set>
            <%--<c:forEach items="${listVo}" var="s">--%>
            <dd class="tuo dd-item" data-id="${s.resourceId}">
               <%-- <a class="dd-handle1">--%>
                <a href="javascript:void(0)" class="del" data-id="${s.id}"><i class="fa fa-times"></i></a>
                <div class="dd-handle1" data-id="${s.id}">

                    <i class="fa fa-outdent"></i> ${views.sysResource[s.resourceName]}
                    <input type="hidden" value="${s.resourceId}" name="shortcutMeuResourceId"/>
                </div>
               <%-- </a>--%>
            </dd>
            </c:forEach>

    </ol>
            <c:if test="${shortcutMenu_listvo_len < 20}">
                <dd class="add">
                    <soul:button target="${root}/userShortcutMenu/getAllMenu.html" callback="loadShortcutMenu" text="${views.home['ShortcutMenu.addTitle']}" opType="dialog" tag="a">
                        <i class="fa fa-plus"></i>
                    </soul:button>
                </dd>
            </c:if>
                <dd class="none${shortcutMenu_listvo_len <1 ? '':' hide'}" >
                    ${views.home['ShortcutMenu.noneError']}
                </dd>
        <div id ="shortcutMenu_add" class="_shortmenu_add" style="display:none;">
            <dd class="add">
                <soul:button target="${root}/userShortcutMenu/getAllMenu.html" callback="loadShortcutMenu" text="${views.home['ShortcutMenu.addTitle']}" opType="dialog">
                    <i class="fa fa-plus"></i>
                </soul:button>
                <%--<a class="shortcut_menu_add" href="javascript:void(0)"><i class="fa fa-plus"></i></a>--%>
            </dd>
        </div>
