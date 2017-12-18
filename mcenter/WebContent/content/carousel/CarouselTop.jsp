<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<ul class="clearfix sys_tab_wrap">
    <li id="li_top_1" class="<c:if test="${'1'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMsiteDialog.html" nav-target="mainFrame">PC端首页弹窗广告</a>
    </li>
    <li id="li_top_2" class="<c:if test="${'2'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMsiteCarousel.html" nav-target="mainFrame">PC端首页轮播图</a>
    </li>
    <li id="li_top_3" class="<c:if test="${'3'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMobileCarousel.html" nav-target="mainFrame">手机轮播图</a>
    </li>
    <li id="li_top_4" class="<c:if test="${'4'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMobileDialog.html" nav-target="mainFrame">手机弹窗广告</a>
    </li>
    <li id="li_top_5" class="<c:if test="${'5'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewPcenterAd.html" nav-target="mainFrame">玩家中心首页广告</a>
    </li>
</ul>
<!--//endregion your codes 1-->
