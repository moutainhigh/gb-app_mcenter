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
    <input type="hidden" name="search.announcementType" value="${command.search.announcementType}">
      <div class="col-lg-12">
        <div class="wrapper white-bg shadow">
          <ul class="clearfix sys_tab_wrap">
            <c:choose>
              <c:when test="${empty command.search.announcementType || command.search.announcementType=='1'}">
                <li class="active">
               </c:when>
               <c:otherwise>
                <li>
               </c:otherwise>
              </c:choose>
              <a href="/cttAnnouncement/list.html?search.announcementType=1" nav-target="mainFrame">站点公告</a>
            </li>
              <c:choose>
              <c:when test="${command.search.announcementType=='2'}">
              <li class="active">
                </c:when>
                <c:otherwise>
              <li>
                </c:otherwise>
                </c:choose>
              <a href="/cttAnnouncement/list.html?search.announcementType=2" nav-target="mainFrame">银行维护</a>
            </li>
              <c:choose>
              <c:when test="${command.search.announcementType=='3'}">
              <li class="active">
                </c:when>
                <c:otherwise>
              <li>
                </c:otherwise>
                </c:choose>
              <a href="/cttAnnouncement/list.html?search.announcementType=3" nav-target="mainFrame">注册公告</a>
            </li>
              <c:choose>
              <c:when test="${command.search.announcementType=='4'}">
              <li class="active">
                </c:when>
                <c:otherwise>
              <li>
                </c:otherwise>
                </c:choose>
              <a href="/cttAnnouncement/list.html?search.announcementType=4" nav-target="mainFrame">登录公告</a>
            </li>
          </ul>
          <div class="clearfix filter-wraper border-b-1">
            <soul:button target="${root}/cttAnnouncement/addAnnouncement.html?announcementType=${command.search.announcementType}" title="${views.content['cttAnnouncement.create']}" tag="button" opType="dialog" text="${views.common['create']}" cssClass="btn btn-info btn-addon" callback="callBackQuery"><i class="fa fa-plus"></i><span class="hd">${views.common['create']}</span></soul:button>
            <c:if test="${command.search.announcementType == '1' || command.search.announcementType == '2'}">
              <div class="pull-left m-t-n-xxs">
                <a class="btn btn-outline btn-filter" nav-target="mainFrame"
                   href="/cttAnnouncement/orderCttAnnouncement.html?search.announcementType=${command.search.announcementType}">
                  <i class="fa fa-sort-amount-desc m-r-xs"></i>${views.common['order']}
                </a>
                <a href="" id="tot" nav-target="mainFrame" style="display: none"></a>
              </div>
            </c:if>
            <div class="function-menu-show hide">
                <soul:button tag="button" target="${root}/cttAnnouncement/batchDeleteAnn.html" precall="" opType="ajax" text="${views.common['delete']}" post="getSelectIds" cssClass="btn btn-danger-hide _delete" callback="query" confirm="${views.content_auto['确认删除']}?"><i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span></soul:button>
            </div>

            <div class="search-wrapper btn-group pull-right m-r-n-xs">
              <div class="input-group">
                <form:input class="form-control" path="search.content" placeholder="${views.content['cttAnnouncement.search.content']}"/>
                <span class="input-group-btn"><soul:button target="query" opType="function" text="" cssClass="btn btn-filter" title="search"><i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span></soul:button></span>
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