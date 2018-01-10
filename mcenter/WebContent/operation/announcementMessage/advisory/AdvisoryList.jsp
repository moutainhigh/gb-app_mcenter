<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.PlayerTransactionVo"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="row">
    <form:form action="${root}/operation/announcementMessage/doAdvisoryList.html" method="post">
        <div class="position-wrap clearfix">
            <h2><a class="navbar-minimalize" href="javascript:void(0)"><i class="icon iconfont">&#xe610;</i> </a></h2>
            <span>${views.sysResource['角色']}</span><span>/</span><span>${views.sysResource['玩家咨询']}</span>
            <c:if test="${hasReturn}">
                <soul:button target="goToLastPage"
                             cssClass="m-l-sm btn btn-outline btn-default btn-xs co-gray6 return-btn" text=""
                             opType="function">
                    <em class="fa fa-caret-left"></em>${views.common['return']}
                </soul:button>
            </c:if>
        </div>


        <div class="col-lg-12">
            <div class="wrapper white-bg shadow">
                <div class="m-t-md">
                    <div class="m-b-xs clearfix">
                        <div class="col-sm-10 clearfix" style="padding-left: 0;">
                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                <span class="bg-gray input-group-addon bdn">
                                    <gb:select name="" list="${command.userList()}" listKey="key"
                                               value="search.username" listValue="value" callback="changeKey"
                                               prompt=""/>
                                </span>
                                    <input type="text" class="form-control" id="operator1" name="search.username">
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-8 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date time-select-a">
                                    <span class="input-group-addon bg-gray">${views.operation['提交/追问时间']}</span>
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:40%" useRange="true"
                                                  opens="right" position="down"
                                                  startDate="${search.advisoryTimeBegin}"
                                                  endDate="${search.advisoryTimeEnd}"
                                                  startName="search.advisoryTimeBegin"
                                                  endName="search.advisoryTimeEnd"/>
                                </div>
                            </div>

                            <div class="form-group clearfix pull-left col-md-4 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group">
                                <span class="bg-gray input-group-addon bdn">
                                    <gb:select name="" list="${command.titleList()}" listKey="key"
                                               value="search.advisoryTitle" listValue="value" callback="changeKey2"
                                               prompt=""/>
                                </span>
                                    <input type="text" class="form-control" id="operator2" name="search.advisoryTitle">
                                </div>
                            </div>


                            <div class="form-group clearfix pull-left col-md-8 col-sm-12 m-b-sm padding-r-none-sm">
                                <div class="input-group date time-select-a">
                                    <span class="input-group-addon bg-gray">${views.operation_auto['最后回复时间']}</span>
                                    <gb:dateRange format="${DateFormat.DAY_SECOND}" style="width:40%" useRange="true"
                                                  opens="right" position="down"
                                                  startDate="${search.replyTimeBegin}" endDate="${search.replyTimeEnd}"
                                                  startName="search.replyTimeBegin" endName="search.replyTimeEnd"/>
                                </div>
                            </div>
                        </div>



                        <div class="col-sm-2 clearfix">
                            <div class="pull-left">
                                <soul:button cssClass="btn btn-filter btn-query-css" tag="button" opType="function"
                                             text="${views.common['search']}" target="query">
                                    <i class="fa fa-search"></i><span class="hd">&nbsp;${views.common['search']}</span>
                                </soul:button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="wrapper white-bg shadow">
                <div class="clearfix filter-wraper border-b-1">
                    <div class="function-menu-show hide">
                        <soul:button target="deleteAdvisoryMessage" text="${views.common['delete']}" opType="function"
                                     cssClass="btn btn-outline btn-filter btn-danger-hide"
                                     confirm="${views.role['player.view.advisory.sureToDelete']}？">
                            <i class="fa fa-trash-o"></i><span class="hd">${views.common['delete']}</span>
                        </soul:button>
                    </div>
                </div>
                <!--表格内容-->
                <div class="search-list-container">
                    <%@ include file="AdvisoryListPartial.jsp" %>
                </div>
            </div>
        </div>
    </form:form>
</div>
<soul:import res="site/operation/announcementMessage"/>


