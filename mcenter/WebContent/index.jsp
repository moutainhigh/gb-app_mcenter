<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:set var="logoutUrl" value="<%= SessionManager.getLogoutUrl() %>"/>
<!DOCTYPE html>
<head>
    <title>${views.common['首页']} - ${views.common['站长中心']} - ${siteName}</title>
    <%@ include file="/include/include.head.jsp" %>
    <link rel="icon" type="image/png" href="../ftl/${siteDomain.templateCode}/zh_TW/images/favicon.png" sizes="32x32">
    <style type="text/css">
        .carousel-fill {
            background-position: center;
            text-align: center;
        }

        .carousel-fill img {
            /*设置图片垂直居中*/
            vertical-align: middle;
            max-width: 100%;
            max-height: 100%;
        }

        /* faster sliding speed */
        .carousel-inner > .item {
            -webkit-transition: 0.3s ease-in-out left;
            -moz-transition: 0.3s ease-in-out left;
            -o-transition: 0.3s ease-in-out left;
            transition: 0.3s ease-in-out left;
        }
        /*.popover {
            max-width:330px;
        }*/
    </style>
    <script type="text/javascript" src="${root}/message_<%=SessionManagerCommon.getLocale().toString()%>.js?v=${rcVersion}"></script>
    <script type="text/javascript">
        var language = '${language.replace('_','-')}';
        //    mcenter专用
        var entrance = '${S_ENTRANCE}';
    </script>
    <%@ include file="/include/include.js.jsp" %>

    <script type="text/javascript">
        curl(['gb/home/TopPage', 'gb/home/TopNav', 'gb/home/LeftNav', 'site/index/msgManager', 'site/index/Comet',
            'site/index/taskManager', 'site/setting/shortcutmenu/ShortcutMenu', 'site/home/LeftIndex',
            'site/index/ProfitLimit','jqmetisMenu',
            'jqnouislider'], function (TopPage, TopNav, LeftNav, MsgManager, Comet, TaskManager, ShortcutMenu,LeftIndex, ProfitLimit) {
            topPage = new TopPage();
            topNav = new TopNav();
            leftNav = new LeftNav();
            msgManager = new MsgManager();
            shortcutMenu = new ShortcutMenu();
            taskManager = new TaskManager();
            leftIndex = new LeftIndex();
            leftIndex.bindButtonEvents();
            profitLimit = new ProfitLimit();
            comet = new Comet();
            //刷新任务提示入口
            topPage.taskManager=taskManager;
            /*add by eagle*/
            document.getElementById("feedback").onclick = function() {
                topPage.doDialog({}, {
                    text: "${views.common['意见反馈']}",
                    target: root + "/feedBack/toFeedBack.html",
                    closable: true
                });
            };
        });
        function updateLoginPwd(title){
            var btnOption = {};
            btnOption.target = root + "/myAccount/toUpdatePassword.html";
            btnOption.text = title;
            btnOption.callback = function (e, opt) {

            };
            window.top.topPage.doDialog({}, btnOption);
        }
        function updatePowerPwd(title){
            var btnOption = {};
            btnOption.target = root + "/myAccount/toUpdatePrivilegePassword.html";
            btnOption.text = title;
            btnOption.callback = function (e, opt) {

            };
            window.top.topPage.doDialog({}, btnOption);
        }
    </script>
    <script id="topMenuTmpl" type="text/x-jsrender">
        {{for m}}
            <li id="menuItem{{:object.id}}" class="dropdown">
                <a data-toggle="dropdown" {{if object.resourceUrl == '' || object.resourceUrl == null}} href='#' {{else}} href='javascript:void(0);' data='/{{: object.resourceUrl}}' nav-target='mainFrame' {{/if}} role="button" aria-haspopup="true" aria-expanded="false">
                <div class="icon"><i class="{{:object.resourceIcon}} iconfont "></i></div><span>{{:object.resourceRName}}</span>
                </a>
                {{if children!=null && children.length>0}}
                <ul class="dropdown-menu">
                    {{for children}}
                        <li><a {{if object.resourceUrl == '' || object.resourceUrl == null}} href='/index/content.html?parentId={{:object.id}}' {{else}} href='/{{: object.resourceUrl}}' {{/if}}
                         nav-target="mainFrame"><em class="iconfont {{:object.resourceIcon}}"></em> {{:object.resourceRName}}</a></li>
                    {{/for}}
                </ul>
                {{/if}}
            </li>
        {{/for}}
    </script>
    <%--<a aria-expanded="false" role="button" nav-top='page-content'
       {{if object.resourceUrl == '' || object.resourceUrl == null}} href='/index/content.html?parentId={{:object.id}}' {{else}} href='/{{: object.resourceUrl}}' {{/if}}
    ><div class="icon"><i class="icon iconfont">{{:object.resourceIcon}}</i></div><span>{{:object.resourceRName}}</span></a>--%>
    <div id="task_music" class="hide"></div>
    <div id="auto_alert" class="hide"></div>
