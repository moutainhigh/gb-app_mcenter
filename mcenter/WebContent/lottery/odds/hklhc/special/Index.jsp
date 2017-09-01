<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div  class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                        <th>${views.lottery_auto['号码']}</th>
                        <th>${views.lottery_auto['当前赔率']}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%@include file="../include/Digist.jsp"%>

                    <tr>
                        <th>${views.lottery_auto['大']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['大'].id}" name="lotteryOdds[49].id">
                                <input type="hidden" value="${command['大'].code}" name="lotteryOdds[49].code">
                                <input type="hidden" value="${command['大'].betCode}" name="lotteryOdds[49].betCode">
                                <input type="hidden" value="${command['大'].siteId}" name="lotteryOdds[49].siteId">
                                <input type="hidden" value="${command['大'].betNum}" name="lotteryOdds[49].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['大'].oddLimit}" data-limit="${command['大'].oddLimit}" data-value="${command['大'].odd}" name="lotteryOdds[49].odd" value="${command['大'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['小']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['小'].id}" name="lotteryOdds[50].id">
                                <input type="hidden" value="${command['小'].code}" name="lotteryOdds[50].code">
                                <input type="hidden" value="${command['小'].betCode}" name="lotteryOdds[50].betCode">
                                <input type="hidden" value="${command['小'].siteId}" name="lotteryOdds[50].siteId">
                                <input type="hidden" value="${command['小'].betNum}" name="lotteryOdds[50].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['小'].oddLimit}" data-limit="${command['小'].oddLimit}" data-value="${command['小'].odd}" name="lotteryOdds[50].odd" value="${command['小'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['单']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['单'].id}" name="lotteryOdds[51].id">
                                <input type="hidden" value="${command['单'].code}" name="lotteryOdds[51].code">
                                <input type="hidden" value="${command['单'].betCode}" name="lotteryOdds[51].betCode">
                                <input type="hidden" value="${command['单'].siteId}" name="lotteryOdds[51].siteId">
                                <input type="hidden" value="${command['单'].betNum}" name="lotteryOdds[51].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['单'].oddLimit}" data-limit="${command['单'].oddLimit}" data-value="${command['单'].odd}" name="lotteryOdds[51].odd" value="${command['单'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['双']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['双'].id}" name="lotteryOdds[52].id">
                                <input type="hidden" value="${command['双'].code}" name="lotteryOdds[52].code">
                                <input type="hidden" value="${command['双'].betCode}" name="lotteryOdds[52].betCode">
                                <input type="hidden" value="${command['双'].siteId}" name="lotteryOdds[52].siteId">
                                <input type="hidden" value="${command['双'].betNum}" name="lotteryOdds[52].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['双'].oddLimit}" data-limit="${command['双'].oddLimit}" data-value="${command['双'].odd}" name="lotteryOdds[52].odd" value="${command['双'].odd}">
                            </div>
                        </td>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>${views.lottery_auto['合大']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['合大'].id}" name="lotteryOdds[53].id">
                                <input type="hidden" value="${command['合大'].code}" name="lotteryOdds[53].code">
                                <input type="hidden" value="${command['合大'].betCode}" name="lotteryOdds[53].betCode">
                                <input type="hidden" value="${command['合大'].siteId}" name="lotteryOdds[53].siteId">
                                <input type="hidden" value="${command['合大'].betNum}" name="lotteryOdds[53].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['合大'].oddLimit}" data-limit="${command['合大'].oddLimit}" data-value="${command['合大'].odd}" name="lotteryOdds[53].odd" value="${command['合大'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['合小']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['合小'].id}" name="lotteryOdds[54].id">
                                <input type="hidden" value="${command['合小'].code}" name="lotteryOdds[54].code">
                                <input type="hidden" value="${command['合小'].betCode}" name="lotteryOdds[54].betCode">
                                <input type="hidden" value="${command['合小'].siteId}" name="lotteryOdds[54].siteId">
                                <input type="hidden" value="${command['合小'].betNum}" name="lotteryOdds[54].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['合小'].oddLimit}" data-limit="${command['合小'].oddLimit}" data-value="${command['合小'].odd}" name="lotteryOdds[54].odd" value="${command['合小'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['合单']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['合单'].id}" name="lotteryOdds[55].id">
                                <input type="hidden" value="${command['合单'].code}" name="lotteryOdds[55].code">
                                <input type="hidden" value="${command['合单'].betCode}" name="lotteryOdds[55].betCode">
                                <input type="hidden" value="${command['合单'].siteId}" name="lotteryOdds[55].siteId">
                                <input type="hidden" value="${command['合单'].betNum}" name="lotteryOdds[55].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['合单'].oddLimit}" data-limit="${command['合单'].oddLimit}" data-value="${command['合单'].odd}" name="lotteryOdds[55].odd" value="${command['合单'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['合双']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['合双'].id}" name="lotteryOdds[56].id">
                                <input type="hidden" value="${command['合双'].code}" name="lotteryOdds[56].code">
                                <input type="hidden" value="${command['合双'].betCode}" name="lotteryOdds[56].betCode">
                                <input type="hidden" value="${command['合双'].siteId}" name="lotteryOdds[56].siteId">
                                <input type="hidden" value="${command['合双'].betNum}" name="lotteryOdds[56].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['合双'].oddLimit}" data-limit="${command['合双'].oddLimit}" data-value="${command['合双'].odd}" name="lotteryOdds[56].odd" value="${command['合双'].odd}">
                            </div>
                        </td>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>${views.lottery_auto['尾大']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['尾大'].id}" name="lotteryOdds[57].id">
                                <input type="hidden" value="${command['尾大'].code}" name="lotteryOdds[57].code">
                                <input type="hidden" value="${command['尾大'].betCode}" name="lotteryOdds[57].betCode">
                                <input type="hidden" value="${command['尾大'].siteId}" name="lotteryOdds[57].siteId">
                                <input type="hidden" value="${command['尾大'].betNum}" name="lotteryOdds[57].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['尾大'].oddLimit}" data-limit="${command['尾大'].oddLimit}" data-value="${command['尾大'].odd}" name="lotteryOdds[57].odd" value="${command['尾大'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['尾小']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['尾小'].id}" name="lotteryOdds[58].id">
                                <input type="hidden" value="${command['尾小'].code}" name="lotteryOdds[58].code">
                                <input type="hidden" value="${command['尾小'].betCode}" name="lotteryOdds[58].betCode">
                                <input type="hidden" value="${command['尾小'].siteId}" name="lotteryOdds[58].siteId">
                                <input type="hidden" value="${command['尾小'].betNum}" name="lotteryOdds[58].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['尾小'].oddLimit}" data-limit="${command['尾小'].oddLimit}" data-value="${command['尾小'].odd}" name="lotteryOdds[58].odd" value="${command['尾小'].odd}">
                            </div>
                        </td>
                        <%--<th>${views.lottery_auto['尾单']}</th>--%>
                        <%--<td>--%>
                            <%--<div class="input-group content-width-limit-10">--%>
                                <%--<input type="hidden" value="${command['尾单'].id}" name="lotteryOdds[59].id">--%>
                                <%--<input type="hidden" value="${command['尾单'].code}" name="lotteryOdds[59].code">--%>
                                <%--<input type="hidden" value="${command['尾单'].betCode}" name="lotteryOdds[59].betCode">--%>
                                <%--<input type="hidden" value="${command['尾单'].siteId}" name="lotteryOdds[59].siteId">--%>
                                <%--<input type="hidden" value="${command['尾单'].betNum}" name="lotteryOdds[59].betNum">--%>
                                <%--<input type="text" class="form-control input-sm" name="lotteryOdds[59].odd" value="${command['尾单'].odd}">--%>
                            <%--</div>--%>
                        <%--</td>--%>
                        <%--<th>${views.lottery_auto['尾双']}</th>--%>
                        <%--<td>--%>
                            <%--<div class="input-group content-width-limit-10">--%>
                                <%--<input type="hidden" value="${command['尾双'].id}" name="lotteryOdds[60].id">--%>
                                <%--<input type="hidden" value="${command['尾双'].code}" name="lotteryOdds[60].code">--%>
                                <%--<input type="hidden" value="${command['尾双'].betCode}" name="lotteryOdds[60].betCode">--%>
                                <%--<input type="hidden" value="${command['尾双'].siteId}" name="lotteryOdds[60].siteId">--%>
                                <%--<input type="hidden" value="${command['尾双'].betNum}" name="lotteryOdds[60].betNum">--%>
                                <%--<input type="text" class="form-control input-sm" name="lotteryOdds[60].odd" value="${command['尾双'].odd}">--%>
                            <%--</div>--%>
                        <%--</td>--%>
                        <th colspan="6"></th>
                    </tr>


                    <tr>
                        <th>${views.lottery_auto['红波']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['红波'].id}" name="lotteryOdds[61].id">
                                <input type="hidden" value="${command['红波'].code}" name="lotteryOdds[61].code">
                                <input type="hidden" value="${command['红波'].betCode}" name="lotteryOdds[61].betCode">
                                <input type="hidden" value="${command['红波'].siteId}" name="lotteryOdds[61].siteId">
                                <input type="hidden" value="${command['红波'].betNum}" name="lotteryOdds[61].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['红波'].oddLimit}" data-limit="${command['红波'].oddLimit}" data-value="${command['红波'].odd}" name="lotteryOdds[61].odd" value="${command['红波'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['蓝波']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['蓝波'].id}" name="lotteryOdds[62].id">
                                <input type="hidden" value="${command['蓝波'].code}" name="lotteryOdds[62].code">
                                <input type="hidden" value="${command['蓝波'].betCode}" name="lotteryOdds[62].betCode">
                                <input type="hidden" value="${command['蓝波'].siteId}" name="lotteryOdds[62].siteId">
                                <input type="hidden" value="${command['蓝波'].betNum}" name="lotteryOdds[62].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['蓝波'].oddLimit}" data-limit="${command['蓝波'].oddLimit}" data-value="${command['蓝波'].odd}" name="lotteryOdds[62].odd" value="${command['蓝波'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['绿波']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['绿波'].id}" name="lotteryOdds[63].id">
                                <input type="hidden" value="${command['绿波'].code}" name="lotteryOdds[63].code">
                                <input type="hidden" value="${command['绿波'].betCode}" name="lotteryOdds[63].betCode">
                                <input type="hidden" value="${command['绿波'].siteId}" name="lotteryOdds[63].siteId">
                                <input type="hidden" value="${command['绿波'].betNum}" name="lotteryOdds[63].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['绿波'].oddLimit}" data-limit="${command['绿波'].oddLimit}" data-value="${command['绿波'].odd}" name="lotteryOdds[63].odd" value="${command['绿波'].odd}">
                            </div>
                        </td>
                        <th colspan="4"></th>
                    </tr>


                    <tr>
                        <th>${views.lottery_auto['大单']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['大单'].id}" name="lotteryOdds[64].id">
                                <input type="hidden" value="${command['大单'].code}" name="lotteryOdds[64].code">
                                <input type="hidden" value="${command['大单'].betCode}" name="lotteryOdds[64].betCode">
                                <input type="hidden" value="${command['大单'].siteId}" name="lotteryOdds[64].siteId">
                                <input type="hidden" value="${command['大单'].betNum}" name="lotteryOdds[64].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['大单'].oddLimit}" data-limit="${command['大单'].oddLimit}" data-value="${command['大单'].odd}" name="lotteryOdds[64].odd" value="${command['大单'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['小单']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['小单'].id}" name="lotteryOdds[65].id">
                                <input type="hidden" value="${command['小单'].code}" name="lotteryOdds[65].code">
                                <input type="hidden" value="${command['小单'].betCode}" name="lotteryOdds[65].betCode">
                                <input type="hidden" value="${command['小单'].siteId}" name="lotteryOdds[65].siteId">
                                <input type="hidden" value="${command['小单'].betNum}" name="lotteryOdds[65].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['小单'].oddLimit}" data-limit="${command['小单'].oddLimit}" data-value="${command['小单'].odd}" name="lotteryOdds[65].odd" value="${command['小单'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['大双']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['大双'].id}" name="lotteryOdds[66].id">
                                <input type="hidden" value="${command['大双'].code}" name="lotteryOdds[66].code">
                                <input type="hidden" value="${command['大双'].betCode}" name="lotteryOdds[66].betCode">
                                <input type="hidden" value="${command['大双'].siteId}" name="lotteryOdds[66].siteId">
                                <input type="hidden" value="${command['大双'].betNum}" name="lotteryOdds[66].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['大双'].oddLimit}" data-limit="${command['大双'].oddLimit}" data-value="${command['大双'].odd}" name="lotteryOdds[66].odd" value="${command['大双'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['小双']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['小双'].id}" name="lotteryOdds[67].id">
                                <input type="hidden" value="${command['小双'].code}" name="lotteryOdds[67].code">
                                <input type="hidden" value="${command['小双'].betCode}" name="lotteryOdds[67].betCode">
                                <input type="hidden" value="${command['小双'].siteId}" name="lotteryOdds[67].siteId">
                                <input type="hidden" value="${command['小双'].betNum}" name="lotteryOdds[67].betNum">
                                <input type="text" class="form-control input-sm" placeholder="<=${command['小双'].oddLimit}" data-limit="${command['小双'].oddLimit}" data-value="${command['小双'].odd}" name="lotteryOdds[67].odd" value="${command['小双'].odd}">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>${views.lottery_auto['鼠']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['鼠'].id}" name="lotteryOdds[64].id">
                                <input type="hidden" value="${command['鼠'].code}" name="lotteryOdds[64].code">
                                <input type="hidden" value="${command['鼠'].betCode}" name="lotteryOdds[64].betCode">
                                <input type="hidden" value="${command['鼠'].siteId}" name="lotteryOdds[64].siteId">
                                <input type="hidden" value="${command['鼠'].betNum}" name="lotteryOdds[64].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[64].odd" value="${command['鼠'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['牛']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['牛'].id}" name="lotteryOdds[65].id">
                                <input type="hidden" value="${command['牛'].code}" name="lotteryOdds[65].code">
                                <input type="hidden" value="${command['牛'].betCode}" name="lotteryOdds[65].betCode">
                                <input type="hidden" value="${command['牛'].siteId}" name="lotteryOdds[65].siteId">
                                <input type="hidden" value="${command['牛'].betNum}" name="lotteryOdds[65].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[65].odd" value="${command['牛'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['虎']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['虎'].id}" name="lotteryOdds[66].id">
                                <input type="hidden" value="${command['虎'].code}" name="lotteryOdds[66].code">
                                <input type="hidden" value="${command['虎'].betCode}" name="lotteryOdds[66].betCode">
                                <input type="hidden" value="${command['虎'].siteId}" name="lotteryOdds[66].siteId">
                                <input type="hidden" value="${command['虎'].betNum}" name="lotteryOdds[66].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[66].odd" value="${command['虎'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['兔']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['兔'].id}" name="lotteryOdds[67].id">
                                <input type="hidden" value="${command['兔'].code}" name="lotteryOdds[67].code">
                                <input type="hidden" value="${command['兔'].betCode}" name="lotteryOdds[67].betCode">
                                <input type="hidden" value="${command['兔'].siteId}" name="lotteryOdds[67].siteId">
                                <input type="hidden" value="${command['兔'].betNum}" name="lotteryOdds[67].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[67].odd" value="${command['兔'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['龙']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['龙'].id}" name="lotteryOdds[68].id">
                                <input type="hidden" value="${command['龙'].code}" name="lotteryOdds[68].code">
                                <input type="hidden" value="${command['龙'].betCode}" name="lotteryOdds[68].betCode">
                                <input type="hidden" value="${command['龙'].siteId}" name="lotteryOdds[68].siteId">
                                <input type="hidden" value="${command['龙'].betNum}" name="lotteryOdds[68].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[68].odd" value="${command['龙'].odd}">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>${views.lottery_auto['蛇']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['蛇'].id}" name="lotteryOdds[69].id">
                                <input type="hidden" value="${command['蛇'].code}" name="lotteryOdds[69].code">
                                <input type="hidden" value="${command['蛇'].betCode}" name="lotteryOdds[69].betCode">
                                <input type="hidden" value="${command['蛇'].siteId}" name="lotteryOdds[69].siteId">
                                <input type="hidden" value="${command['蛇'].betNum}" name="lotteryOdds[69].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[69].odd" value="${command['蛇'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['马']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['马'].id}" name="lotteryOdds[70].id">
                                <input type="hidden" value="${command['马'].code}" name="lotteryOdds[70].code">
                                <input type="hidden" value="${command['马'].betCode}" name="lotteryOdds[70].betCode">
                                <input type="hidden" value="${command['马'].siteId}" name="lotteryOdds[70].siteId">
                                <input type="hidden" value="${command['马'].betNum}" name="lotteryOdds[70].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[70].odd" value="${command['马'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['羊']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['羊'].id}" name="lotteryOdds[71].id">
                                <input type="hidden" value="${command['羊'].code}" name="lotteryOdds[71].code">
                                <input type="hidden" value="${command['羊'].betCode}" name="lotteryOdds[71].betCode">
                                <input type="hidden" value="${command['羊'].siteId}" name="lotteryOdds[71].siteId">
                                <input type="hidden" value="${command['羊'].betNum}" name="lotteryOdds[71].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[71].odd" value="${command['羊'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['猴']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['猴'].id}" name="lotteryOdds[72].id">
                                <input type="hidden" value="${command['猴'].code}" name="lotteryOdds[72].code">
                                <input type="hidden" value="${command['猴'].betCode}" name="lotteryOdds[72].betCode">
                                <input type="hidden" value="${command['猴'].siteId}" name="lotteryOdds[72].siteId">
                                <input type="hidden" value="${command['猴'].betNum}" name="lotteryOdds[72].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[72].odd" value="${command['猴'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['鸡']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['鸡'].id}" name="lotteryOdds[73].id">
                                <input type="hidden" value="${command['鸡'].code}" name="lotteryOdds[73].code">
                                <input type="hidden" value="${command['鸡'].betCode}" name="lotteryOdds[73].betCode">
                                <input type="hidden" value="${command['鸡'].siteId}" name="lotteryOdds[73].siteId">
                                <input type="hidden" value="${command['鸡'].betNum}" name="lotteryOdds[73].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[73].odd" value="${command['鸡'].odd}">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>${views.lottery_auto['狗']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['狗'].id}" name="lotteryOdds[74].id">
                                <input type="hidden" value="${command['狗'].code}" name="lotteryOdds[74].code">
                                <input type="hidden" value="${command['狗'].betCode}" name="lotteryOdds[74].betCode">
                                <input type="hidden" value="${command['狗'].siteId}" name="lotteryOdds[74].siteId">
                                <input type="hidden" value="${command['狗'].betNum}" name="lotteryOdds[74].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[74].odd" value="${command['狗'].odd}">
                            </div>
                        </td>
                        <th>${views.lottery_auto['猪']}</th>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="hidden" value="${command['猪'].id}" name="lotteryOdds[75].id">
                                <input type="hidden" value="${command['猪'].code}" name="lotteryOdds[75].code">
                                <input type="hidden" value="${command['猪'].betCode}" name="lotteryOdds[75].betCode">
                                <input type="hidden" value="${command['猪'].siteId}" name="lotteryOdds[75].siteId">
                                <input type="hidden" value="${command['猪'].betNum}" name="lotteryOdds[75].betNum">
                                <input type="text" class="form-control input-sm" name="lotteryOdds[75].odd" value="${command['猪'].odd}">
                            </div>
                        </td>
                        <th colspan="6"></th>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>