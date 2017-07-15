<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/include/include.inc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <title>${views.share_auto['玩家管理-玩家列表']}</title>
</head>
<body>
<div id="wrapper">

    <!--标签选择弹窗-->
    <div class="modal inmodal" id="tag" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight family">
                <div class="modal-header">
                    <span class="filter"><i class="fa fa-tags"></i>&nbsp;&nbsp;${views.share_auto['标签选择']}</span>
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">${views.share_auto['关闭']}</span> </button>
                </div>
                <div class="modal-body">
                    <div class="m-b-xs">${views.share_auto['正在操作']}<span class="co-tomato">2${views.share_auto['条']}</span>${views.share_auto['数据']}</div>
                    <div class="m-b-sm">${views.share_auto['小提示']}</div>
                    <table class="table table-bordered">
                        <thead>
                        <th>${views.share_auto['选择']}</th>
                        <th>${views.share_auto['类型']}</th>
                        </thead>
                        <tbody>
                        <tr>
                            <td><label><div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="i-checks" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></label></td>
                            <td>${views.share_auto['优质客户']}</td>
                        </tr>
                        <tr>
                            <td><label><div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="i-checks" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></label></td>
                            <td>${views.share_auto['主动客户']}</td>
                        </tr>
                        <tr>
                            <td><label><div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="i-checks" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></label></td>
                            <td>${views.share_auto['熟悉客户']}</td>
                        </tr>
                        <tr>
                            <td><label><div class="icheckbox_square-blue" style="position: relative;"><input type="checkbox" class="i-checks" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins></div></label></td>
                            <td>${views.share_auto['其他客户']}</td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="m-b-n-xs clearfix">
                        <a href="javascript:void(0)" class="pull-right">${views.share_auto['标签管理']}</a>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-filter">${views.share_auto['确定']}</button>
                    <button type="button" class="btn btn-outline btn-filter">${views.share_auto['取消']}</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<%@ include file="/include/include.js.jsp" %>
</html>
