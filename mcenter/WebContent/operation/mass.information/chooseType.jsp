<%--
  Created by IntelliJ IDEA.
  User: snekey
  Date: 15-9-7
  Time: 上午10:45
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form>
  <div class="row">
    <div class="position-wrap clearfix">
      <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
      <span>${views.sysResource['内容']}</span>
      <span>/</span><span>${views.sysResource['信息群发']}</span>
      <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
    </div>
    <div class="col-lg-12">
      <div class="wrapper white-bg shadow _changeArea">
        <div class="clearfix line-hi34 p-xs">
          <div class="pull-right m-l">
            <a href="/operation/massInformation/history.html" nav-target="mainFrame">${views.operation['MassInformation.history']}</a>
          </div>
        </div>
        <hr class="m-t-xxs m-b-sm">
        <ul class="artificial-tab clearfix">
          <li class="col-sm-2 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['MassInformation.sendMethod']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['MassInformation.chooseUser']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['MassInformation.sendContent']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">4</span><span class="con">${views.operation['MassInformation.preview']}</span></a></li>
          <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">5</span><span class="con">${views.operation['MassInformation.finish']}</span></a></li>
        </ul>
        <div class="al-center m-t-lg m-b-lg p-t-sm p-b-sm">
          <label class="ft-bold m-r-lg"><input type="radio" name="sendType" class="i-checks" <c:if test="${sendType=='siteMsg'}">checked</c:if> value="siteMsg">${dicts.notice.publish_method['siteMsg']}</label>
          <label class="ft-bold m-l-lg m-r-lg"><input type="radio" name="sendType" class="i-checks" <c:if test="${sendType=='email'}">checked</c:if> value="email">${dicts.notice.publish_method['email']}</label>
         <%-- <label class="ft-bold m-l-lg"><input type="radio" name="sendType" class="i-checks" <c:if test="${sendType=='sms'}">checked</c:if> value="sms">${views.operation_auto['短信信息']}</label>--%>
        </div>
        <div class="operate-btn">
          <soul:button target="chooseUser" text="${views.common['next']}" opType="function"  cssClass="btn btn-filter btn-lg"/>
        </div>
      </div>
    </div>
  </div>
</form>
<soul:import res="site/operation/mass.information/chooseType"/>