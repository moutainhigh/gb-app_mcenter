<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="logoutUrl" value="<%= SessionManager.getLogoutUrl() %>"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>整体走势 - 图表</title>
    <%@ include file="/include/include.head.jsp" %>
    <link rel="stylesheet" type="text/css" href="${resRoot}/themes/default/style.css"/>
    <script type="text/javascript" src="${root}/message_<%=SessionManagerCommon.getLocale().toString()%>.js?v=${rcVersion}"></script>
    <script type="text/javascript">
        var language = '${language.replace('_','-')}';
        var entrance = '${S_ENTRANCE}';
    </script>
    <%@ include file="/include/include.js.jsp" %>
    <script type="text/javascript">
        curl(['site/ReportTopPage', 'site/home/LeftNav', 'site/bootstrap-datetimepicker.min'],
            function (ReportTopPage, LeftNav, BootstrapDdatetimepicker) {
                topPage = new ReportTopPage();
                topNav = new LeftNav();
        });
    </script>
</head>
<body>

<div class="container gaikuang-page">
    <div class="menu _menu" style="background-color: #61cdff" id="side-menu-nav">

    </div>
    <div class="main-content _mainContent">
      <div class="_drawer-mask"></div>
      <!--头部信息：-->
      <div class="top-info text-right">
        <div class="icon-menu _showMenu"></div>
        <ul>
          <li class="time"><span></span><p><%=SessionManager.getTimeZone().getID() %>&nbsp;&nbsp;<%=SessionManager.getUserDate() %></p></li>
          <li class="webName"><span></span>
            <div class="chooseSite _chooseSite ">
              <a class="btn dropdown-toggle" id="dropdownSite" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" tabindex="0">${siteName}</a>
              <div class="dropdown-menu" aria-labelledby="dropdownSite">
                <a class="dropdown-item" href="#">站点A</a>
                <a class="dropdown-item" href="#">站点B</a>
                <a class="dropdown-item" href="#">站点C</a>
              </div>
            </div>
          </li>
          <li class="username"><span></span>
            <div class="chooseAdmin">
              <a class="btn dropdown-toggle" id="dropdownAdmin" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" tabindex="0" >
                  <%=SessionManager.getUserName()%></a>
                <div class="dropdown-menu" aria-labelledby="dropdownAdmin">
                  <a class="dropdown-item" href="${root}${logoutUrl}">退出</a>
                  <a class="dropdown-item" href="${root}${logoutUrl}">重新登录</a>
                </div>
            </div>
          </li>
        </ul>
      </div>

      <!--内容区域：-->
      <div class="content" id="mainFrame">
      </div>
    </div>
</div>

<div class="footer">
    <div class="pull-right">
        <div class="btn-group dropup" id="divLanguage">
            <%--<button type="button" class="btn btn-outline btn-filter dropdown-toggle language-btn m-sm"
                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
            <ul class="dropdown-menu dropdown-menu-right m-sm m-b-none"></ul>--%>
        </div>
    </div>
    <div class="a-copy clearfix">
        <div class="pull-left">
            <%--<a href="javascript:void(0)">${views.home['index.customService']}</a><span class="dividing-line m-r-xs m-l-xs">|</span>
            <a href="javascript:void(0)" id="feedback">${views.home['index.feedback']}</a>--%>
        </div>
    </div>
</div>
</body>
</html>