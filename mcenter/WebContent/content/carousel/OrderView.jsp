<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VCttCarouselListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<!--//endregion your codes 1-->

<form:form action="${root}/content/vCttCarousel/list.html" method="post">

    <!--//region your codes 2-->

                        <ul class="clearfix sys_tab_wrap">
                            <li class="active">
                                <a data-toggle="tab" index="1" data-href="/content/vCttCarousel/viewMsiteDialog.html?partial=true" aria-expanded="false">
                                    PC端首页弹窗广告
                                </a>
                            </li>
                            <li class="">
                                <a data-toggle="tab" index="2" data-href="/content/vCttCarousel/viewMsiteCarousel.html" aria-expanded="false">
                                    PC端首页轮播图
                                </a>
                            </li>
                            <li class="">
                                <a data-toggle="tab" index="3" data-href="/content/vCttCarousel/viewMobileCarousel.html" aria-expanded="false">
                                    手机轮播图
                                </a>
                            </li>
                            <li class="">
                                <a data-toggle="tab" index="4" data-href="/content/vCttCarousel/viewMobileDialog.html" aria-expanded="false">
                                    手机弹窗广告
                                </a>
                            </li>
                            <li class="">
                                <a data-toggle="tab" index="5" data-href="/content/vCttCarousel/viewPcenterAd.html" aria-expanded="false">
                                    玩家中心首页广告
                                </a>
                            </li>
                        </ul>

</form:form>
<!--//endregion your codes 2-->

<!--//region your codes 3-->

<!--//endregion your codes 3-->