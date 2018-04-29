<%--@elvariable id="command" type="so.wwb.gamebox.model.master.operation.vo.VActivityMessageListListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>

<!--//region your codes 1-->
<%--返水优惠--%>
<div class="tab-content">
    <div id="tab-2" class="tab-pane active">
        <div class="gray-chunk clearfix">
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动名称']}：</label>
                <div class="col-sm-8">${views.operation_auto['开户即送鼓励金，就是这么任性']}<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动分类']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['新人优惠']}<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动时间']}：</label>
                <div class="col-sm-8 ">2018-04-13 ${views.operation_auto['至']} 2100-04-13<span class="co-red">${views.operation_auto['自定义']}</span></div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['领奖方式']}：</label>
                <div class="col-sm-8 ">${views.operation_auto['完成注册后，请至活动大厅申请该活动奖励']}${views.operation_auto['自定义']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动详情']}：</label>
                <div class="col-sm-8 co-red">${views.operation_auto['自定义文宣、包装很重要、很重要、很重要']}</div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8 ">
                    <p>${views.operation_auto['永久注册权']} : </p>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['活动规则']}：</label>
                <div class="col-sm-8 co-red">
                    <span class="co-red">${views.operation_auto['自定义']}</span>
                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right"></label>
                <div class="col-sm-8">
                    <p>1. ${views.operation_auto['每位会员终身仅能享受一次注册优惠活动，完整注册后请在X天内申请奖励，过期则无法获得奖励']}
                    </p>
                    <p>2. ${views.operation_auto['若符合活动条件']}&nbsp;
                        <span class="co-red">${views.operation_auto['例_多个相同银行卡的账号']}</span>
                    </p>
                    <p>3. ${views.operation_auto['参与该优惠活动_即表示您同意']}</p>

                </div>
            </div>
            <div class="clearfix line-hi34">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['优惠条款']}：</label>
                <div class="col-sm-8">
                    <p>1. ${views.operation_auto['所有优惠以人民币为结算金额']}</p>
                    <p>2. ${views.operation_auto['视为同一位会员']} <%= SessionManager.getSiteName(request) %>
                        ${views.operation_auto['保留收回或取消申请优惠金的权利']}
                    </p>
                    <p>3. <%= SessionManager.getSiteName(request) %>${views.operation_auto['所有优惠特为玩家而设']}</p>
                    <p>4. ${views.operation_auto['若会员对活动有争议时为确保双方利益']}<%= SessionManager.getSiteName(request) %>
                        ${views.operation_auto['有权要求会员向我们提供充足有效的文件']}
                    </p>
                    <p>5. ${views.operation_auto['本活动最终解释权归属']}<%= SessionManager.getSiteName(request) %>
                        ${views.operation_auto['并保留修改以上条款的最终权利']}
                    </p>
                </div>
            </div>
            <br>
            <br>

            <div class="clearfix line-hi34 co-red">
                <label class="ft-bold col-sm-3 al-right">${views.operation_auto['致各位尊敬的站长']}：</label>
                <div class="col-sm-8">
                    <p>${views.operation_auto['玩家层级不满足活动要求']}</p>

                </div>
            </div>




        </div>
    </div>
</div>
<!--//endregion your codes 1-->

