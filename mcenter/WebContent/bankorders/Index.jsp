<%--@elvariable id="command" type="so.wwb.gamebox.model.master.bankorders.vo.BankOrdersListVo"--%>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/include/include.inc.jsp" %>
<html>
<head>
    <%@ include file="/include/include.head.jsp" %>
    <script src="${resComRoot}/js/jquery/jquery-2.1.1.js"></script>
    <script type="text/javascript">
        function save() {
            var returnValue = "";
            $.ajax({
                url:"${root}/bankOrders/saveData.html?d="+new Date().getTime(),
                type: "post",
                dataType:'json',
                data : $("#form").serialize(),
                async: false,
                success:function(data) {
                    returnValue = JSON.stringify(data);
                },
                error:function (data) {
                    returnValue = JSON.stringify(data);
                }
            });
            return returnValue;
        }
    </script>
</head>
<body>
<form:form action="" method="post" id="form">
    <!--//region your codes 2-->
    <input id="serialid" name="result.serialid" />
    <input id="frombank" name="result.frombank" />
    <input id="fkname" name="result.fkname" />
    <input id="skname" name="result.skname" />
    <input id="fkbankid" name="result.fkbankid" />
    <input id="skbankid" name="result.skbankid" />
    <input id="fkarea" name="result.fkarea" />
    <input id="skarea" name="result.skarea" />
    <input id="skpoint" name="result.skpoint" />
    <input id="jyqd" name="result.jyqd" />
    <input id="money" name="result.money" />
    <input id="fee" name="result.fee" />
    <input id="moneyflag" name="result.moneyflag" />
    <input id="messages" name="result.messages" />
    <input id="tradetime" name="result.tradetime" />
    <input id="tradestatus" name="result.tradestatus" />
    <input id="adddate" name="result.adddate" />
    <input id="rstateid" name="result.rstateid" />
    <input id="explain" name="result.explain" />
</form:form>
</body>
</html>

