<%--
  Created by IntelliJ IDEA.
  User: jeff
  Date: 15-12-20
  Time: 下午8:12
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
            <input type="hidden" name="type"  value="${command.type}">
            <input type="hidden" name="hasReason" value="${not empty command.noticeLocaleTmpls?'yes':''}">
            <div class="modal-body">
                <div class="form-group clearfix m-b-sm col-xs-12">
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
<%--                <div class="form-group clearfix m-b-sm col-xs-12">
                    <label class="col-xs-3 al-right">${views.share_auto['账号冻结']}：</label>
                    <div class="col-xs-8 p-x">
                        <input type="checkbox" name="my-checkbox" data-size="mini" class="_switch">
                    </div>
                </div>--%>
                <div class="form-group clearfix m-b-sm col-xs-12">
                    <label class="col-xs-3 al-right line-hi34">${views.common['optionAccount.FreezeTime']}：</label>
                    <div class="col-xs-8 p-x">
                        <div>
                            <%--是冻结状态 冻结时间就是 上次选择的--%>
                            <gb:select prompt="" name="chooseFreezeTime" value="${empty command.chooseFreezeTime ? command.freezeTimeForerve:command.chooseFreezeTime}"  list="${command.freezeTime}"></gb:select>
                            <!--<span class="input-group-addon bdn"><span class="m-l-sm">截止时间：2015-09-23 09:21:55</span></span>-->
                        </div>
                        <%--<span class="help-block m-b-none"><i class="fa fa-times-circle co-red3"></i> ${views.share_auto['请选择冻结时间']}</span>--%>
                    </div>
                </div>
                <c:if test="${not empty command.noticeLocaleTmpls}">
                    <div class="form-group clearfix m-b-sm col-xs-12">
                        <label class="col-xs-3 al-right line-hi34">${views.common['optionAccount.FreezeeRason']}</label>
                        <div class="col-xs-8 p-x">
                            <div class="input-group date">
                                <select callback="setFreezeContent" data-placeholder="${views.common['optionAccount.choosenFreezeReason']}" name="search.freezeTitle" class="btn-group chosen-select-no-single reason-select" tabindex="9">
                                    <option value="">${messages["playerTag"]["chooseFreezeReasons"]}</option>
                                    <c:forEach items="${command.noticeLocaleTmpls}" var="i">
                                        <option value="${i.title}" holder="${i.content}" groupCode="${i.groupCode}">
                                                ${fn:substring(i.title, 0, 20)}<c:if test="${fn:length(i.title)>20}">...</c:if>
                                        </option>
                                    </c:forEach>
                                </select>
                                <input type="hidden" name="groupCode">
                                <span class="input-group-addon bdn _edit">
                                    <soul:button target="reasonPreviewMore.editTmpl" text="" opType="function" cssClass="m-l-sm">
                                        ${views.common['editTmpl']}
                                    </soul:button>
                                </span>
                            </div>
                            <%--<span class="help-block m-b-none"><i class="fa fa-times-circle co-red3"></i> ${views.share_auto['请选择冻结原因']}</span>--%>
                            <div class="clearfix">
                                <soul:button cssClass="dropdown-toggle account-pull-down pull-right btn-advanced-down _edit" toggle="false" target="previewMore" text="" opType="function" tag="a">
                                    <i class="fa fa-angle-double-down m-r-sm"></i>${views.common['previewMore']}
                                </soul:button>
                            </div>

                        </div>
                        <div class="panel blank-panel p-b-sm" id="previewMore" style="display:none">
                        </div>
                    </div>


                    <div class="form-group clearfix m-b-sm col-xs-12 previewMore_some">
                        <label class="col-xs-3 al-right line-hi34">
                                ${views.common['optionAccount.content']}
                        </label>
                        <div class="col-xs-8 p-x">
                            <input type="hidden" name="search.freezeContent"/>
                            <div class="gray-chunk clearfix _freeze_content"></div>
                        </div>
                    </div>
                </c:if>
                <div class="form-group clearfix m-b-sm col-xs-12">
                    <label class="col-xs-3 al-right">${views.common['optionAccount.remark']}</label>
                    <div class="col-xs-8 p-x">
                        <textarea class="form-control _edit" name="remark" data-preview=".preview_remark"></textarea>
                        <div class="gray-chunk clearfix _preview hide preview_remark"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <soul:button target="previewOrEdit" tag="button" text="" precall="validateForm" cssClass="_edit btn btn-filter" opType="function">
                    ${views.common['optionAccount.submitAndPreview']}
                </soul:button>
                <soul:button target="closePage" text="" cssClass="btn btn-outline btn-filter _edit" opType="function" tag="button">
                    ${views.common['cancel']}
                </soul:button>
                <soul:button edit="edit" target="previewOrEdit" tag="button" cssClass="btn btn-outline btn-filter _preview hide" text="" opType="function">
                    ${views.common['optionAccount.backEdit']}
                </soul:button>
                <soul:button target="${root}/share/account/setFreezeAccount.html" returnValue="true" post="getCurrentFormData" tag="button" cssClass="btn btn-filter _preview hide" callback="saveCallbak" text="" opType="ajax">
                    ${views.common['commit']}
                </soul:button>

            </div>
        </form:form>
    </body>
    <%@ include file="/include/include.js.jsp" %>
    <script>
        curl(['site/share/account/FreezeAccount',"site/share/ReasonPreviewMore"], function(Page,ReasonPreviewMore) {
            page = new Page();
            page.bindButtonEvents();
            page.reasonPreviewMore  = new ReasonPreviewMore();
        });
    </script>
</html>
