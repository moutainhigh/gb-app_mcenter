<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.CttLogoListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<div class="row">

  <div class="position-wrap clearfix">
    <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
    <span>${views.sysResource['内容']}</span><span>/</span><span>${views.sysResource['公告栏管理']}</span>
  </div>

  <form:form action="${root}/cttAnnouncement/list.html" method="post">
    <form:hidden path="validateRule" />
  <div class="col-lg-12">
    <div class="wrapper white-bg shadow">
      <div class="clearfix filter-wraper border-b-1">
        <soul:button target="${root}/cttAnnouncement/addAnnouncement.html" title="${views.content['cttAnnouncement.create']}" tag="button" opType="dialog" text="${views.common['create']}" cssClass="btn btn-info btn-addon" callback="callBackQuery"><i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span></soul:button>

        <div class="function-menu-show hide">
            <soul:button tag="button" target="${root}/cttAnnouncement/batchDeleteAnn.html" precall="" opType="ajax" text="${views.common['delete']}" post="getSelectIds" cssClass="btn btn-danger-hide _delete" callback="query" confirm="确认删除?"><i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span></soul:button>
        </div>

        <div class="search-wrapper btn-group pull-right m-r-n-xs">
          <div class="input-group">
            <form:input class="form-control" path="search.content" placeholder="${views.content['cttAnnouncement.search.content']}"/>
            <span class="input-group-btn"><soul:button target="query" opType="function" text="" cssClass="btn btn-filter"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span></soul:button></span>
          </div>
        </div>
        <!--//endregion your codes 2-->
      </div>
      <div id="editable_wrapper" class="dataTables_wrapper search-list-container" role="grid">
        <%@ include file="IndexPartial.jsp" %>
      </div>
    </div>
  </div>
  </form:form>
  </div>

  <!--//region your codes 3-->
  <soul:import res="site/content/cttannouncement/Index"/>
  <!--//endregion your codes 3-->