</head>
<body class="background-gray">
<div class="top">
    <a href="/exports/exportHistoryList.html?search.hasReturn=true" nav-target="mainFrame" class="hide" id="toExportHistory"></a>
    <a name="menuToUrl" id="menuToUrl" href="" nav-target="mainFrame" class="hide"></a>
    <input type="hidden" value="${indexDomainTemp}" id="indexDomainTemp"/>
    <input type="hidden" value="${managerDomainTemp}" id="managerDomainTemp"/>
    <input type="hidden" value="${medias}" id="medias"/>
    <div id="unTaskList" hidden>${unTaskList}</div>
    <a id="toSetting" href="/content/sysDomain/list.html" nav-target="mainFrame" hidden></a>
    <%--层级账户不足，跳到层级的存款设置--%>
    <a id="rankInadequate" href="" nav-target="mainFrame" hidden></a>

    <div class="pull-right top-account-menu">
        <ul class="tips">
            <li class="informations top-online-people">
                <a href="javascript:void(0)" class="locate" data-toggle="dropdown">
                    <i class="icon-online iconfont"></i>
                </a>
                <dl class="infos_list nav-shadow">

                    <dd class="infos-none t-left">
                        <div>${views.common['当前时区']}：<%= SessionManager.getTimeZone().getID() %></div>
                        <div>${views.common['当前时间']}：<div id="index-clock" class="clock-show"></div></div>
                        <div>${views.common['当前在线人数']}： <i class="co-orange" id="onlinePlayerNum">0</i> 人</div>
                        <div>${views.common['当前活跃人数']}： <i class="co-orange" id="activePlayerNum">0</i> 人</div>

                    </dd>
                </dl>
            </li>
            <li class="infos show-info">
                <a href="javascript:void(0)" class="locate" data-toggle="dropdown">
                    <span data-content="${sessionSysUser.username}" data-html="true" class="top-tip"
                          data-placement="bottom" data-trigger="focus" data-container="body" role="button" tabindex="0">
                        <i class="icon-logins iconfont"></i>
                    </span>

                </a>
                <ul class="information nav-shadow">
                    <%--<li>
                        <a href="javascript:void(0)">
                            <i class="fa fa-user"></i>
                            ${sessionSysUser.username}
                        </a>
                    </li>--%>
                    <shiro:hasPermission name="system:subaccount_role">
                        <li><a href="/subAccount/role.html" nav-target="mainFrame"><i class="fa fa-user"></i>${views.common['我的权限']}</a></li>
                    </shiro:hasPermission>

                    <li>
                        <a href="/report/log/logList.html" nav-target="mainFrame"><i class="fa fa-file-o"></i>${views.common['操作日志']}</a>
                    </li>
                    <li>
                        <a href="javascript:updateLoginPwd('${views.setting['myAccount.updateAccountPassword']}');"><i class="fa fa-key"></i>${views.common['修改登录密码']}</a>
                    </li>
                    <li>
                        <a href="javascript:updatePowerPwd('${views.setting['myAccount.updatePrivilegePassword']}');"><i class="fa fa-umbrella"></i>${views.common['修改安全密码']}</a>
                    </li>
                    <c:if test="${isMaster}">
                        <li>
                            <a href="/param/siteParam.html?index=li_top_2" nav-target="mainFrame"><i class="fa fa-heart"></i>${views.common['偏好设置']}</a>
                        </li>
                    </c:if>
                    <li class="off">
                        <a href="${root}${logoutUrl}" target="_top"><i class="fa fa-power-off"></i>${views.common['退出']}</a>
                    </li>
                </ul>
            </li>
            <%--<li class="informations" style="margin-right: 15px;">
                <span data-content="${views.common['在线玩家本站点']}" data-html="true" class="top-tip"
                      data-placement="bottom" data-trigger="focus" data-container="body" role="button" tabindex="0">
                            <i class="fa fa-question-circle" style="color: white"></i>
                        </span>
                ${views.common['在线玩家']}：
                        <span id="activePlayerNum" data-content="0" data-html="true" class="top-tip"
                              data-placement="bottom" data-trigger="focus" data-container="body" role="button" tabindex="0">
                            <a href="/vPlayerOnline/list.html?search.hasReturn=true" nav-target="mainFrame"><span class="co-tomato" style="color: #ffffff" id="onlinePlayerNum">0</span></a>
                        </span>${views.common['位']}
            </li>--%>


            <%--<li class="infos show-info">
                <a data-toggle="dropdown" style="min-width: 100px">
                    &lt;%&ndash;<img alt="image" class="img-circle" src="${soulFn:getImagePathWithDefault(domain,sessionSysUser.avatarUrl,resRoot.concat('/images/profile_small.jpg'))}">&ndash;%&gt;
                    ${sessionSysUser.username}
                    <i class="fa fa-angle-down"></i></a>
                <ul class="information nav-shadow">
                    <c:if test="${isMaster}">
                    <li><a href="/param/siteParam.html?index=li_top_2" nav-target="mainFrame"><i class="fa fa-heart"></i>${views.common['偏好设置']}</a></li>
                    </c:if>
                    <li><a href="/report/log/logList.html" nav-target="mainFrame"><i class="fa fa-file-excel-o"></i>${views.common['操作日志']}</a></li>
                    <li>
                        <a href="javascript:updateLoginPwd('${views.setting['myAccount.updateAccountPassword']}');"><i class="fa fa-key"></i>${views.common['修改登录密码']}</a>
                    </li>
                    <li><a href="javascript:updatePowerPwd('${views.setting['myAccount.updatePrivilegePassword']}');"><i class="fa fa-key"></i>${views.common['修改安全密码']}</a></li>
                    <shiro:hasPermission name="system:subaccount_role">
                        <li><a href="/subAccount/role.html" nav-target="mainFrame"><i class="fa fa-user"></i>${views.common['我的权限']}</a></li>
                    </shiro:hasPermission>
                    &lt;%&ndash;<li><a href="/myAccount/myAccount.html" nav-target="mainFrame"><i class="fa fa-user"></i> 个人资料</a></li>&ndash;%&gt;
                    <li class="off"><a href="${root}${logoutUrl}" target="_top">${views.common['退出']}<i class="fa fa-power-off"></i></a></li>
                </ul>
            </li>--%>

            <shiro:hasPermission name="operate:announcement">
                <li class="informations">
                    <div id="msg_music">
                    </div>
                    <input id="isReminderMsg" type="hidden" value="${isReminderMsg}"/>
                    <a href="javascript:void(0)" class="locate" data-toggle="dropdown" data-href="${root}/index/message.html" >
                        <i class="icon iconfont"></i><span class="label label-green" id="unReadCount">${unReadCount}</span>
                    </a>
                    <dl class="infos_list nav-shadow">
                        <dt>${views.common['系统消息']}</dt>
                        <dd class="infos-load">
                            <img src="${resRoot}/images/022b.gif">
                        </dd>
                    </dl>
                </li>
            </shiro:hasPermission>

            <li class="tasks">

                <input id="isReminderTask" type="hidden" value="${isReminderTask}"/>

                <a href="javascript:void(0)" class="locate" data-toggle="dropdown"  data-href="${root}/index/task.html"><i
                        class="icon iconfont"></i><span class="label label-orange" id="unReadTaskCount">${empty unReadTaskCount?0:unReadTaskCount}</span></a>
                <dl class="infos_list tasks_list nav-shadow">
                    <dt>${views.common['任务提醒']}</dt>
                    <dd class="infos-load">
                        <img src="${resRoot}/images/022b.gif">
                    </dd>
                </dl>
            </li>
            <%--盈利上限,站点列表,只有站长账号才展示--%>
            <c:if test="${isMaster}">
                <!--盈利上限开始-->
                <li class="top-security safety" id="topSecurity" style="display: none">
                    <a id="myProfit" href="javascript:void(0)" class="locate" data-toggle="dropdown">
                        <i class="icon-baozhang iconfont"></i>
                    </a>
                    <dl class="infos_list tasks_list nav-shadow">
                        <dt>${views.common['我的盈利上限']}</dt>
                        <dd>
                            <div class="clearfix">
                                <a href="javascript:">${views.common['盈利上限']}：</a>
                                <span id="profitLimit"></span>
                            </div>
                        </dd>
                        <dd>
                            <div class="clearfix">
                                <a href="javascript:">${views.common['当前盈利']}：</a>
                                <span id="curProfit"></span>
                            </div>
                        </dd>
                        <dd>
                            <div class="clearfix">
                                <a href="javascript:">${views.common['已使用']}：</a>
                                <span id="usePercent"></span>
                            </div>
                        </dd>
                    </dl>
                </li>
                <!--盈利上限开始-->
                <!--站点列表开始-->
                <li class="infos show-info">
                    <a data-toggle="dropdown" class="language" style="min-width: 100px">
                            <%--<img src="${soulFn:getThumbPath(domain,logo,32,16)}">--%>
                            ${siteNames.get(siteId)}<i class="fa fa-angle-down"></i></a>
                    <ul class="language nav-shadow">
                        <c:forEach items="${sites}" var="s">
                            <c:if test="${siteId!=s.id}">
                                <li class="sites" siteId="${s.id}">${siteNames.get(s.id)}</li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </li>
                <!--站点列表结束-->
            </c:if>

        </ul>
    </div>
