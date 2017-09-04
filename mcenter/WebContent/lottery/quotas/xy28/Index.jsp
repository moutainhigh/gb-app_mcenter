<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                       
                        <th>幸运28</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                        <th>单类别单项（号）限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                       
                        <td>大小</td>
                        <input type="hidden" value="${command['xy28_sum3_big_small'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['xy28_sum3_big_small'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['xy28_sum3_big_small'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['xy28_sum3_big_small'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_big_small'].numQuota}" data-value="${command['xy28_sum3_big_small'].numQuota}"  name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_big_small'].betQuota}" data-value="${command['xy28_sum3_big_small'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_big_small'].playQuota}" data-value="${command['xy28_sum3_big_small'].playQuota}" name="quotaList[0].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>色波</td>
                        <input type="hidden" value="${command['xy28_sum3_colour'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['xy28_sum3_colour'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['xy28_sum3_colour'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['xy28_sum3_colour'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_colour'].numQuota}" data-value="${command['xy28_sum3_colour'].numQuota}"  name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_colour'].betQuota}" data-value="${command['xy28_sum3_colour'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_colour'].playQuota}" data-value="${command['xy28_sum3_colour'].playQuota}" name="quotaList[1].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>特码</td>
                        <input type="hidden" value="${command['xy28_sum3_digital'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['xy28_sum3_digital'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['xy28_sum3_digital'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['xy28_sum3_digital'].playCode}" name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_digital'].numQuota}" data-value="${command['xy28_sum3_digital'].numQuota}"  name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_digital'].betQuota}" data-value="${command['xy28_sum3_digital'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_digital'].playQuota}" data-value="${command['xy28_sum3_digital'].playQuota}" name="quotaList[2].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>特码包三</td>
                        <input type="hidden" value="${command['xy28_sum3_digital_three'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['xy28_sum3_digital_three'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['xy28_sum3_digital_three'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['xy28_sum3_digital_three'].playCode}" name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_digital_three'].numQuota}" data-value="${command['xy28_sum3_digital_three'].numQuota}"  name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_digital_three'].betQuota}" data-value="${command['xy28_sum3_digital_three'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_digital_three'].playQuota}" data-value="${command['xy28_sum3_digital_three'].playQuota}" name="quotaList[3].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>极值</td>
                        <input type="hidden" value="${command['xy28_sum3_extreme'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['xy28_sum3_extreme'].siteId}" name="quotaList[4].siteId">
                        <input type="hidden" value="${command['xy28_sum3_extreme'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['xy28_sum3_extreme'].playCode}" name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_extreme'].numQuota}" data-value="${command['xy28_sum3_extreme'].numQuota}"  name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_extreme'].betQuota}" data-value="${command['xy28_sum3_extreme'].betQuota}" name="quotaList[4].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_extreme'].playQuota}" data-value="${command['xy28_sum3_extreme'].playQuota}" name="quotaList[4].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                       
                        <td>半特</td>
                        <input type="hidden" value="${command['xy28_sum3_half'].id}" name="quotaList[5].id">
                        <input type="hidden" value="${command['xy28_sum3_half'].siteId}" name="quotaList[5].siteId">
                        <input type="hidden" value="${command['xy28_sum3_half'].code}" name="quotaList[5].code">
                        <input type="hidden" value="${command['xy28_sum3_half'].playCode}" name="quotaList[5].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_half'].numQuota}" data-value="${command['xy28_sum3_half'].numQuota}"  name="quotaList[5].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_half'].betQuota}" data-value="${command['xy28_sum3_half'].betQuota}" name="quotaList[5].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_half'].playQuota}" data-value="${command['xy28_sum3_half'].playQuota}" name="quotaList[5].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                       
                        <td>单双</td>
                        <input type="hidden" value="${command['xy28_sum3_single_double'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['xy28_sum3_single_double'].siteId}" name="quotaList[13].siteId">
                        <input type="hidden" value="${command['xy28_sum3_single_double'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['xy28_sum3_single_double'].playCode}" name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_single_double'].numQuota}" data-value="${command['xy28_sum3_single_double'].numQuota}"  name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_single_double'].betQuota}" data-value="${command['xy28_sum3_single_double'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_sum3_single_double'].playQuota}" data-value="${command['xy28_sum3_single_double'].playQuota}" name="quotaList[13].playQuota">
                            </div>
                        </td>

                    </tr>

                    <tr>
                       
                        <td>豹子</td>
                        <input type="hidden" value="${command['xy28_three_same'].id}" name="quotaList[6].id">
                        <input type="hidden" value="${command['xy28_three_same'].siteId}" name="quotaList[6].siteId">
                        <input type="hidden" value="${command['xy28_three_same'].code}" name="quotaList[6].code">
                        <input type="hidden" value="${command['xy28_three_same'].playCode}" name="quotaList[6].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_three_same'].numQuota}" data-value="${command['xy28_three_same'].numQuota}"  name="quotaList[6].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_three_same'].betQuota}" data-value="${command['xy28_three_same'].betQuota}" name="quotaList[6].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['xy28_three_same'].playQuota}" data-value="${command['xy28_three_same'].playQuota}" name="quotaList[6].playQuota">
                            </div>
                        </td>
                    </tr>


                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
