<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="${root}/vCttDocument/toOrderList.html" method="post">
<div class="row">

    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['文案管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>


        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <input type="hidden" value="${command.search.parentId}" name="parentId" id="parentId">
                <div class="sys_tab_wrap clearfix">
                    <div class=" clearfix m-sm">
                        <i class="fa fa-exclamation-circle"></i><span class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                    </div>
                </div>
                <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                    <table class="table table-striped table-hover dataTable m-b-sm dragdd" aria-describedby="editable_info">
                        <thead>
                        <tr role="row" class="bg-gray">
                            <th>${views.column['VCttDocument.orderNum']}</th>
                            <th>${views.column['VCttDocument.code']}</th>
                            <th>${views.content['document.projectName']}</th>
                            <th>${views.column['VCttDocument.checkStatus']}</th>
                            <th>${views.column['VCttDocument.status']}</th>
                            <th>${views.content['document.languageVersion']}</th>
                            <th>${views.column['VCttDocument.publishTime']}</th>
                            <th>${views.column['VCttDocument.childCount']}</th>
                            <th>${views.content['isEnable']}</th>
                        </tr>
                        </thead>
                        <tbody class="dd-list1">
                        <c:if test="${empty command.result}">
                            <td colspan="7" class="no-content_wrap">
                                <div>
                                    <i class="fa fa-exclamation-circle"></i> ${views.common['noResult']}
                                </div>
                            </td>
                        </c:if>
                        <c:forEach items="${command.result}" var="p" varStatus="status">
                        <tr class="tab-detail over dd-item1">
                            <input type="hidden" name="documentId" value="${p.id}" class="td-handle1"/>
                            <td class="td-handle1" style="width: 8%">${p.orderNum}</td>
                            <td class="td-handle1" style="width: 10%">${p.code}</td>
                            <td class="td-handle1" style="width: 12%">${cacheMap[p.id.toString()].title}</td>
                            <td class="td-handle1" style="width: 10%">${dicts.content.check_status[p.checkStatus]}</td>
                            <td class="${p.status=='on'?'':'co-gray9'} td-handle1" style="width: 50px">
                                <c:if test="${p.checkStatus=='2'}">
                                    --
                                </c:if>
                                <c:if test="${p.checkStatus!='2'}">
                                    ${dicts.content.draft_status[p.status]}
                                </c:if>

                            </td>
                            <td class="td-handle1" style="width: 10%">
                                <div class="btn-group">
                                    <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle btn-xs">${p.languageCount}/${languageCount}</button>
                                </div>
                            </td>
                            <td class="td-handle1" style="width: 12%">${soulFn:formatDateTz(p.publishTime, DateFormat.DAY_SECOND,timeZone)}</td>
                            <td class="td-handle1" style="width: 10%"><a href="javascript:void(0)" class="over">${p.childCount}${views.content['document.item']}<i></i></a></td>
                            <td class="td-handle1">
                                <c:if test="${p.checkStatus==null||p.checkStatus!='0'}">
                                    <c:if test="${p.checkStatus=='1'}">
                                        <input type="checkbox" name="my-checkbox" data-size="mini" ${p.status=='on'?'checked':''} disabled="disabled" documentId="${p.id}">
                                    </c:if>
                                    <c:if test="${p.checkStatus=='2'}">
                                        <input type="checkbox" name="my-checkbox" data-size="mini" disabled="disabled">
                                    </c:if>
                                </c:if>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="operate-btn">
                    <soul:button target="saveDocumentOrder" text="${views.common['save']}" opType="function"
                                 cssClass="btn btn-outline btn-filter btn-lg m-r" >${views.common['save']}</soul:button>
                    <a href="/vCttDocument/list.html" nav-target="mainFrame" id="reback_btn"></a>
                </div>
            </div>
        </div>

</div>
</form:form>
<!--//endregion your codes 2-->


<!--//region your codes 3-->
<!--//region your codes 4-->
<soul:import res="site/content/cttdocument/OrderList"/>
<!--//endregion your codes 4-->

<!--//endregion your codes 1-->
