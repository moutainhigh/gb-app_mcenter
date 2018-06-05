<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<ul class="clearfix sys_tab_wrap">
    <li id="li_top_1" class="<c:if test="${'carousel_type_ad_dialog'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMsiteDialog.html" nav-target="mainFrame">PC端首页弹窗广告</a>
    </li>
    <li id="li_top_2" class="<c:if test="${'carousel_type_index'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMsiteCarousel.html" nav-target="mainFrame">PC端首页轮播图</a>
    </li>
    <li id="li_top_3" class="<c:if test="${'carousel_type_phone'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMobileCarousel.html" nav-target="mainFrame">手机轮播图</a>
    </li>
    <li id="li_top_4" class="<c:if test="${'carousel_type_phone_dialog'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewMobileDialog.html" nav-target="mainFrame">手机弹窗广告</a>
    </li>
    <li id="li_top_5" class="<c:if test="${'carousel_type_player_index'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewPcenterAd.html" nav-target="mainFrame">玩家中心首页广告</a>
    </li>
    <li id="li_top_6" class="<c:if test="${'carousel_type_ad_register'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewRegister.html" nav-target="mainFrame">PC端注册页广告</a>
    </li>
    <li id="li_top_7" class="<c:if test="${'carousel_type_app_push_ad'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewAppPushAd.html" nav-target="mainFrame">APP推送广告</a>
    </li>
    <li id="li_top_8" class="<c:if test="${'carousel_type_app_start_page'.equals(webType)}">active</c:if>">
        <a href="/content/vCttCarousel/viewAppStartPage.html" nav-target="mainFrame">APP启动页</a>
    </li>
</ul>
<!--//endregion your codes 1-->
