<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form:form action="${root}/cttMaterialText/list.html" method="post">
    <script type="text/javascript">
        function getImageSize() {
            var img = this.event.currentTarget;
            var index = $(img).attr("index");
            var $span = $("span.span_" + index);
            $span.text($("#cc").text() + img.width + "*" + img.height);
        }
    </script>
    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['内容']}</span><span>/</span><span>${views.content['推广素材']}</span>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="filter-wraper clearfix p-xs">
                    <b>${views.content['material.showInFront']}:</b>
                    <c:set var="tx" value="${command.cttMaterialTextList[0]}"/>
                    <c:set var="pic" value="${command.cttMaterialPicList[0]}"/>
                    <span class="m-l-sm"><input type="checkbox" name="status"
                                                data-size="mini" ${(fn:length(command.cttMaterialTextList)+fn:length(command.cttMaterialPicList))>0?'':'disabled'} ${tx.status||pic.status?'checked':''}></span>
                    <div class="panel-options" style="margin-top: 15px">
                        <ul class="nav nav-tabs p-l-sm p-r-sm">
                            <li style="display:inline" class="active" ><a href="#zutiwuan" data-toggle="tab" id="wenanli"
                                                                         class="fs16">${views.content['material.zutiwuan']}</a>
                            </li>
                            <li style="display:inline" ><a href="#banner" data-toggle="tab" id="bannerli"
                                                          class="fs16">${views.content['material.bannerMaterial']}</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div id="zutiwuan" class="tab-pane active">
                            <div class="filter-wraper clearfix p-xs line-hi34">
                                <soul:button target="${root}/cttMaterialText/createCtt.html?search.type=text"
                                             text="${views.common['create']}"
                                             title="${views.content['material.createText']}"
                                             opType="dialog" callback="wenanCallback"
                                             cssClass="btn btn-info btn-addon pull-right"><i
                                        class="fa fa-plus"></i><span
                                        class="hd">${views.common['create']}</span></soul:button>
                            </div>
                            <c:forEach items="${command.cttMaterialTextList}" var="item" varStatus="status">
                                <div class=" m-sm">
                                    <div class="gray-chunk clearfix">
                                        <p>${item.content}</p>
                                        <div class="operate-btn clearfix">
                                            <span>${views.content['material.addTime']}：${soulFn:formatDateTz(item.createTime, DateFormat.DAY_SECOND,timeZone)}</span>
                                            <soul:button
                                                    target="${root}/cttMaterialText/deleteGroup.html?search.groupCode=${item.groupCode}&search.type=text"
                                                    confirm="${messages.common['delete.deleteConfirm']}"
                                                    text="${views.common['delete']}" opType="ajax" callback="query"
                                                    cssClass="btn btn-outline btn-filter btn-xs pull-right">${views.common['delete']}</soul:button>
                                            <soul:button
                                                    target="${root}/cttMaterialText/editMaterial.html?search.groupCode=${item.groupCode}&search.type=text"
                                                    text="${views.common['edit']}" opType="dialog" callback="wenanCallback"
                                                    cssClass="btn btn-outline btn-filter btn-xs pull-right m-r-xs">${views.common['edit']}</soul:button>
                                            </span></span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="banner" class="tab-pane">
                            <div class="filter-wraper clearfix p-xs line-hi34">

                                <soul:button target="${root}/cttMaterialText/createCtt.html?search.type=pic"
                                             text="${views.common['create']}"
                                             title="${views.content['material.create']}"
                                             opType="dialog" callback="bannerCallback"
                                             cssClass="btn btn-info btn-addon pull-right"><i
                                        class="fa fa-plus"></i><span
                                        class="hd">${views.common['create']}</span></soul:button>
                            </div>
                            <label id="cc" style="display: none;">${views.content['material.size']}：</label>
                            <c:forEach items="${command.cttMaterialPicList}" var="item" varStatus="status">
                                <div class=" m-sm">
                                    <div class="gray-chunk clearfix">
                                        <p>${item.title}</p>
                                        <div class="row">
                                            <div class="col-sm-12 "><img
                                                    data-original="${soulFn:getImagePath(domain, item.pic)}"
                                                    onload="getImageSize()" index="${status.index}"
                                                    class="img-responsive lazy"/></div>
                                        </div>
                                        <div class="operate-btn clearfix">
                                            <span>${views.content['material.addTime']}：${soulFn:formatDateTz(item.createTime, DateFormat.DAY_SECOND,timeZone)}</span>
                                            <span class="m-l-sm">${views.common['download']}：${soulFn:formatNumber(item.downloadCount)}${views.content['material.timeCount']}</span>
                                            <span class="m-l-sm span_${status.index}"></span>
                                            <soul:button
                                                    target="${root}/cttMaterialText/deleteGroup.html?search.groupCode=${item.groupCode}&search.type=pic"
                                                    text="${views.common['delete']}"
                                                    confirm="${messages.common['delete.deleteConfirm']}" opType="ajax"
                                                    callback="deleteCallback"
                                                    cssClass="btn btn-outline btn-filter btn-xs pull-right">${views.common['delete']}</soul:button>
                                            <soul:button
                                                    target="${root}/cttMaterialText/editMaterialPic.html?search.groupCode=${item.groupCode}&search.type=pic"
                                                    text="${views.common['edit']}" opType="dialog" callback="bannerCallback"
                                                    groupCode="${item.groupCode}"
                                                    cssClass="btn btn-outline btn-filter btn-xs pull-right m-r-xs">${views.common['edit']}</soul:button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="col-lg-12 m-t">--%>
            <%--<div class="wrapper white-bg shadow clearfix">--%>

            <%--</div>--%>
        <%--</div>--%>
    </div>
</form:form>
<soul:import res="site/content/material/MaterialIndex"/>