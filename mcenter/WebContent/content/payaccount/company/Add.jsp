<%--@elvariable id="command" type="so.wwb.gamebox.model.master.content.vo.PayAccountVo"--%>
<%--@elvariable id="bitCoinChannelVo" type="so.wwb.gamebox.model.bitcoin.po.BitCoinChannel"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<!--//region your codes 1-->

<!--//endregion your codes 1-->
<body>
<form:form id="editForm" action="${root}/payAccount/edit.html" method="post">
    <form:hidden path="result.id" id="resultId"/>
    <div id="validateRule" style="display: none">${command.validateRule}</div>
    <form:hidden path="currencyStr" id="currencyStr"/>
    <form:hidden path="rankStr" id="rankStr"/>
    <form:hidden path="result.account" id="account"/>
    <form:hidden path="result.bankCode" id="bankCode"/>
    <input type="hidden" value="1" name="result.type"/>
    <input name="channelJson" hidden="hidden" value="1">
    <gb:token/>
    <input id="code" name="result.payChannelCode" hidden="hidden">
    <input name="result.fullRank" value="${empty command.result.fullRank?false:command.result.fullRank}" hidden="hidden">

    <div class="row">
        <div class="position-wrap clearfix">
            <h2><a href="javascript:void(0)" class="navbar-minimalize"><i class="icon iconfont"></i> </a></h2>
            <span>${views.sysResource['运营']}</span>
            <span>/</span><span>${views.sysResource['公司入款账户']}</span>
            <soul:button target="goToLastPage" refresh="true" cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text="" opType="function">
                <em class="fa fa-caret-left"></em>${views.common['return']}
            </soul:button>
        </div>
        <div class="col-lg-12">
            <div class="wrapper white-bg shadow clearfix">
                <div class="present_wrap"><b>${empty command.result.id?views.common['create']:views.common['edit']}${views.content['payAccount.add.title']}</b></div>
                <form class="m-t" action="">
                    <div class="form-group line-hi34 clearfix">
                        <label class="ft-bold col-sm-3 al-right">${views.column['PayAccount.code']}：</label>

                        <div class="col-sm-5 payCode" data-value="${command.result.code}">${command.result.code}</div>
                    </div>
                    <div class="form-group clearfix line-hi34">
                        <label for="result.payName" class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.column['PayAccount.payName']}：</label>

                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:input disabled="${disabled}" id="payName" path="result.payName"
                                            cssClass="form-control"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix line-hi34">
                        <label for="result.accountType" class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.column['PayAccount.accountType']}：</label>

                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:select path="result.accountType" callback="accountTypeChange" id="accountType" cssClass="btn-group chosen-select-no-single">
                                    <c:forEach items="${command.accountType.values()}" var="p">
                                        <form:option value="${p.dictCode}">${dicts.content.pay_account_account_type[p.dictCode]}</form:option>
                                    </c:forEach>
                                </form:select>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix third" style="display: ${command.result.accountType=='2'?'':'none'}">
                        <label class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.column['PayAccount.bankCode']}：</label>
                        <div class="input-group col-sm-5" id="thirdError" style="width: 41.2%">
                            <div class="input-group-btn">
                                <div selectdiv="result.bankCode2" class="btn-group" listkey="bankName" listvalue="bankShortName" value="${command.result.bankCode}" initprompt="${views.content_auto['请选择']}" callback="thirdChange" id="third">
                                    <input type="hidden" name="bankCode2" value="${command.result.bankCode}">
                                    <button type="button" class="btn btn-group btn-default dropdown-toggle" style="overflow: hidden;padding-right: 10px;height: 34px;padding-top: 2px;" data-toggle="dropdown" aria-expanded="false">
                                        <span prompt="prompt"><span class="pay-third ${command.result.accountType=='2'?command.result.bankCode:''} "></span>
                                            <c:if test="${command.result.accountType=='2'}">
                                                ${dicts.common.bankname[command.result.bankCode]}
                                            </c:if>
                                        </span>
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="max-height: 300px; min-width: 93px; min-height: 25px; overflow-y: auto; overflow-x: visible;">
                                        <c:forEach items="${command.thirdBankList}" var="p" varStatus="status">
                                            <li role="presentation">
                                                <a role="menuitem" tabindex="-1" href="javascript:void(0)" key="${p.bankName}" style="white-space: normal;">
                                                    <span class="pay-third ${p.bankName} " showName="${dicts.common.bankname[p.bankName]}"></span>
                                                        ${dicts.common.bankname[p.bankName]}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <input name="result.customBankName" class="form-control" value="${command.result.customBankName}">
                        </div>
                    </div>
                    <div class="form-group clearfix line-hi34">
                        <label class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span><span id="accountSpan">${views.column['PayAccount.account']}：</span></label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <input class="form-control account ${command.result.accountType=='2'?'hide':''}" name="account1" value="${command.result.accountType=='1'?command.result.account:''}" />
                                <input class="form-control account ${command.result.accountType=='1'?'hide':''}" name="account2" value="${command.result.accountType=='2'?command.result.account:''}"  />
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <c:set var="showKey" value="${command.result.bankCode eq 'bitcion'}"/>
                    <div class="form-group clearfix line-hi34 showKey" style="${showKey?'':'display:nont'}">
                        <label class="ft-bold col-sm-3 al-right line-hi34" for="bitCoinChannelVo.channel"><span class="co-red m-r-sm">*</span><span>${views.content_auto['比特币平台']}</span></label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <select name="bitCoinChannelVo.channel" id="bitCoinChannelVo.channel" class="btn-group chosen-select-no-single">
                                    <c:forEach items="${bitChannel}" var="i">
                                        <option value="${i.code}" ${command.bitCoinChannelVo.channel eq i.code?'selected':''}>${dicts.content.bitChannel[i.code]}</option>
                                    </c:forEach>
                                </select>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix line-hi34 showKey" style="${showKey?'':'display:nont'}">
                        <label class="ft-bold col-sm-3 al-right line-hi34" for="bitCoinChannelVo.apiKey"><span class="co-red m-r-sm">*</span><span>API Key：</span></label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <input class="form-control" id="bitCoinChannelVo.apiKey" name="bitCoinChannelVo.apiKey" value="${command.bitCoinChannelVo.decApiKey}" />
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix line-hi34 showKey" style="${showKey?'':'display:nont'}">
                        <label class="ft-bold col-sm-3 al-right line-hi34" for="bitCoinChannelVo.apiSecret"><span class="co-red m-r-sm">*</span><span>Secret：</span></label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <input class="form-control" id="bitCoinChannelVo.apiSecret" name="bitCoinChannelVo.apiSecret" value="${command.bitCoinChannelVo.decApiSecret}" />
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <!-- 二维码图片 -->
                    <c:set var="showPic" value="${command.result.id == null || (command.result.type!='1' && command.result.accountType!='2')}" />
                    <c:if test="${command.result.id!=null}">
                        <c:if test="${command.result.accountType=='1'}"><c:set var="showPic" value="true"></c:set></c:if>
                        <c:if test="${command.result.accountType=='2'}"><c:set var="showPic" value="false"></c:set></c:if>

                    </c:if>
                    <div class="form-group clearfix line-hi34 qr-code" <c:if test="${showPic}">style="display: none"</c:if>>
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.content['payaccount.company.edit.qrcode']}</label>
                        <div class="col-sm-5" style="width: 41.2%">
                            <div>
                                <c:if test="${not empty command.result.qrCodeUrl}">
                                    <div class="file-preview">
                                        <soul:button target="deleteQrCode" text="×" opType="function" cssClass="close fileinput-remove"/>
                                            <%-- <div class="close fileinput-remove">×</div>--%>
                                        <div class="file-preview-thumbnails">
                                            <img id="picUrl" src="${soulFn:getImagePathWithDefault(domain, command.result.qrCodeUrl,null)}" style="max-width: 650px;max-height: 150px"/>
                                        </div>
                                        <div class="clearfix"></div><div class="file-preview-status text-center text-success"></div>
                                    </div>
                                </c:if>
                            </div>
                            <input id="image_file_path" class="file" type="file" accept="image/*" name="image_file_path" target="result.qrCodeUrl">
                            <div style="line-height: 20px; color: #A7A6A6;">${views.content['carousel.uploadPictureTips']}</div>
                            <input type="hidden" name="result.qrCodeUrl" id="path" value="${command.result.qrCodeUrl}">
                        </div>
                    </div>
                    <div class="form-group clearfix line-hi34">
                        <label class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.column['PayAccount.fullName']}：</label>

                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:input disabled="${disabled}" id="fullName" path="result.fullName" cssClass="form-control"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span></div>
                        </div>
                    </div>
                        <%--是否是银行账户--%>
                    <c:set var="isBank" value="${empty command.result.accountType||command.result.accountType=='1'}"/>
                    <div class="form-group clearfix line-hi34 bank-div" style="display: ${isBank?'':'none'}">
                        <label class="ft-bold col-sm-3 al-right"><span class="co-red m-r-sm">*</span>${views.column['VUserBankcard.bankName']}：</label>
                        <div class="input-group col-sm-5" style="width: 41.2%">
                            <span style="display: none" id="defaultBank">${command.bankList[0].bankName}</span>
                            <c:set var="bankCode" value="${empty command.result.bankCode?command.bankList[0].bankName:command.result.bankCode}"/>
                            <div class="${bankCode=='other_bank'?'input-group-btn':''}">
                                <div selectdiv="result.bankCode1" class="btn-group" listkey="bankName" listvalue="bankShortName" value="${bankCode}" initprompt="${views.content_auto['请选择']}" callback="thirdChange" id="bankError">
                                    <input type="hidden" name="bankCode1" id="selectdivBank" value="${bankCode}">
                                    <button id="button" type="button" class="btn btn-group btn-default dropdown-toggle" style="overflow: hidden;padding-right: 10px;height: 34px;padding-top: 2px;" data-toggle="dropdown" aria-expanded="false">
                                        <span prompt="prompt">
                                            <span class="pay-bank ${bankCode}"></span>
                                            ${dicts.common.bankname[bankCode]}
                                        </span>
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="max-height: 300px; min-width: 100px; min-height: 25px; overflow-y: auto; overflow-x: visible;">
                                        <c:forEach items="${command.bankList}" var="p" varStatus="status">
                                            <li role="presentation">
                                                <a role="menuitem" tabindex="-1" href="javascript:void(0)" key="${p.bankName}" style="white-space: normal;">
                                                    <span class="pay-bank ${p.bankName} " showName="${dicts.common.bankname[p.bankName]}"></span>
                                                        ${dicts.common.bankname[p.bankName]}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <input name="customBankName" style="${bankCode=='other_bank'?'':'display: none'}" class="form-control" value="${command.result.accountType=='1'&&bankCode=='other_bank'?command.result.customBankName:''}">
                        </div>
                    </div>
                    <div class="form-group clearfix line-hi34 ${empty command.result.accountType || command.result.accountType=='1'?'':'hide'}" id="khx-div">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.content['开户行：']}</label>

                        <div class="col-sm-5">
                            <div class="input-group date">
                                <form:input id="openAcountName" path="result.openAcountName" cssClass="form-control"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span></div>
                        </div>
                    </div>
                      <div class="form-group clearfix line-hi34">
                          <label class="ft-bold col-sm-3 al-right line-hi34">${views.content_auto['自定义别名']}</label>

                          <div class="col-sm-5">
                              <div class="input-group date">
                                  <input name="result.aliasName" id="result.aliasName" class="form-control" placeholder="${views.content_auto['自定义别名提示内容']}" value="${command.result.aliasName}"/>
                                  <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                              </div>
                          </div>
                      </div>
                        <%--自定义账号信息--%>
                    <div class="form-group clearfix line-hi34" id="accountInformation" style="display: none">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.content_auto['自定义账号信息']}</label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <input name="result.accountInformation" id="result.accountInformation" class="form-control" placeholder="${views.content_auto['自定义账号信息提示内容']}" value="${command.result.accountInformation}"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                        <%--自定义账号提示--%>
                    <div class="form-group clearfix line-hi34" id="accountPrompt" style="display: none">
                        <label class="ft-bold col-sm-3 al-right line-hi34">${views.content_auto['自定义账号提示']}</label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <input name="result.accountPrompt" id="result.accountPrompt" class="form-control" placeholder="${views.content_auto['自定义账号提示提示内容']}" value="${command.result.accountPrompt}"/>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>

                      <div class="form-group clearfix line-hi34 ${empty command.result.accountType || command.result.accountType=='1'?'':'hide'}" id="supportAtmCounter-div">
                          <label class="ft-bold col-sm-3 al-right line-hi34">${views.content_auto['柜员机/柜台存款开关']}</label>

                          <div class="col-sm-5">
                              <div class="input-group date">
                                  <input type="checkbox" name="result.supportAtmCounter" value="true" data-size="mini" ${command.result.supportAtmCounter||empty command.result.supportAtmCounter?'checked':''}>
                                  <span class="input-group-addon bdn">&nbsp;&nbsp;</span></div>
                          </div>
                      </div>
                        <%--<div class="form-group clearfix">--%>
                        <%--<label for="result.disableAmount" class="ft-bold col-sm-3 al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.column['PayAccount.disableAmount']}${sessionSysUser.defaultCurrency}：</label>--%>

                        <%--<div class="col-sm-5" style="width: 41.2%">--%>
                        <%--<div class="input-group date">--%>
                        <%--<form:input id="disableAmount" path="result.disableAmount"--%>
                        <%--cssClass="form-control"/>--%>
                        <%--<span tabindex="0" class=" help-popover input-group-addon" role="button"--%>
                        <%--data-container="body" data-toggle="popover" data-trigger="focus"--%>
                        <%--data-placement="top" data-original-title="" title="" data-html="true"--%>
                        <%--data-content="${views.content['payAccount.disableAmount']}"><i--%>
                        <%--class="fa fa-question-circle"></i></span>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34" for="result.remark">
                            <span tabindex="0" class="help-popover m-r" role="button" data-container="body" data-toggle="popover" data-trigger="focus" data-placement="top" data-html="true" data-content="${views.content['填写后，站点前端入款账户展示区域，将显示此备注内容；']}" title=""><i class="fa fa-question-circle"></i></span>
                                ${views.content['前端备注']}
                        </label>
                        <div class="col-sm-5">
                            <textarea class="form-control" placeholder="${views.content_auto['非必填']}" maxlength="500" id="result.remark" name="result.remark">${command.result.remark}</textarea>
                        </div>
                    </div>
                        <%--<div class="form-group clearfix line-hi34" style="display:${command.result.id>0?"":"none"}">
                            <label class="ft-bold col-sm-3 al-right">${views.column['PayAccount.depositCount']}</label>
                            <div class="col-sm-5">
                                <div class="input-group date">
                                    <form:input path="result.depositCount"
                                                cssClass="form-control"/>
                                    <span class="input-group-addon bdn">&nbsp;&nbsp;<span class="co-red">*</span></span>
                                    <span class="input-group-addon bdn">
                                        <soul:button cssClass="m-l-sm" target="revertDepositCount" text="${views.column['PayAccount.revert']}" opType="function"></soul:button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix line-hi34" style="display:${command.result.id>0?"":"none"}">
                            <label class="ft-bold col-sm-3 al-right">${views.column['PayAccount.depositTotal']}</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <form:input path="result.depositTotal"
                                                cssClass="form-control"/>
                                    <span class="input-group-addon bdn">&nbsp;&nbsp;<span class="co-red">*</span></span>
                                    <span class="input-group-addon bdn">
                                        <soul:button cssClass="m-l-sm" target="revertDepositTotal" text="${views.column['PayAccount.revert']}" opType="function"></soul:button>
                                    </span>
                                </div>
                            </div>
                        </div>--%>

                    <div class="line-hi34 col-sm-12 bg-gray m-b">
                        <label class="ft-bold col-sm-3 al-right line-hi34"></label>
                        <span class="co-yellow m-r-sm m-l-sm"><i class="fa fa-exclamation-circle"></i></span>
                            ${views.content['payAccount.add.monetaryTips']}
                    </div>
                    <div class="form-group clearfix line-hi34">
                            <%--支持货币--%>
                        <label class="ft-bold col-sm-3 al-right"><span class="co-red m-r-sm">*</span>
                                ${views.content['payAccount.add.supportMoney']}：
                        </label>

                        <div class="col-sm-5">
                            <div class="input-group date">
                                <div class="currency" id="currenct">
                                </div><span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                        <div id="old-currency-div" class="hide">
                            <c:forEach var="cu" items="${command.payAccountCurrencyList}">
                                ${cu.currencyCode},
                            </c:forEach>
                        </div>

                    </div>


                    <div class="form-group clearfix">
                        <label class="ft-bold col-sm-3 al-right line-hi34">手续费方案：</label>
                        <div class="col-sm-5">
                            <div class="input-group date">
                                <gb:select name="result.feeSchemaId"  cssClass="btn-group chosen-select-no-single" prompt="${views.common['pleaseSelect']}" list="${schemaListVo.result}" listKey="id" listValue="schemaName" value="${feeAccountRelation.feeSchemaId}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group clearfix line-hi34">
                            <%--使用层级--%>
                        <label class="ft-bold col-sm-3 al-right"><span class="co-red m-r-sm">*</span>${views.content['payAccount.add.useRank']}：</label>
                            <%--<input name="result.fullRank" value="${empty command.result.fullRank?false:command.result.fullRank}" type="hidden">--%>
                        <div class="col-sm-5 rank">
                            <div><label class="m-r-sm"><input type="checkbox" name="result.fullRank" value="${empty command.result.fullRank?false:command.result.fullRank}"
                                                              id="fullRank" ${command.result.fullRank?'checked':''}>${views.content['全部层级']}</label><span class="m-l co-grayc2">${views.content['勾选后后续']}</span></div>
                            <div class="input-group date allRank ${command.result.fullRank?'hide':''}">
                                <c:forEach items="${command.playerRankList}" var="p">
                                    <label class="m-r-sm">
                                        <input name="rank" type="checkbox" class="i-checks"
                                               <c:if test="${command.result.fullRank}">checked</c:if>
                                        <c:if test="${!command.result.fullRank}">
                                            <c:forEach items="${command.payRankList}" var="payRank">${p.id==payRank.playerRankId?"checked":""}</c:forEach>
                                        </c:if>

                                               value="${p.id}"> ${p.rankName}
                                    </label>
                                </c:forEach>
                                <span class="input-group-addon bdn">&nbsp;&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <hr class="m-t-sm m-b">
                    <div class="operate-btn">
                        <soul:button cssClass="btn btn-filter btn-lg disabled _search _enter_submit " text="${views.common['commit']}" opType="ajax"
                                     dataType="json"
                                     target="${root}/payAccount/saveCompany.html" precall="savePlayer"
                                     post="getCurrentFormData"
                                     callback="saveCallbak" />
                        <soul:button target="goToLastPage" refresh="true" cssClass="btn btn-outline btn-filter btn-lg m-r" text="${views.common['cancel']}" opType="function" />

                    </div>
                </form>
            </div>
        </div>
    </div>
</form:form>
</body>
<!--//region your codes 4-->

<soul:import res="site/content/payaccount/Add"/>
<!--//endregion your codes 4-->
</html>