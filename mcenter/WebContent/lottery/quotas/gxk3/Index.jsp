<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="dataTables_wrapper" role="grid">
    <div class="panel-body">
        <div class="tab-content">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover dataTable m-b-none text-center" aria-describedby="editable_info">
                    <thead>
                    <tr class="bg-gray">
                        <th>广西快三</th>
                        <th>单项（号）限额</th>
                        <th>单注限额</th>
                        <th>单类别单项（号）限额</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>点数大小</td>
                        <input type="hidden" value="${command['points_big_small'].id}" name="quotaList[0].id">
                        <input type="hidden" value="${command['points_big_small'].siteId}" name="quotaList[0].siteId">
                        <input type="hidden" value="${command['points_big_small'].code}" name="quotaList[0].code">
                        <input type="hidden" value="${command['points_big_small'].playCode}" name="quotaList[0].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_big_small'].numQuota}" data-value="${command['points_big_small'].numQuota}" name="quotaList[0].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_big_small'].betQuota}" data-value="${command['points_big_small'].betQuota}" name="quotaList[0].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_big_small'].playQuota}" data-value="${command['points_big_small'].playQuota}" name="quotaList[0].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <td>点数单双</td>
                        <input type="hidden" value="${command['points_single_double'].id}" name="quotaList[1].id">
                        <input type="hidden" value="${command['points_single_double'].siteId}" name="quotaList[1].siteId">
                        <input type="hidden" value="${command['points_single_double'].code}" name="quotaList[1].code">
                        <input type="hidden" value="${command['points_single_double'].playCode}" name="quotaList[1].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_single_double'].numQuota}" data-value="${command['points_single_double'].numQuota}" name="quotaList[1].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_single_double'].betQuota}" data-value="${command['points_single_double'].betQuota}" name="quotaList[1].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_single_double'].playQuota}" data-value="${command['points_single_double'].playQuota}" name="quotaList[1].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>点数[4,17]</td>
                        <input type="hidden" value="${command['points_417'].id}" name="quotaList[2].id">
                        <input type="hidden" value="${command['points_417'].siteId}" name="quotaList[2].siteId">
                        <input type="hidden" value="${command['points_417'].code}" name="quotaList[2].code">
                        <input type="hidden" value="${command['points_417'].playCode}" name="quotaList[2].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_417'].numQuota}" data-value="${command['points_417'].numQuota}" name="quotaList[2].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_417'].betQuota}" data-value="${command['points_417'].betQuota}" name="quotaList[2].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_417'].playQuota}" data-value="${command['points_417'].playQuota}" name="quotaList[2].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>点数[5,16]</td>
                        <input type="hidden" value="${command['points_516'].id}" name="quotaList[3].id">
                        <input type="hidden" value="${command['points_516'].siteId}" name="quotaList[3].siteId">
                        <input type="hidden" value="${command['points_516'].code}" name="quotaList[3].code">
                        <input type="hidden" value="${command['points_516'].playCode}" name="quotaList[3].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_516'].numQuota}" data-value="${command['points_516'].numQuota}" name="quotaList[3].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_516'].betQuota}" data-value="${command['points_516'].betQuota}" name="quotaList[3].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_516'].playQuota}" data-value="${command['points_516'].playQuota}" name="quotaList[3].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <td>点数[6,15]</td>
                        <input type="hidden" value="${command['points_615'].id}" name="quotaList[4].id">
                        <input type="hidden" value="${command['points_615'].siteId}" name="quotaList[4].siteId">
                        <input type="hidden" value="${command['points_615'].code}" name="quotaList[4].code">
                        <input type="hidden" value="${command['points_615'].playCode}" name="quotaList[4].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_615'].numQuota}" data-value="${command['points_615'].numQuota}" name="quotaList[4].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_615'].betQuota}" data-value="${command['points_615'].betQuota}" name="quotaList[4].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_615'].playQuota}" data-value="${command['points_615'].playQuota}" name="quotaList[4].playQuota">
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <td>点数[7,14]</td>
                        <input type="hidden" value="${command['points_714'].id}" name="quotaList[5].id">
                        <input type="hidden" value="${command['points_714'].siteId}" name="quotaList[5].siteId">
                        <input type="hidden" value="${command['points_714'].code}" name="quotaList[5].code">
                        <input type="hidden" value="${command['points_714'].playCode}" name="quotaList[5].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_714'].numQuota}" data-value="${command['points_714'].numQuota}" name="quotaList[5].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_714'].betQuota}" data-value="${command['points_714'].betQuota}" name="quotaList[5].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_714'].playQuota}" data-value="${command['points_714'].playQuota}" name="quotaList[5].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>点数[8,13]</td>
                        <input type="hidden" value="${command['points_813'].id}" name="quotaList[13].id">
                        <input type="hidden" value="${command['points_813'].siteId}" name="quotaList[13].siteId">
                        <input type="hidden" value="${command['points_813'].code}" name="quotaList[13].code">
                        <input type="hidden" value="${command['points_813'].playCode}" name="quotaList[13].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_813'].numQuota}" data-value="${command['points_813'].numQuota}" name="quotaList[13].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_813'].betQuota}" data-value="${command['points_813'].betQuota}" name="quotaList[13].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_813'].playQuota}" data-value="${command['points_813'].playQuota}" name="quotaList[13].playQuota">
                            </div>
                        </td>

                    </tr>

                    <tr>

                        <td>点数[9,12]</td>
                        <input type="hidden" value="${command['points_912'].id}" name="quotaList[6].id">
                        <input type="hidden" value="${command['points_912'].siteId}" name="quotaList[6].siteId">
                        <input type="hidden" value="${command['points_912'].code}" name="quotaList[6].code">
                        <input type="hidden" value="${command['points_912'].playCode}" name="quotaList[6].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_912'].numQuota}" data-value="${command['points_912'].numQuota}" name="quotaList[6].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_912'].betQuota}" data-value="${command['points_912'].betQuota}" name="quotaList[6].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_912'].playQuota}" data-value="${command['points_912'].playQuota}" name="quotaList[6].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>点数[10,11]</td>
                        <input type="hidden" value="${command['points_1011'].id}" name="quotaList[7].id">
                        <input type="hidden" value="${command['points_1011'].siteId}" name="quotaList[7].siteId">
                        <input type="hidden" value="${command['points_1011'].code}" name="quotaList[7].code">
                        <input type="hidden" value="${command['points_1011'].playCode}" name="quotaList[7].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_1011'].numQuota}" data-value="${command['points_1011'].numQuota}" name="quotaList[7].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_1011'].betQuota}" data-value="${command['points_1011'].betQuota}" name="quotaList[7].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['points_1011'].playQuota}" data-value="${command['points_1011'].playQuota}" name="quotaList[7].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>三军</td>
                        <input type="hidden" value="${command['armed_forces'].id}" name="quotaList[8].id">
                        <input type="hidden" value="${command['armed_forces'].siteId}" name="quotaList[8].siteId">
                        <input type="hidden" value="${command['armed_forces'].code}" name="quotaList[8].code">
                        <input type="hidden" value="${command['armed_forces'].playCode}" name="quotaList[8].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['armed_forces'].numQuota}" data-value="${command['armed_forces'].numQuota}" name="quotaList[8].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['armed_forces'].betQuota}" data-value="${command['armed_forces'].betQuota}" name="quotaList[8].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['armed_forces'].playQuota}" data-value="${command['armed_forces'].playQuota}" name="quotaList[8].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>围骰</td>
                        <input type="hidden" value="${command['dice'].id}" name="quotaList[9].id">
                        <input type="hidden" value="${command['dice'].siteId}" name="quotaList[9].siteId">
                        <input type="hidden" value="${command['dice'].code}" name="quotaList[9].code">
                        <input type="hidden" value="${command['dice'].playCode}" name="quotaList[9].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['dice'].numQuota}" data-value="${command['dice'].numQuota}" name="quotaList[9].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['dice'].betQuota}" data-value="${command['dice'].betQuota}"  name="quotaList[9].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['dice'].playQuota}" data-value="${command['dice'].playQuota}"  name="quotaList[9].playQuota">
                            </div>
                        </td>
                    </tr>


                    <tr>

                        <td>全骰</td>
                        <input type="hidden" value="${command['full_dice'].id}" name="quotaList[10].id">
                        <input type="hidden" value="${command['full_dice'].siteId}" name="quotaList[10].siteId">
                        <input type="hidden" value="${command['full_dice'].code}" name="quotaList[10].code">
                        <input type="hidden" value="${command['full_dice'].playCode}" name="quotaList[10].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['full_dice'].numQuota}" data-value="${command['full_dice'].numQuota}" name="quotaList[10].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['full_dice'].betQuota}" data-value="${command['full_dice'].betQuota}" name="quotaList[10].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['full_dice'].playQuota}" data-value="${command['full_dice'].playQuota}" name="quotaList[10].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>长牌</td>
                        <input type="hidden" value="${command['long_card'].id}" name="quotaList[11].id">
                        <input type="hidden" value="${command['long_card'].siteId}" name="quotaList[11].siteId">
                        <input type="hidden" value="${command['long_card'].code}" name="quotaList[11].code">
                        <input type="hidden" value="${command['long_card'].playCode}" name="quotaList[11].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['long_card'].numQuota}" data-value="${command['long_card'].numQuota}" name="quotaList[11].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['long_card'].betQuota}" data-value="${command['long_card'].betQuota}" name="quotaList[11].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['long_card'].playQuota}" data-value="${command['long_card'].playQuota}" name="quotaList[11].playQuota">
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td>短牌</td>
                        <input type="hidden" value="${command['short_card'].id}" name="quotaList[12].id">
                        <input type="hidden" value="${command['short_card'].siteId}" name="quotaList[12].siteId">
                        <input type="hidden" value="${command['short_card'].code}" name="quotaList[12].code">
                        <input type="hidden" value="${command['short_card'].playCode}" name="quotaList[12].playCode">
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['short_card'].numQuota}" data-value="${command['short_card'].numQuota}" name="quotaList[12].numQuota">

                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['short_card'].betQuota}" data-value="${command['short_card'].betQuota}" name="quotaList[12].betQuota">
                            </div>
                        </td>
                        <td>
                            <div class="input-group content-width-limit-10">
                                <input type="text" class="form-control input-sm" value="${command['short_card'].playQuota}" data-value="${command['short_card'].playQuota}" name="quotaList[12].playQuota">
                            </div>
                        </td>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
