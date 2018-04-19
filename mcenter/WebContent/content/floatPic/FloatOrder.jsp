<%@ page import="java.util.Date" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->

<!--//region your codes 2-->
<form:form action="/cttFloatPic/FloatOrder.html" method="post">
<div class="row">

    <div class="position-wrap clearfix">
        <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
        <span>${views.sysResource['内容']}</span>
        <span>/</span><span>${views.sysResource['浮动图管理']}</span>
        <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
            <em class="fa fa-caret-left"></em>${views.common['return']}
        </soul:button>
    </div>

    <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
            <div class="clearfix filter-wraper border-b-1">
                <div class=" clearfix m-sm">
                    <i class="fa fa-exclamation-circle"></i><span class="co-yellow m-l-sm">${views.common['DynamicLie.draggingSort']}</span>
                </div>
            </div>
            <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
                <table class="table table-striped table-hover dataTable m-b-sm dragdd" aria-describedby="editable_info">
                    <thead>
                    <tr role="row" class="bg-gray">
                        <th width="80">${views.common['number']}</th>

                        <th>${views.column['CttFloatPic.title']}</th>
                        <th>${views.column['CttFloatPic.type']}</th>

                    </tr>
                    <tr class="bd-none hide">
                        <th colspan="7">
                        </th>
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
                            <tr class="tab-detail dd-item1">
                                <input class="td-handle1" type="hidden" name="floatType" value="${p.id}"/>
                                <td class="">${(command.paging.pageNumber-1)*command.paging.pageSize+(status.index+1)}</td>
                                <td class="td-handle1">${p.title}</td>
                                <td class="td-handle1">${dicts.setting.float_pic_type[p.picType]}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="operate-btn" style="text-align: center">
                <soul:button target="saveFloatOrder" text="${views.common['OK']}" opType="function"
                             cssClass="btn btn-filter btn-lg m-r" >${views.common['OK']}</soul:button>
                <soul:button target="goToLastPage" text="${views.common['cancel']}" opType="function"
                             cssClass="btn btn-outline btn-filter btn-lg m-r" >${views.common['cancel']}</soul:button>
            </div>
        </div>
    </div>

</div>
</form:form>
<!--//endregion your codes 2-->


<!--//region your codes 3-->
<!--//region your codes 4-->
<soul:import res="site/content/floatPic/FloatOrder"/>
<!--//endregion your codes 4-->

<!--//endregion your codes 1-->
