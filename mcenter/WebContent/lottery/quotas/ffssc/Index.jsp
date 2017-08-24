<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        <th><input type="checkbox" class="i-checks"></th>
                        <th>分分时时彩</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                        <th>单类别单项（号）限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>一字组合</td>
                        <input type="hidden" value="${command['one_combination'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['one_combination'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['one_combination'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['one_combination'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_combination'].numQuota}" name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_combination'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_combination'].playQuota}" name="quotaList[0].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>一字定位</td>
                        <input type="hidden" value="${command['one_digital'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['one_digital'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['one_digital'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['one_digital'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_digital'].numQuota}" name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_digital'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_digital'].playQuota}" name="quotaList[1].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>一字大小</td>
                        <input type="hidden" value="${command['one_big_small'].id}" name="quotaList[6].id">
                        <input type="hidden" value="${command['one_big_small'].siteId}" name="quotaList[6].siteId">
                        <input type="hidden" value="${command['one_big_small'].code}" name="quotaList[6].code">
                        <input type="hidden" value="${command['one_big_small'].playCode}" name="quotaList[6].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_big_small'].numQuota}" name="quotaList[6].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_big_small'].betQuota}" name="quotaList[6].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_big_small'].playQuota}" name="quotaList[6].playQuota">
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>一字单双</td>
                        <input type="hidden" value="${command['one_single_double'].id}" name="quotaList[7].id">
                        <input type="hidden" value="${command['one_single_double'].siteId}" name="quotaList[7].siteId">
                        <input type="hidden" value="${command['one_single_double'].code}" name="quotaList[7].code">
                        <input type="hidden" value="${command['one_single_double'].playCode}" name="quotaList[7].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_single_double'].numQuota}" name="quotaList[7].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_single_double'].betQuota}" name="quotaList[7].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_single_double'].playQuota}" name="quotaList[7].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>一字质合</td>
                        <input type="hidden" value="${command['one_prime_combined'].id}" name="quotaList[8].id">
                        <input type="hidden" value="${command['one_prime_combined'].siteId}" name="quotaList[8].siteId">
                        <input type="hidden" value="${command['one_prime_combined'].code}" name="quotaList[8].code">
                        <input type="hidden" value="${command['one_prime_combined'].playCode}" name="quotaList[8].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_prime_combined'].numQuota}" name="quotaList[8].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_prime_combined'].betQuota}" name="quotaList[8].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['one_prime_combined'].playQuota}" name="quotaList[8].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>二字组合</td>
                        <input type="hidden" value="${command['two_combination'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['two_combination'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['two_combination'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['two_combination'].playCode}" name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['two_combination'].numQuota}" name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['two_combination'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['two_combination'].playQuota}" name="quotaList[2].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>二字定位</td>
                        <input type="hidden" value="${command['two_digital'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['two_digital'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['two_digital'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['two_digital'].playCode}" name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['two_digital'].numQuota}" name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['two_digital'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['two_digital'].playQuota}" name="quotaList[3].playQuota">
                            </div>
                        </td>
                    </tr>


                    <%--<tr>--%>
                    <%--<th><input type="checkbox" class="i-checks"></th>--%>
                    <%--<td>二字和数单双</td>--%>
                    <%--<input type="hidden" value="${command['two_sum_single_double'].id}" name="quotaList[12].id">--%>
                    <%--<input type="hidden" value="${command['two_sum_single_double'].siteId}" name="quotaList[12].siteId">--%>
                    <%--<input type="hidden" value="${command['two_sum_single_double'].code}" name="quotaList[12].code">--%>
                    <%--<input type="hidden" value="${command['two_sum_single_double'].playCode}" name="quotaList[12].playCode">--%>
                    <%--<td>--%>
                    <%--<div class="input-group content-width-limit-10">--%>
                    <%--<input type="text" class="form-control input-sm" value="${command['two_sum_single_double'].numQuota}" name="quotaList[12].numQuota">--%>

                    <%--</div>--%>
                    <%--</td>--%>
                    <%--<td>--%>
                    <%--<div class="input-group content-width-limit-10">--%>
                    <%--<input type="text" class="form-control input-sm" value="${command['two_sum_single_double'].betQuota}" name="quotaList[12].betQuota">--%>
                    <%--</div>--%>
                    <%--</td>--%>
                    <%--<td>--%>
                    <%--<div class="input-group content-width-limit-10">--%>
                    <%--<input type="text" class="form-control input-sm" value="${command['two_sum_single_double'].playQuota}" name="quotaList[12].playQuota">--%>
                    <%--</div>--%>
                    <%--</td>--%>
                    <%--</tr>--%>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>三字组合</td>
                        <input type="hidden" value="${command['three_combination'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['three_combination'].siteId}" name="quotaList[4].siteId">
                        <input type="hidden" value="${command['three_combination'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['three_combination'].playCode}" name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['three_combination'].numQuota}" name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['three_combination'].betQuota}" name="quotaList[4].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['three_combination'].playQuota}" name="quotaList[4].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>三字定位</td>
                        <input type="hidden" value="${command['three_digital'].id}" name="quotaList[5].id">
                        <input type="hidden" value="${command['three_digital'].siteId}" name="quotaList[5].siteId">
                        <input type="hidden" value="${command['three_digital'].code}" name="quotaList[5].code">
                        <input type="hidden" value="${command['three_digital'].playCode}" name="quotaList[5].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['three_digital'].numQuota}" name="quotaList[5].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['three_digital'].betQuota}" name="quotaList[5].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['three_digital'].playQuota}" name="quotaList[5].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>五字和数大小</td>
                        <input type="hidden" value="${command['five_sum_big_small'].id}" name="quotaList[9].id">
                        <input type="hidden" value="${command['five_sum_big_small'].siteId}" name="quotaList[9].siteId">
                        <input type="hidden" value="${command['five_sum_big_small'].code}" name="quotaList[9].code">
                        <input type="hidden" value="${command['five_sum_big_small'].playCode}" name="quotaList[9].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['five_sum_big_small'].numQuota}" name="quotaList[9].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['five_sum_big_small'].betQuota}" name="quotaList[9].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['five_sum_big_small'].playQuota}" name="quotaList[9].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>五字和数单双</td>
                        <input type="hidden" value="${command['five_sum_single_double'].id}" name="quotaList[10].id">
                        <input type="hidden" value="${command['five_sum_single_double'].siteId}" name="quotaList[10].siteId">
                        <input type="hidden" value="${command['five_sum_single_double'].code}" name="quotaList[10].code">
                        <input type="hidden" value="${command['five_sum_single_double'].playCode}" name="quotaList[10].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['five_sum_single_double'].numQuota}" name="quotaList[10].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['five_sum_single_double'].betQuota}" name="quotaList[10].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['five_sum_single_double'].playQuota}" name="quotaList[10].playQuota">
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>龙虎和</td>
                        <input type="hidden" value="${command['dragon_tiger_tie'].id}" name="quotaList[11].id">
                        <input type="hidden" value="${command['dragon_tiger_tie'].siteId}" name="quotaList[11].siteId">
                        <input type="hidden" value="${command['dragon_tiger_tie'].code}" name="quotaList[11].code">
                        <input type="hidden" value="${command['dragon_tiger_tie'].playCode}" name="quotaList[11].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['dragon_tiger_tie'].numQuota}" name="quotaList[11].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['dragon_tiger_tie'].betQuota}" name="quotaList[11].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['dragon_tiger_tie'].playQuota}" name="quotaList[11].playQuota">
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>组选三</td>
                        <input type="hidden" value="${command['group_three'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['group_three'].siteId}" name="quotaList[13].siteId">
                        <input type="hidden" value="${command['group_three'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['group_three'].playCode}" name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['group_three'].numQuota}" name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['group_three'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['group_three'].playQuota}" name="quotaList[13].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>组选六</td>
                        <input type="hidden" value="${command['group_six'].id}" name="quotaList[14].id">
                        <input type="hidden" value="${command['group_six'].siteId}" name="quotaList[14].siteId">
                        <input type="hidden" value="${command['group_six'].code}" name="quotaList[14].code">
                        <input type="hidden" value="${command['group_six'].playCode}" name="quotaList[14].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['group_six'].numQuota}" name="quotaList[14].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['group_six'].betQuota}" name="quotaList[14].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['group_six'].playQuota}" name="quotaList[14].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" class="i-checks"></th>
                        <td>跨度</td>
                        <input type="hidden" value="${command['span'].id}" name="quotaList[15].id">
                        <input type="hidden" value="${command['span'].siteId}" name="quotaList[15].siteId">
                        <input type="hidden" value="${command['span'].code}" name="quotaList[15].code">
                        <input type="hidden" value="${command['span'].playCode}" name="quotaList[15].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['span'].numQuota}" name="quotaList[15].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['span'].betQuota}" name="quotaList[15].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['span'].playQuota}" name="quotaList[15].playQuota">
                            </div>
                        </td>
                    </tr>


                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