</div>
<div class="row top-navigation border-bottom white-bg">
    <nav class="navbar navbar-static-top" role="navigation">
        <div class="navbar-header">
            <a href="javascript:void(0)" aria-controls="navbar" aria-expanded="false" data-target="#navbar"
               data-toggle="collapse" class="navbar-toggle collapsed" type="button">${views.common['导航栏']}</a>
            <a href="javascript:void(0)" class="navbar-brand p-t-xs">
            <%--<c:if test="${not empty flashLogo}">
                <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="135" height="50" id="logo" align="middle">
                    <param name="movie" value="${soulFn:getImagePath(domain,flashLogo)}" />
                    <param name="wmode" value="transparent" />
                    <param name="menu" value="false" />
                    <object type="application/x-shockwave-flash" data="${soulFn:getImagePath(domain,flashLogo)}" width="135" height="50">
                        <param name="movie" value="${soulFn:getImagePath(domain,flashLogo)}" />
                        <param name="wmode" value="transparent" />
                        <param name="menu" value="false" />
                    </object>
                </object>
            </c:if>--%>
            <c:if test="${not empty logo}">

                <img src="${soulFn:getImagePath(domain,logo)}"/>

            </c:if>
            </a>
            <%--<a href="javascript:void(0)" class="navbar-brand p-t-xs">
                <img src="${soulFn:getImagePath(domain,logo)}"/>
            </a>--%>
        </div>
        <div class="navbar-collapse collapse _nav_title" id="navbar">
            <ul class="nav navbar-nav">

            </ul>
        </div>
    </nav>
