<%--@elvariable id="command" type="org.soul.model.msg.notice.vo.NoticeHistoryDetail"--%>
<%--@elvariable id="siteLang" type="java.util.List<so.wwb.gamebox.model.master.setting.po.SiteLanguage>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<form>
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['内容']}</span>
            <span>/</span><span>${views.sysResource['信息群发']}</span>
            <soul:button target="goToLastPage" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
            <a href="javascript:void(0)" class="pull-right siteMap"><i class="fa fa-sitemap"></i></a>
        </div>
        <div class="wrapper white-bg clearfix shadow">
            <div class="panel-body p-sm">
                <div class="form-group clearfix">
                    <label class="col-sm-2 ft-bold al-right">${views.operation_auto['标题']}：</label>
                    <div class="col-sm-8">${textVo.result.title}</div>
                </div>
                <div class="form-group clearfix">
                    <label class="col-sm-2 ft-bold al-right">${views.operation_auto['内容']}：</label>
                    <div class="col-sm-9">${textVo.result.content}</div>
                </div>
            </div>


        </div>
</form>
<soul:import res="site/operation/mass.information/NoticeInfo"/>