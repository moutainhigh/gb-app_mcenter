<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>整体走势 - 图表</title>
    <%@ include file="/include/include.head.jsp" %>
    <script type="text/javascript" src="${root}/message_<%=SessionManagerCommon.getLocale().toString()%>.js?v=${rcVersion}"></script>
    <script type="text/javascript">
        var language = '${language.replace('_','-')}';
        var entrance = '${S_ENTRANCE}';
    </script>
    <%@ include file="/include/include.js.jsp" %>
    <script type="text/javascript">
        curl(['site/ReportTopPage', 'site/Index'], function (TopPage, Index) {
            topPage = new TopPage();
            index = new Index();
        });
    </script>
</head>
<body>

<div class="container gaikuang-page">
    <div class="menu _menu">
      <nav>
        <h1 class="name">捷报系统中心 <font>statement system</font></h1>
            <ul class="list-group">
                <li class="list-group-item active"><p class="tit"><i class="gaikuang"></i><a href="#">站点日常数据</a></p>
                <ul class="hideMenu" style="display: block;">
                    <li class="active"><a href="/daily/realTimeSummary.html" nav-target="mainFrame">实时总览</a></li>
                    <li><a href="/daily/operationTrends.html" nav-target="mainFrame">运营日常统计</a></li>
                    <li><a href="/daily/activePlayer.html" nav-target="mainFrame">活跃玩家</a></li>
                    <li><a href="/daily/playerRetain.html" nav-target="mainFrame">玩家留存</a></li>
                    <li><a href="/daily/newAddedPlayer.html" nav-target="mainFrame">新增玩家</a></li>
                </ul></li>
                <li class="list-group-item"><p class="tit"><i class="player"></i><a href="#">战点市场数据</a></p></li>
                <li class="list-group-item"><p class="tit"><i class="deposit"></i><a href="#">玩家分析</a></p></li>
                <li class="list-group-item"><p class="tit"><i class="game"></i><a href="#">付费分析</a></p></li>
                <li class="list-group-item"><p class="tit"><i class="deposit"></i><a href="#">活动数据分析</a></p></li>
                <li class="list-group-item"><p class="tit"><i class="player"></i><a href="#">API用户细分</a></p></li>
            </ul>
      </nav>
    </div>
    <div class="main-content _mainContent">
      <div class="_drawer-mask"></div>
      <!--头部信息：-->
      <div class="top-info text-right">
        <div class="icon-menu _showMenu"></div>
        <ul>
          <li class="time"><span></span><p>GMT+8 2018-2-20 15:30:30</p></li>
          <li class="webName"><span></span>
            <div class="chooseSite _chooseSite">
              <a class="btn dropdown-toggle"  id="dropdownSite" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">站点A</a>
              <div class="dropdown-menu" aria-labelledby="dropdownSite">
                <a class="dropdown-item" href="#">站点A</a>
                <a class="dropdown-item" href="#">站点B</a>
                <a class="dropdown-item" href="#">站点C</a>
              </div>
            </div>
          </li>
          <li class="username"><span></span>
            <div class="chooseAdmin">
              <a class="btn dropdown-toggle"  id="dropdownAdmin" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Admin</a>
              <div class="dropdown-menu" aria-labelledby="dropdownAdmin">
                  <a class="dropdown-item" href="#">退出</a>
                  <a class="dropdown-item" href="#">重新登录</a>
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
</body>
</html>