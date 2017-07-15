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
<!--手动重置密码弹窗-->
<form>
    <div class="modal-body">
        <div class="m-b-sm">${views.share_auto['玩家账号']}：<span class="co-blue">alongg8777</span></div>
        <div class="condition-options-wraper">
            <div class="form-group">
                <label>${views.share_auto['新密码']}</label>
                <input type="password" placeholder="" class="form-control">
            </div>
            <div class="form-group">
                <label>${views.share_auto['重置新密码']}</label>
                <input type="password" placeholder="" class="form-control">
            </div>
            <div class="form-group">
                <input type="checkbox" />${views.share_auto['发送邮件通知玩家，玩家邮箱地址为']}：demovip@demovip.com
            </div>
            <div class="form-group">
                <input type="checkbox" checked />${views.share_auto['发送短信通知玩家，玩家手机为']}：1379948476662
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-filter">${views.share_auto['确定']}</button>
        <button type="button" class="btn btn-outline btn-filter">${views.share_auto['取消']}</button>
    </div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
</html>