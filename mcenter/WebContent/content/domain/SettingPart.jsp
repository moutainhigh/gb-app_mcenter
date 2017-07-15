<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-8-16
  Time: 下午2:24
--%>
<%--@elvariable id="cttDomainListVo" type="so.wwb.gamebox.model.master.content.vo.CttDomainListVo"--%>
<%--@elvariable id="sysDomainListVo" type="so.wwb.gamebox.model.company.sys.vo.SysDomainListVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<c:forEach items="${sysDomainListVo.result}" var="r_domain" varStatus="status">
    <dd class="clearfix domain_dd" data-id="${r_domain.id}">


            <c:forEach items="${sysDomainListVo.domainRanks}" var="domainRank">
                <c:if test="${r_domain.id eq domainRank.domainId}">
                <label class="pull-left domain_handel"><b class="m-r-sm">${status.index+1}</b>
                    ${r_domain.domain}
                </label>
                    <span class="pull-right btn-switch">
                        <input type="checkbox" class="domain_rank" ${domainRank.isShow ? 'checked':''}  data-id="${domainRank.id}" name="my-checkbox"  data-size="mini" >
                    </span>
                </c:if>
            </c:forEach>

    </dd>
</c:forEach>
