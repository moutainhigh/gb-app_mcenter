<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        
                        <th>福彩3D</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                        <th>单类别单项（号）限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        
                        <td>一字定位</td>
                        <input type="hidden" value="${command['pl3_one_digital'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['pl3_one_digital'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['pl3_one_digital'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['pl3_one_digital'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_digital'].numQuotaStr}" data-value="${command['pl3_one_digital'].numQuota}" name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_digital'].betQuotaStr}"  data-value="${command['pl3_one_digital'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_digital'].playQuotaStr}" data-value="${command['pl3_one_digital'].playQuota}" name="quotaList[0].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>一字大小</td>
                        <input type="hidden" value="${command['pl3_one_big_small'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['pl3_one_big_small'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['pl3_one_big_small'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['pl3_one_big_small'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_big_small'].numQuotaStr}" data-value="${command['pl3_one_big_small'].numQuota}" name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_big_small'].betQuotaStr}"  data-value="${command['pl3_one_big_small'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_big_small'].playQuotaStr}" data-value="${command['pl3_one_big_small'].playQuota}" name="quotaList[1].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>一字单双</td>
                        <input type="hidden" value="${command['pl3_one_single_double'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['pl3_one_single_double'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['pl3_one_single_double'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['pl3_one_single_double'].playCode}" name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_single_double'].numQuotaStr}" data-value="${command['pl3_one_single_double'].numQuota}" name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_single_double'].betQuotaStr}"  data-value="${command['pl3_one_single_double'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_single_double'].playQuotaStr}" data-value="${command['pl3_one_single_double'].playQuota}" name="quotaList[2].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>一字质合</td>
                        <input type="hidden" value="${command['pl3_one_prime_combined'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['pl3_one_prime_combined'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['pl3_one_prime_combined'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['pl3_one_prime_combined'].playCode}" name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_prime_combined'].numQuotaStr}" data-value="${command['pl3_one_prime_combined'].numQuota}" name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_prime_combined'].betQuotaStr}"  data-value="${command['pl3_one_prime_combined'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_prime_combined'].playQuotaStr}" data-value="${command['pl3_one_prime_combined'].playQuota}" name="quotaList[3].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>二字定位</td>
                        <input type="hidden" value="${command['pl3_two_digital'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['pl3_two_digital'].siteId}" name="quotaList[4].siteId">
                        <input type="hidden" value="${command['pl3_two_digital'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['pl3_two_digital'].playCode}" name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_two_digital'].numQuotaStr}" data-value="${command['pl3_two_digital'].numQuota}" name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_two_digital'].betQuotaStr}"  data-value="${command['pl3_two_digital'].betQuota}" name="quotaList[4].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_two_digital'].playQuotaStr}" data-value="${command['pl3_two_digital'].playQuota}" name="quotaList[4].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>三字定位</td>
                        <input type="hidden" value="${command['pl3_three_digital'].id}" name="quotaList[5].id">
                        <input type="hidden" value="${command['pl3_three_digital'].siteId}" name="quotaList[5].siteId">
                        <input type="hidden" value="${command['pl3_three_digital'].code}" name="quotaList[5].code">
                        <input type="hidden" value="${command['pl3_three_digital'].playCode}" name="quotaList[5].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_three_digital'].numQuotaStr}" data-value="${command['pl3_three_digital'].numQuota}" name="quotaList[5].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_three_digital'].betQuotaStr}"  data-value="${command['pl3_three_digital'].betQuota}" name="quotaList[5].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_three_digital'].playQuotaStr}" data-value="${command['pl3_three_digital'].playQuota}" name="quotaList[5].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>一字组合</td>
                        <input type="hidden" value="${command['pl3_one_combination'].id}" name="quotaList[22].id">
                        <input type="hidden" value="${command['pl3_one_combination'].siteId}" name="quotaList[22].siteId">
                        <input type="hidden" value="${command['pl3_one_combination'].code}" name="quotaList[22].code">
                        <input type="hidden" value="${command['pl3_one_combination'].playCode}" name="quotaList[22].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_combination'].numQuotaStr}" data-value="${command['pl3_one_combination'].numQuota}" name="quotaList[22].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_combination'].betQuotaStr}"  data-value="${command['pl3_one_combination'].betQuota}" name="quotaList[22].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_one_combination'].playQuotaStr}" data-value="${command['pl3_one_combination'].playQuota}" name="quotaList[22].playQuota">
                            </div>
                        </td>

                    </tr>

                    <tr>
                        
                        <td>二字组合</td>
                        <input type="hidden" value="${command['pl3_two_combination'].id}" name="quotaList[6].id">
                        <input type="hidden" value="${command['pl3_two_combination'].siteId}" name="quotaList[6].siteId">
                        <input type="hidden" value="${command['pl3_two_combination'].code}" name="quotaList[6].code">
                        <input type="hidden" value="${command['pl3_two_combination'].playCode}" name="quotaList[6].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_two_combination'].numQuotaStr}" data-value="${command['pl3_two_combination'].numQuota}" name="quotaList[6].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_two_combination'].betQuotaStr}"  data-value="${command['pl3_two_combination'].betQuota}" name="quotaList[6].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_two_combination'].playQuotaStr}" data-value="${command['pl3_two_combination'].playQuota}" name="quotaList[6].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>三字组合</td>
                        <input type="hidden" value="${command['pl3_three_combination'].id}" name="quotaList[7].id">
                        <input type="hidden" value="${command['pl3_three_combination'].siteId}" name="quotaList[7].siteId">
                        <input type="hidden" value="${command['pl3_three_combination'].code}" name="quotaList[7].code">
                        <input type="hidden" value="${command['pl3_three_combination'].playCode}" name="quotaList[7].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_three_combination'].numQuotaStr}" data-value="${command['pl3_three_combination'].numQuota}" name="quotaList[7].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_three_combination'].betQuotaStr}"  data-value="${command['pl3_three_combination'].betQuota}" name="quotaList[7].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_three_combination'].playQuotaStr}" data-value="${command['pl3_three_combination'].playQuota}" name="quotaList[7].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>二字和数</td>
                        <input type="hidden" value="${command['pl3_sum2_digital'].id}" name="quotaList[8].id">
                        <input type="hidden" value="${command['pl3_sum2_digital'].siteId}" name="quotaList[8].siteId">
                        <input type="hidden" value="${command['pl3_sum2_digital'].code}" name="quotaList[8].code">
                        <input type="hidden" value="${command['pl3_sum2_digital'].playCode}" name="quotaList[8].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_digital'].numQuotaStr}" data-value="${command['pl3_sum2_digital'].numQuota}" name="quotaList[8].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_digital'].betQuotaStr}"  data-value="${command['pl3_sum2_digital'].betQuota}" name="quotaList[8].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_digital'].playQuotaStr}" data-value="${command['pl3_sum2_digital'].playQuota}" name="quotaList[8].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>二字和数单双</td>
                        <input type="hidden" value="${command['pl3_sum2_single_double'].id}" name="quotaList[9].id">
                        <input type="hidden" value="${command['pl3_sum2_single_double'].siteId}" name="quotaList[9].siteId">
                        <input type="hidden" value="${command['pl3_sum2_single_double'].code}" name="quotaList[9].code">
                        <input type="hidden" value="${command['pl3_sum2_single_double'].playCode}" name="quotaList[9].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_single_double'].numQuotaStr}" data-value="${command['pl3_sum2_single_double'].numQuota}" name="quotaList[9].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_single_double'].betQuotaStr}"  data-value="${command['pl3_sum2_single_double'].betQuota}" name="quotaList[9].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_single_double'].playQuotaStr}" data-value="${command['pl3_sum2_single_double'].playQuota}" name="quotaList[9].playQuota">
                            </div>
                        </td>
                    </tr>


                    <tr>
                        
                        <td>二字和数尾数</td>
                        <input type="hidden" value="${command['pl3_sum2_mantissa'].id}" name="quotaList[10].id">
                        <input type="hidden" value="${command['pl3_sum2_mantissa'].siteId}" name="quotaList[10].siteId">
                        <input type="hidden" value="${command['pl3_sum2_mantissa'].code}" name="quotaList[10].code">
                        <input type="hidden" value="${command['pl3_sum2_mantissa'].playCode}" name="quotaList[10].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa'].numQuotaStr}" data-value="${command['pl3_sum2_mantissa'].numQuota}" name="quotaList[10].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa'].betQuotaStr}"  data-value="${command['pl3_sum2_mantissa'].betQuota}" name="quotaList[10].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa'].playQuotaStr}" data-value="${command['pl3_sum2_mantissa'].playQuota}" name="quotaList[10].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>二字和数尾数大小</td>
                        <input type="hidden" value="${command['pl3_sum2_mantissa_big_small'].id}" name="quotaList[11].id">
                        <input type="hidden" value="${command['pl3_sum2_mantissa_big_small'].siteId}" name="quotaList[11].siteId">
                        <input type="hidden" value="${command['pl3_sum2_mantissa_big_small'].code}" name="quotaList[11].code">
                        <input type="hidden" value="${command['pl3_sum2_mantissa_big_small'].playCode}" name="quotaList[11].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa_big_small'].numQuotaStr}" data-value="${command['pl3_sum2_mantissa_big_small'].numQuota}" name="quotaList[11].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa_big_small'].betQuotaStr}"  data-value="${command['pl3_sum2_mantissa_big_small'].betQuota}" name="quotaList[11].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa_big_small'].playQuotaStr}" data-value="${command['pl3_sum2_mantissa_big_small'].playQuota}" name="quotaList[11].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        
                        <td>二字和数尾数质合</td>
                        <input type="hidden" value="${command['pl3_sum2_mantissa_prime_combined'].id}" name="quotaList[12].id">
                        <input type="hidden" value="${command['pl3_sum2_mantissa_prime_combined'].siteId}" name="quotaList[12].siteId">
                        <input type="hidden" value="${command['pl3_sum2_mantissa_prime_combined'].code}" name="quotaList[12].code">
                        <input type="hidden" value="${command['pl3_sum2_mantissa_prime_combined'].playCode}" name="quotaList[12].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa_prime_combined'].numQuotaStr}" data-value="${command['pl3_sum2_mantissa_prime_combined'].numQuota}" name="quotaList[12].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa_prime_combined'].betQuotaStr}"  data-value="${command['pl3_sum2_mantissa_prime_combined'].betQuota}" name="quotaList[12].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum2_mantissa_prime_combined'].playQuotaStr}" data-value="${command['pl3_sum2_mantissa_prime_combined'].playQuota}" name="quotaList[12].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>三字和数</td>
                        <input type="hidden" value="${command['pl3_sum3_digital'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['pl3_sum3_digital'].siteId}" name="quotaList[13].siteId">
                        <input type="hidden" value="${command['pl3_sum3_digital'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['pl3_sum3_digital'].playCode}" name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_digital'].numQuotaStr}" data-value="${command['pl3_sum3_digital'].numQuota}" name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_digital'].betQuotaStr}"  data-value="${command['pl3_sum3_digital'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_digital'].playQuotaStr}" data-value="${command['pl3_sum3_digital'].playQuota}" name="quotaList[13].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>三字和数尾数</td>
                        <input type="hidden" value="${command['pl3_sum3_mantissa'].id}" name="quotaList[14].id">
                        <input type="hidden" value="${command['pl3_sum3_mantissa'].siteId}" name="quotaList[14].siteId">
                        <input type="hidden" value="${command['pl3_sum3_mantissa'].code}" name="quotaList[14].code">
                        <input type="hidden" value="${command['pl3_sum3_mantissa'].playCode}" name="quotaList[14].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa'].numQuotaStr}" data-value="${command['pl3_sum3_mantissa'].numQuota}" name="quotaList[14].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa'].betQuotaStr}"  data-value="${command['pl3_sum3_mantissa'].betQuota}" name="quotaList[14].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa'].playQuotaStr}" data-value="${command['pl3_sum3_mantissa'].playQuota}" name="quotaList[14].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>三字和数大小</td>
                        <input type="hidden" value="${command['pl3_sum3_big_small'].id}" name="quotaList[15].id">
                        <input type="hidden" value="${command['pl3_sum3_big_small'].siteId}" name="quotaList[15].siteId">
                        <input type="hidden" value="${command['pl3_sum3_big_small'].code}" name="quotaList[15].code">
                        <input type="hidden" value="${command['pl3_sum3_big_small'].playCode}" name="quotaList[15].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_big_small'].numQuotaStr}" data-value="${command['pl3_sum3_big_small'].numQuota}" name="quotaList[15].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_big_small'].betQuotaStr}"  data-value="${command['pl3_sum3_big_small'].betQuota}" name="quotaList[15].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_big_small'].playQuotaStr}" data-value="${command['pl3_sum3_big_small'].playQuota}" name="quotaList[15].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>三字和数单双</td>
                        <input type="hidden" value="${command['pl3_sum3_single_double'].id}" name="quotaList[16].id">
                        <input type="hidden" value="${command['pl3_sum3_single_double'].siteId}" name="quotaList[16].siteId">
                        <input type="hidden" value="${command['pl3_sum3_single_double'].code}" name="quotaList[16].code">
                        <input type="hidden" value="${command['pl3_sum3_single_double'].playCode}" name="quotaList[16].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_single_double'].numQuotaStr}" data-value="${command['pl3_sum3_single_double'].numQuota}" name="quotaList[16].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_single_double'].betQuotaStr}"  data-value="${command['pl3_sum3_single_double'].betQuota}" name="quotaList[16].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_single_double'].playQuotaStr}" data-value="${command['pl3_sum3_single_double'].playQuota}" name="quotaList[16].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>三字和数尾数大小</td>
                        <input type="hidden" value="${command['pl3_sum3_mantissa_big_small'].id}" name="quotaList[17].id">
                        <input type="hidden" value="${command['pl3_sum3_mantissa_big_small'].siteId}" name="quotaList[17].siteId">
                        <input type="hidden" value="${command['pl3_sum3_mantissa_big_small'].code}" name="quotaList[17].code">
                        <input type="hidden" value="${command['pl3_sum3_mantissa_big_small'].playCode}" name="quotaList[17].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa_big_small'].numQuotaStr}" data-value="${command['pl3_sum3_mantissa_big_small'].numQuota}" name="quotaList[17].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa_big_small'].betQuotaStr}"  data-value="${command['pl3_sum3_mantissa_big_small'].betQuota}" name="quotaList[17].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa_big_small'].playQuotaStr}" data-value="${command['pl3_sum3_mantissa_big_small'].playQuota}" name="quotaList[17].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>三字和数尾数质合</td>
                        <input type="hidden" value="${command['pl3_sum3_mantissa_prime_combined'].id}" name="quotaList[18].id">
                        <input type="hidden" value="${command['pl3_sum3_mantissa_prime_combined'].siteId}" name="quotaList[18].siteId">
                        <input type="hidden" value="${command['pl3_sum3_mantissa_prime_combined'].code}" name="quotaList[18].code">
                        <input type="hidden" value="${command['pl3_sum3_mantissa_prime_combined'].playCode}" name="quotaList[18].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa_prime_combined'].numQuotaStr}" data-value="${command['pl3_sum3_mantissa_prime_combined'].numQuota}" name="quotaList[18].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa_prime_combined'].betQuotaStr}"  data-value="${command['pl3_sum3_mantissa_prime_combined'].betQuota}" name="quotaList[18].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_sum3_mantissa_prime_combined'].playQuotaStr}" data-value="${command['pl3_sum3_mantissa_prime_combined'].playQuota}" name="quotaList[18].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>组选三</td>
                        <input type="hidden" value="${command['pl3_group_three'].id}" name="quotaList[19].id">
                        <input type="hidden" value="${command['pl3_group_three'].siteId}" name="quotaList[19].siteId">
                        <input type="hidden" value="${command['pl3_group_three'].code}" name="quotaList[19].code">
                        <input type="hidden" value="${command['pl3_group_three'].playCode}" name="quotaList[19].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_group_three'].numQuotaStr}" data-value="${command['pl3_group_three'].numQuota}" name="quotaList[19].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_group_three'].betQuotaStr}"  data-value="${command['pl3_group_three'].betQuota}" name="quotaList[19].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_group_three'].playQuotaStr}" data-value="${command['pl3_group_three'].playQuota}" name="quotaList[19].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>组选六</td>
                        <input type="hidden" value="${command['pl3_group_six'].id}" name="quotaList[20].id">
                        <input type="hidden" value="${command['pl3_group_six'].siteId}" name="quotaList[20].siteId">
                        <input type="hidden" value="${command['pl3_group_six'].code}" name="quotaList[20].code">
                        <input type="hidden" value="${command['pl3_group_six'].playCode}" name="quotaList[20].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_group_six'].numQuotaStr}" data-value="${command['pl3_group_six'].numQuota}" name="quotaList[20].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_group_six'].betQuotaStr}"  data-value="${command['pl3_group_six'].betQuota}" name="quotaList[20].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_group_six'].playQuotaStr}" data-value="${command['pl3_group_six'].playQuota}" name="quotaList[20].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>跨度</td>
                        <input type="hidden" value="${command['pl3_span'].id}" name="quotaList[21].id">
                        <input type="hidden" value="${command['pl3_span'].siteId}" name="quotaList[21].siteId">
                        <input type="hidden" value="${command['pl3_span'].code}" name="quotaList[21].code">
                        <input type="hidden" value="${command['pl3_span'].playCode}" name="quotaList[21].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_span'].numQuotaStr}" data-value="${command['pl3_span'].numQuota}" name="quotaList[21].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_span'].betQuotaStr}"  data-value="${command['pl3_span'].betQuota}" name="quotaList[21].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['pl3_span'].playQuotaStr}" data-value="${command['pl3_span'].playQuota}" name="quotaList[21].playQuota">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
