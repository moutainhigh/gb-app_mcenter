<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-12-20
  Time: 下午8:14
--%>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.AccountVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
    <head>
        <%@ include file="/include/include.head.jsp" %>
    </head>
    <body>
    <form:form>
        <gb:token></gb:token>
        <div style="display: none" id="validateRule">${command.validateRule}</div>
        <input type="hidden" name="result.id" value="${command.result.id}">
        <input type="hidden" name="hasReason" value="${not empty command.noticeLocaleTmpls?'yes':''}">
        <div class="modal-body">
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right">${views.common['optionAccount.account']}</label>
                <div class="col-xs-9">${command.result.username}
                    <c:choose>
                        <c:when test="${isOnline}">
                            <span class="m-l-sm co-green">${views.common['optionAccount.online']}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="m-l-sm co-grayc2">${views.common['optionAccount.offOnline']}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${views.common['optionAccount.FreezeTime']}</label>
                <div class="col-xs-9">
                    <div>
                        <gb:select prompt="" name="chooseFreezeTime" value="${command.freezeTimeForerve}"  list="${command.freezeTime}"></gb:select>
                    </div>
                </div>
            </div>
            <c:if test="${not empty command.noticeLocaleTmpls}">
                <div class="form-group clearfix m-b-sm">
                    <label class="col-xs-3 al-right line-hi34">${views.common['optionAccount.FreezeeRason']}</label>
                    <div class="col-xs-9">
                        <div class="input-group date">
                            <select callback="setFreezeContent" data-placeholder="${views.common['optionAccount.choosenFreezeReason']}" name="balanceFreezeTitle" class="btn-group chosen-select-no-single reason-select" tabindex="9">
                                <option va lue="">${messages["playerTag"]["chooseFreezeReasons"]}</option>
                                <c:forEach items="${command.noticeLocaleTmpls}" var="i">
                                    <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">
                                            ${fn:substring(i.title, 0, 20)}<c:if test="${fn:length(i.title)>20}">...</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <input type="hidden" name="groupCode">
                            <span class="input-group-addon bdn">
                                <soul:button target="reasonPreviewMore.editTmpl" text="" cssClass="m-l-sm _edit" opType="function" tag="a">
                                    ${views.common['editTmpl']}
                                </soul:button>
                            </span>
                        </div>
                        <div class="clearfix m-t-sm">
                            <soul:button target="previewMore" toggle="false" text="" cssClass="pull-right _edit" opType="function" tag="a">
                                ${views.common['previewMore']}
                            </soul:button>
                        </div>
                    </div>
                    <div class="panel blank-panel p-b-sm" id="previewMore" style="display:none">
                    </div>
                </div>

                <div class="form-group clearfix m-b-sm previewMore_some">
                    <label class="col-xs-3 al-right line-hi34">${views.common['optionAccount.content']}</label>
                    <div class="col-xs-9">
                        <div class="gray-chunk clearfix _freeze_content"></div>
                    </div>
                    <input type="hidden" value="" name="balanceFreezeContent"/>
                </div>
            </c:if>
            <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${views.common['optionAccount.remark']}</label>
                <div class="col-xs-9">
                    <textarea class="form-control _edit" name="remark" data-preview=".preview_remark"></textarea>
                    <div class="gray-chunk clearfix _preview_remark hide _preview"></div>
                </div>
            </div>

        </div>
        <div class="modal-footer">
            <soul:button tag="button" target="previewOrEdit" precall="validateForm" text="" opType="function" cssClass="btn btn-filter _edit">
                ${views.common['optionAccount.submitAndPreview']}
            </soul:button>
            <soul:button tag="button" target="closePage" text="" opType="function" cssClass="btn btn-outline btn-filter _edit">
                ${views.common['cancel']}
            </soul:button>
            <soul:button tag="button" target="previewOrEdit" edit="edit" text="function" opType="function" cssClass="btn btn-outline btn-filter _preview hide">
                ${views.common['optionAccount.backEdit']}
            </soul:button>
            <soul:button tag="button" target="${root}/share/account/setFreezeBalance.html" callback="saveCallbak" post="getCurrentFormData" text="" opType="ajax" cssClass="btn btn-filter _preview hide">
                ${views.common['commit']}
            </soul:button>
        </div>
    </form:form>
    </body>
    <%@ include file="/include/include.js.jsp" %>
    <script>
        curl(['site/share/account/FreezeBalance',"site/share/ReasonPreviewMore"], function(Page,ReasonPreviewMore) {
            page = new Page();
            page.bindButtonEvents();
            page.reasonPreviewMore  = new ReasonPreviewMore();
        });
    </script>
</html>
