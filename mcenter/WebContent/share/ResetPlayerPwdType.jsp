<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
    <title></title>
    <%@ include file="/include/include.head.jsp" %>
    <!-- Gritter -->
    <link href="${resComRoot}/themes/${curTheme}/style.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/content.css" rel="stylesheet">
</head>
<body>
<!--重置密码方式弹窗-->
<div>
    <div class="modal-body">
        <button type="button" class="btn-qfdx"><i class="fa fa-envelope-o"></i>${views.share_auto['发送邮箱重置密码链接']}</button>
        <button type="button" class="btn-qfdx"><i class="fa fa-comment-o"></i>${views.share_auto['发送短信重置密码']}</button>
        <button type="button" class="btn-qfdx" data-rel="{opType:'function',target:'replace',text:'${views.share_auto['手动重置密码']}' }" data-href="${root}/share/resetPlayerPwd.html"><i class="fa fa-retweet"></i>${views.share_auto['手动重置密码']}</button>
    </div>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player"/>
</html>