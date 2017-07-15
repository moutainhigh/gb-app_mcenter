<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<%--@elvariable id="command" type="so.wwb.gamebox.model.master.player.vo.VUserPlayerVo"--%>
<html lang="zh-CN">
<head>
    <title>${views.role['Player.addplayer.title']}</title>
    <%@ include file="/include/include.head.jsp" %>
    <!-- Gritter -->
    <link href="${resComRoot}/themes/${curTheme}/style.css" rel="stylesheet">
    <link href="${resComRoot}/themes/${curTheme}/content.css" rel="stylesheet">
</head>

<body>
<form:form id="editForm" action="" method="post">
    <div id="validateRule" style="display: none">${command.validateRule}</div>
<!--新增玩家弹窗-->
<div class="modal-body">
    <div class="add-players">
                <%--账号--%>
        <div class="form-group clearfix m-b-xxs">
            <label  class="col-xs-3  al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.role['Player.addplayer.username']}</label>
            <div class="col-xs-8 p-x"><form:input path="sysUser.username" cssClass="form-control m-b"/></div>
        </div>
                <%--密码--%>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3  al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.role['Player.addplayer.pwd']}</label>
            <div class="col-xs-8 p-x"><from:password path="sysUser.password" cssClass="form-control m-b"/></div>
        </div>
                <%--重复密码--%>
        <div  class="form-group clearfix m-b-xxs">
            <label class="col-xs-3  al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.role['Player.addplayer.confirmpwd']}</label>
            <div class="col-xs-8 p-x"><input name="confirmpwd" type="password" class="form-control m-b"/></div>
        </div>
                <%--层级下拉框--%>
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3  al-right line-hi34"><span class="co-red m-r-sm">*</span>${views.role['Player.addplayer.rank']}</label>
            <div class="col-xs-8 p-x">
                <gb:select name="result.rankId" list="${rankList}" listKey="id" listValue="rankName" prompt="${views.common['pleaseSelect']}" /></div>
        </div>
                <%--区号以及电话号码--%>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3 al-right line-hi34">${views.role['Player.addplayer.tel']}</label>
            <div class="input-group m-b col-xs-8 p-x ">
                <div class="input-group-btn">
                    <gb:select name="areaCode" list="${phoneCodeMaps}" prompt="${views.common['pleaseSelect']}" />
                </div>
                <form:input path="tel" cssClass="form-control"/>
            </div>
        </div>
                <%--邮箱--%>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3 al-right line-hi34">${views.role['Player.addplayer.mail']}</label>
            <div class="col-xs-8 p-x"><form:input path="result.mail" cssClass="form-control m-b"/></div>
        </div>
                <%--昵称--%>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3 al-right line-hi34">${views.role['Player.addplayer.nickname']}</label>
            <div class="col-xs-8 p-x"><form:input path="result.nickName" cssClass="form-control m-b"/></div>
        </div>
                <%--性别下拉框--%>
        <div class="form-group clearfix m-b-sm">
                <label class="col-xs-3 al-right line-hi34">${views.role['Player.addplayer.sex']}</label>
            <div class="col-xs-8 p-x">
                <div class="col-xs-8 p-x"><gb:select name="result.sex" list="${command.sex}" prompt="${views.common['pleaseSelect']}"/></div>
            </div>
        </div>
                <%--星座，自动填充--%>
        <div class="form-group clearfix m-b-sm">
            <label  class="col-xs-3 al-right line-hi34">${views.role['Player.addplayer.constellation']}</label>
            <input id="constellation_hide" hidden name="result.constellation"/>
            <div class="col-xs-8 p-x"><form:input path="result.constellation" id="constellation" cssClass="form-control" disabled="true" /></div>
        </div>
                <%--生日--%>
        <div class="form-group clearfix m-b-xxs">
            <label class="col-xs-3 al-right line-hi34">${views.role['Player.addplayer.birthday']}</label>
                <gb:dateRange format="${DateFormat.DAY}" style="width:100px" callback="changeDate" showDropdowns="true"
                              name="result.birthday" id="birthday"></gb:dateRange>
        </div>
                <%--国家和地区，联动下拉框--%>
        <div class="form-group clearfix m-b-sm">
            <label class="col-xs-3 al-right line-hi34">${views.role['Player.addplayer.locality']}</label>
            <div class="clearfix m-l-n col-xs-8 p-x">
                <div class="col-xs-5 input-group">
                    <div class="input-group-btn"   >
                        <gb:select name="result.nation" prompt="${views.common['pleaseSelect']}"
                               ajaxListPath="${root}/regions/site.html" listValue="remark" listKey="dictCode"
                               relSelect="result.province" />
                    </div>

                    <gb:select name="result.province" prompt="${views.common['pleaseSelect']}"
                               ajaxListPath="${root}/regions/states/${command.sysUser.nation}.html"
                               relSelectPath="${root}/regions/states/#result.nation#.html" listValue="remark"
                               listKey="dictCode" />
                </div>
            </div>
        </div>
                <%--QQ,MSN,Skype等联系方式--%>
        <c:forEach items="${command.contactTypeMap}" var="map" varStatus="i">
            <c:if test="${map.value.remark eq 'QQ'||map.value.remark eq 'MSN'||map.value.remark eq 'Skype'}">
                <div class="form-group clearfix m-b-xxs">
                    <label class="col-xs-3 al-right line-hi34">${map.value.remark}</label>
                    <input type="hidden" name="noticeContactWays[${i.index}].contactType" value="${map.key}">
                    <div class="col-xs-8 p-x"><input type="text" name="noticeContactWays[${i.index}].contactValue" class="form-control m-b"/></div>
                </div>
            </c:if>
        </c:forEach>
        </div>
    </div>

    <div class="modal-footer">
        <soul:button cssClass="btn btn-filter" text="${views.common['OK']}" opType="ajax" target="${root}/userPlayer/persist.html" precall="validateForm" post="getCurrentFormData" callback="saveCallbak"/>
        <soul:button cssClass="btn btn-outline btn-filter" opType="function" target="closePage" text="${views.common['cancel']}"/>
    </div>
    <%--星座国际化取值--%>
    <div class="hidden">
        <input type="hidden" name="result.userAgentId" value="120">
        <input id="${views.player_auto['魔羯']}" value=${views.role['constellation.capricorn']}>
        <input id="${views.player_auto['水瓶']}" value=${views.role['constellation.aquarius']}>
        <input id="${views.player_auto['双鱼']}" value=${views.role['constellation.pisces']}>
        <input id="${views.player_auto['牧羊']}" value=${views.role['constellation.aries']}>
        <input id="${views.player_auto['金牛']}" value=${views.role['constellation.taurus']}>
        <input id="${views.player_auto['双子']}" value=${views.role['constellation.gemini']}>
        <input id="${views.player_auto['巨蟹']}" value=${views.role['constellation.cancer']}>
        <input id="${views.player_auto['狮子']}" value=${views.role['constellation.leo']}>
        <input id="${views.player_auto['处女']}" value=${views.role['constellation.virgo']}>
        <input id="${views.player_auto['天秤']}" value=${views.role['constellation.libra']}>
        <input id="${views.player_auto['天蝎']}" value=${views.role['constellation.scorpio']}>
        <input id="${views.player_auto['射手']}" value=${views.role['constellation.sagittarius']}>
    </div>
</form:form>
</body>
<%@ include file="/include/include.js.jsp" %>
<soul:import res="site/player/player/addplayer/addPlayer"/>
</html>