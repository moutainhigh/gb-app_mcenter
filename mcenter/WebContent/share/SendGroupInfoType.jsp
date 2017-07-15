<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html lang="zh-CN">
<head>
    <title>${views.share_auto['群发信息']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!-- Gritter -->
    <link href="${resComRoot}/themes/${curTheme}/style.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/content.css" rel="stylesheet">
</head>
<body>
<!--群发信息方式-->
<div>
    <div class="modal-body">
        <button type="button" class="btn-qfdx" data-rel="{opType:'function',target:'replace',text:'${views.share_auto['群发信息']}' }" data-href="${root}/share/sendGroupInfo.html"><i class="fa fa-comment-o"></i>${views.share_auto['群发邮件']}</button>
        <button type="button" class="btn-qfdx" data-rel="{opType:'function',target:'replace',text:'${views.share_auto['群发信息']}' }" data-href="${root}/share/sendGroupInfo.html"><i class="fa fa-envelope-o"></i>${views.share_auto['群发站内信']}</button>
    </div>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player"/>
</html>