<%--@elvariable id="command" type="java.util.Map<java.lang.String, java.util.Map<java.land.String,org.soul.model.msg.notice.vo.NoticeLocaleTmpl>>"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="">
    <div class="panel-options">
        <ul class="nav nav-tabs p-l-sm p-r-sm">
            <c:forEach items="${command}" var="i" varStatus="vs">
                <li class="${vs.index==0?'active':''}">
                    <a data-toggle="tab" href="#${i.key}" aria-expanded="true">${dicts.notice.publish_method[i.key]}</a>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<div class="panel-body p-x">
    <div class="tab-content">
        <c:forEach items="${command}" var="i" varStatus="vs">
            <div id="${i.key}" class="tab-pane clearfix bg-gray m-t-sm ${vs.index==0?'active':''}">
                <ul class="artificial-tab clearfix bg-gray">
                    <c:forEach items="${i.value}" var="j" varStatus="status">
                        <li>
                            <soul:button target="reasonPreviewMore.changeLocale" text="" opType="function" data="${i.key}_${j.key}" cssClass="${status.index==0?'current':''}">
                                <span class="con">${fn:substringBefore(dicts.common.language[j.key], '#')}</span>
                            </soul:button>
                        </li>
                    </c:forEach>
                </ul>
                <c:forEach items="${i.value}" varStatus="status" var="j">
                    <div id="${i.key}_${j.key}" style="${status.index!=0?'display:none':''}">
                        <dd><h3 class="al-center">${j.value.title}</h3></dd>
                        <div class="add-players">
                            ${j.value.content}
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>
</div>