<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-15
  Time: 下午4:35
--%>
<%--@elvariable id="cttDomainListVo" type="so.wwb.gamebox.model.master.content.vo.CttDomainListVo"--%>
<%--@elvariable id="sysDomainListVo" type="so.wwb.gamebox.model.company.sys.vo.SysDomainListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
</head>
<body>
<form>
    <div class="modal-body">
        <div class="line-hi34 m-t-sm m-b-sm">
            <span class="m-r-sm">${views.content['domain.setting.openPage']}</span>
            <input type="checkbox" data-id="${sysDomainListVo.sysParam.id}" data-sysParamId="${sysDomainListVo.sysParam.id}" ${sysDomainListVo.sysParam.paramValue eq 'true'? 'checked':''} name="my-checkbox" data-size="mini" class="showPage">

            <span tabindex="0" class="m-l-sm help-popover" role="button" data-container="body" data-toggle="popover"  data-trigger="focus" data-placement="right" data-content="${views.content['domain.setting.help']}">
                <i class="fa fa-question-circle"></i>
            </span>

            <%--<span class="m-l-sm"><i class="fa fa-question-circle"></i></span>--%>
        </div>
        <div class="line-hi34 col-sm-12 bg-gray m-b">
            <span class="co-yellow m-r-sm"><i class="fa fa-exclamation-circle"></i></span>
            ${views.content['可拖动域名进行排序']}
            <%--启用后，所有该玩家可访问的域名将在这个页面展示；关闭后，该页面将不展示（同时隐藏入口）；--%>
        </div>
        <div class="dd td0 clearfix">
            <dl class="domain_list_warp col-sm-7 domain_rank_dl">
                <c:forEach items="${sysDomainListVo.someDomain}" var="domain" varStatus="status">
                    <dd class="clearfix domain_dd" data-id="${domain.id}">
                        <label class="pull-left domain_handel"><b class="m-r-sm">${status.index+1}</b>${domain.domain}</label>
                        <span class="pull-right btn-switch">
                            <input type="checkbox" name="my-checkbox" value="" class="domain_default" data-id="${domain.id}" data-size="mini"  ${domain.isEnable ? 'checked':''}>
                        </span>
                    </dd>
                </c:forEach>
                <c:if test="${empty sysDomainListVo.someDomain&&empty sysDomainListVo.domainRanks}">
                    <div class="al-center p-sm">
                        <i class="fa fa-exclamation-circle"></i> ${views.content['domain.setting.none']}
                    </div>
                </c:if>

            </dl>
        </div>
    </div>
        <div class="modal-footer">
            <soul:button target="saveDomain"  text="" opType="function" cssClass="btn btn-filter" tag="button">${views.common['save']}</soul:button>
        </div>
</form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/content/domain/Setting" />
</html>
