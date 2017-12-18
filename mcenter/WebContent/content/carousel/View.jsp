<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.VCttCarouselListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->
<!--//endregion your codes 1-->

<form:form action="${root}/content/vCttCarousel/list.html" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>

    <!--//region your codes 2-->
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['轮播广告']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="panel blank-panel">
                    <div class="panel-options">
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
                    </div>
                    <div class="panel-body">
                        <input type="hidden" value="${siteId}" name="siteId"/>
                        <div class="tab-content" id="tab-content1">
                            <%@include file="msiteDialog/IndexPartial.jsp"%>
                        </div>
                        <div class="tab-content hide" id="tab-content2">
                        </div>
                        <div class="tab-content hide" id="tab-content3">
                        </div>
                        <div class="tab-content hide" id="tab-content4">
                        </div>
                        <div class="tab-content hide" id="tab-content5">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<!--//endregion your codes 2-->

<!--//region your codes 3-->
<soul:import res="site/content/carousel/View"/>
<script type="text/javascript">
    curl(['site/content/carousel/ViewMsiteDialog'], function(Page) {
        page.index = new Page();
    });
</script>
<!--//endregion your codes 3-->