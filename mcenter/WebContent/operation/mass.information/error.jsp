<%--
  Created by IntelliJ IDEA.
  User: snekey
  Date: 15-9-8
  Time: 上午11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<ul class="artificial-tab clearfix">
  <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">1</span><span class="con">${views.operation['MassInformation.sendMethod']}</span></a></li>
  <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">2</span><span class="con">${views.operation['MassInformation.chooseUser']}</span></a></li>
  <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">3</span><span class="con">${views.operation['MassInformation.sendContent']}</span></a></li>
  <li class="col-sm-2 col-xs-12 p-x"><a href="javascript:void(0)"><span class="no">4</span><span class="con">${views.operation['MassInformation.preview']}</span></a></li>
  <li class="col-sm-2 col-xs-12 p-x"><a class="current" href="javascript:void(0)"><span class="no">5</span><span class="con">${views.operation['MassInformation.failure']}</span></a></li>
</ul>
<div class="fundsContext step-finish p-b-lg clearfix">
  <div class="col-xs-5 al-right">
    <i class="success fa fa-smile-o"></i>
  </div>
  <div class="col-xs-7">
    <div class="success p-t-sm">${views.operation['operation.failure']}</div>
  </div>
</div>
<div class="operate-btn">
  <soul:button target="sendPreview" text="${views.operation['operation.retry']}" opType="function" cssClass="btn btn-filter btn-lg"></soul:button>
  <a href="/operation/massSend/chooseType.html" nav-target="mainFrame" class="btn btn-filter btn-lg">${views.operation['operation.abandonOperations']}</a>
</div>
