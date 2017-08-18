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
<!--群发信息-->
<div class="inmodal">
    <div class="modal-body">
        <div class="form-group"><!--收件人<input type="text" placeholder="" class="form-control m-b">-->
            <ul class="clearfix input">
                <li>${views.share_auto['张三']}<a href="javascript:void(0)">×</a></li>
                <li>${views.share_auto['李四']}<a href="javascript:void(0)">×</a></li>
            </ul>
        </div>
        <div class="clearfix save lgg-version">
            <a href="javascript:void(0)" class="current">${views.share_auto['简体中文']}<span>${views.share_auto['未编辑']}</span></a>
            <a href="javascript:void(0)">English<span>${views.share_auto['已编辑']}</span></a>
            <a href="javascript:void(0)">${views.share_auto['繁体中文']}<span>${views.share_auto['已编辑']}</span></a>
        </div>
        <div class="form-group">
            <div class="clearfix">
                <label>${views.share_auto['标题']}</label>
                <select class="lgg-sys">
                    <option>${views.share_auto['复制语系']}</option>
                    <option>${views.share_auto['复制语系']}</option>
                </select>
            </div>
            <input type="text" placeholder="" class="form-control m-b">
        </div>
        <div class="form-group"><label>${views.share_auto['信息内容']}</label><textarea class="form-control m-b"></textarea></div>
        <div class="clearfix form-group">
            <div class="dsfb"><label><input type="checkbox" class="i-checks"></label>${views.share_auto['定时发表']}</div>
            <div class="dsfb-data">
                <div class="input-group date"> <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" class="form-control" value="2015-05-01 16:51:01${views.share_auto['至']}2015-05-04 10:20:20">
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-filter">${views.share_auto['确定']}</button>
        <button type="button" class="btn btn-outline btn-filter">${views.common_report['取消']}</button>
    </div>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
</html>