</div>
<div id="page-content" style="min-height: 800px;">
    <div>
        <nav name="leftIndexForm" class="navbar-default navbar-static-side shadow" role="navigation">
            <div class="sidebar-collapse" id="left-menu" style="overflow-y: auto;">
                <ul class="nav" id="side-menu">
                    <c:forEach items="${menuListVo.result}" var="menu">
                        <c:if test="${menu.url!='' &&  menu.url!=null}">
                            <li data-toggle="tooltip" title="${views.sysResource[menu.resourceName]}">
                                <a class="shortcut-class" nav-target="mainFrame" href="javascript:void(0);" data="/${menu.url}">
                                    <i class="iconfont ${menu.icon}"></i>
                                    <span class="nav-label">${views.sysResource[menu.resourceName]}</span>
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <li>
                        <soul:button target="${root}/home/addMenu.html" text="" opType="dialog"
                                     cssClass="bg-gray border_1_tb" title="${views.home['ShortcutMenu.addTitle']}"
                                     callback="refreshMenu">
                            <em class="fa fa-plus-square"></em> <span
                                class="nav-label">${views.home['ShortcutMenu.addMenu']}</span>
                        </soul:button>
                    </li>
                </ul>
            </div>
        </nav>
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div id="mainFrame">

            </div>
            <div class="footer">
                <div class="pull-right">
                    <div class="btn-group dropup" id="divLanguage">
                        <button type="button" class="btn btn-outline btn-filter dropdown-toggle language-btn m-sm"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                        <ul class="dropdown-menu dropdown-menu-right m-sm m-b-none"></ul>
                    </div>
                </div>
                <div class="a-copy clearfix">
                    <%--<span class="footer-clock pull-left">
                        <span class="clock-show"><i class="icon iconfont"></i>${views.common['当前时区']}：</span>
                        <span id="userTime"><%= SessionManager.getTimeZone().getID() %></span>
                        <span id="index-clock" class="clock-show"></span>
                    </span>--%>
                    <div class="pull-right m-r-md">
                        <span class="htm-5-logo m-r" type="button" data-toggle="tooltip" data-placement="top"
                          title="${views.common['我们项目使用html5规范开发']}"></span>
                        <%--<span class="footer-boder pull-left"></span>--%>
                        <%--<span class="m-l-sm pull-left m-r">Copyright © 2015  <a href="http://hongtubet.com/" target="_blank">宏圖HongTu</a> 版权所有</span>--%>
                        <a href="javascript:void(0)" id="feedback">${views.common['意见反馈']}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--推送消息弹出矿开始-->
<div class="real-time-inform">
    <div class="clearfix"><span class="unfold">
        <i class="fa fa-angle-double-up m-r-xs pull-left"></i>
        <a href="javascript:void(0)" class="unfold-z"></a>
        <a href="javascript:void(0)" class="unfold-s"></a></span>
    </div>
    <div class="max-ccc hide">
    </div>
    <div id="newMessageDIV" style="display:none"></div>
</div>
<!--推送消息弹出矿结束-->
</body>
<div class="preloader"></div>
</html>

