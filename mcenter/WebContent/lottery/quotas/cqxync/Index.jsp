<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center"
                       aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">

                        <th>重庆幸运农场</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                        <th>单类别单项（号）限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>

                        <td>大小</td>
                        <input type="hidden" value="${command['sfc_big_small'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['sfc_big_small'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['sfc_big_small'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['sfc_big_small'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_big_small'].numQuotaStr}" data-value="${command['sfc_big_small'].numQuota}"  name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_big_small'].betQuotaStr}" data-value="${command['sfc_big_small'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_big_small'].playQuotaStr}" data-value="${command['sfc_big_small'].playQuota}" name="quotaList[0].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <td>定位</td>
                        <input type="hidden" value="${command['sfc_digital'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['sfc_digital'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['sfc_digital'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['sfc_digital'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_digital'].numQuotaStr}" data-value="${command['sfc_digital'].numQuota}"  name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_digital'].betQuotaStr}" data-value="${command['sfc_digital'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_digital'].playQuotaStr}" data-value="${command['sfc_digital'].playQuota}" name="quotaList[1].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>龙虎</td>
                        <input type="hidden" value="${command['sfc_dragon_tiger'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['sfc_dragon_tiger'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['sfc_dragon_tiger'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['sfc_dragon_tiger'].playCode}"
                               name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_dragon_tiger'].numQuotaStr}" data-value="${command['sfc_dragon_tiger'].numQuota}"  name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_dragon_tiger'].betQuotaStr}" data-value="${command['sfc_dragon_tiger'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_dragon_tiger'].playQuotaStr}" data-value="${command['sfc_dragon_tiger'].playQuota}" name="quotaList[2].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>单双</td>
                        <input type="hidden" value="${command['sfc_single_double'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['sfc_single_double'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['sfc_single_double'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['sfc_single_double'].playCode}"
                               name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_single_double'].numQuotaStr}" data-value="${command['sfc_single_double'].numQuota}"  name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_single_double'].betQuotaStr}" data-value="${command['sfc_single_double'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_single_double'].playQuotaStr}" data-value="${command['sfc_single_double'].playQuota}" name="quotaList[3].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <td>尾数大小</td>
                        <input type="hidden" value="${command['sfc_mantissa_big_small'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['sfc_mantissa_big_small'].siteId}"
                               name="quotaList[4].siteId">
                        <input type="hidden" value="${command['sfc_mantissa_big_small'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['sfc_mantissa_big_small'].playCode}"
                               name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_mantissa_big_small'].numQuotaStr}"
                                       data-value="${command['sfc_mantissa_big_small'].numQuota}"
                                       name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_mantissa_big_small'].betQuotaStr}"
                                       data-value="${command['sfc_mantissa_big_small'].betQuota}"
                                       name="quotaList[4].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_mantissa_big_small'].playQuotaStr}"
                                       data-value="${command['sfc_mantissa_big_small'].playQuota}"
                                       name="quotaList[4].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <td>合数单双</td>
                        <input type="hidden" value="${command['sfc_sum_single_double'].id}" name="quotaList[5].id">
                        <input type="hidden" value="${command['sfc_sum_single_double'].siteId}"
                               name="quotaList[5].siteId">
                        <input type="hidden" value="${command['sfc_sum_single_double'].code}" name="quotaList[5].code">
                        <input type="hidden" value="${command['sfc_sum_single_double'].playCode}"
                               name="quotaList[5].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum_single_double'].numQuotaStr}"
                                       data-value="${command['sfc_sum_single_double'].numQuota}"
                                       name="quotaList[5].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum_single_double'].betQuotaStr}"
                                       data-value="${command['sfc_sum_single_double'].betQuota}"
                                       name="quotaList[5].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum_single_double'].playQuotaStr}"
                                       data-value="${command['sfc_sum_single_double'].playQuota}"
                                       name="quotaList[5].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>总和大小</td>
                        <input type="hidden" value="${command['sfc_sum8_big_small'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['sfc_sum8_big_small'].siteId}"
                               name="quotaList[13].siteId">
                        <input type="hidden" value="${command['sfc_sum8_big_small'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['sfc_sum8_big_small'].playCode}"
                               name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_big_small'].numQuotaStr}" data-value="${command['sfc_sum8_big_small'].numQuota}"  name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_big_small'].betQuotaStr}" data-value="${command['sfc_sum8_big_small'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_big_small'].playQuotaStr}"
                                       data-value="${command['sfc_sum8_big_small'].playQuota}"
                                       name="quotaList[13].playQuota">
                            </div>
                        </td>

                    </tr>

                    <tr>

                        <td>总和单双</td>
                        <input type="hidden" value="${command['sfc_sum8_single_double'].id}" name="quotaList[6].id">
                        <input type="hidden" value="${command['sfc_sum8_single_double'].siteId}"
                               name="quotaList[6].siteId">
                        <input type="hidden" value="${command['sfc_sum8_single_double'].code}" name="quotaList[6].code">
                        <input type="hidden" value="${command['sfc_sum8_single_double'].playCode}"
                               name="quotaList[6].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_single_double'].numQuotaStr}"
                                       data-value="${command['sfc_sum8_single_double'].numQuota}"
                                       name="quotaList[6].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_single_double'].betQuotaStr}"
                                       data-value="${command['sfc_sum8_single_double'].betQuota}"
                                       name="quotaList[6].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_single_double'].playQuotaStr}"
                                       data-value="${command['sfc_sum8_single_double'].playQuota}"
                                       name="quotaList[6].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>总和尾数大小</td>
                        <input type="hidden" value="${command['sfc_sum8_mantissa_big_small'].id}"
                               name="quotaList[7].id">
                        <input type="hidden" value="${command['sfc_sum8_mantissa_big_small'].siteId}"
                               name="quotaList[7].siteId">
                        <input type="hidden" value="${command['sfc_sum8_mantissa_big_small'].code}"
                               name="quotaList[7].code">
                        <input type="hidden" value="${command['sfc_sum8_mantissa_big_small'].playCode}"
                               name="quotaList[7].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_mantissa_big_small'].numQuotaStr}"
                                       data-value="${command['sfc_sum8_mantissa_big_small'].numQuota}"
                                       name="quotaList[7].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_mantissa_big_small'].betQuotaStr}"
                                       data-value="${command['sfc_sum8_mantissa_big_small'].betQuota}"
                                       name="quotaList[7].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm"
                                       value="${command['sfc_sum8_mantissa_big_small'].playQuotaStr}"
                                       data-value="${command['sfc_sum8_mantissa_big_small'].playQuota}"
                                       name="quotaList[7].playQuota">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
