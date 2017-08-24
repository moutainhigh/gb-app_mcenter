<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/include.inc.jsp" %>
<div class="lot_two_menu">
    <a name="playcode" href="javascript:void(0)" type="one">${views.lottery_auto['一字']}</a>
    <a name="playcode" href="javascript:void(0)" type="two">${views.lottery_auto['二字']}</a>
    <a name="playcode" href="javascript:void(0)" type="three">${views.lottery_auto['三字']}</a>
    <a name="playcode" href="javascript:void(0)" type="lhh">${views.lottery_auto['总合/龙虎和']}</a>
    <a name="playcode"　href="javascript:void(0)" type="group">组选</a>
    <a name="playcode"　href="javascript:void(0)" type="span">跨度</a>
    <a name="playcode"　href="javascript:void(0)" type="dragonTiger">龙虎</a>
    <%--<span class="hide" id="showbatchupdate">
        <input type="number" name="defalutValue" id="defaultValue">
        <soul:button cssClass="batch-update-value" target="batchUpdateValue" text="${views.lottery_auto['批量调整']}" opType="function" tag="button"></soul:button>
    </span>--%>


</div>


<script>
    $(function () {
        $(".lot_two_menu [name='playcode']").click(function (e) {
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
            var type = $(this).attr("type");
            /*if(type=='two' || type=='three'){
                $("#showbatchupdate").removeClass("hide");
            }else{
                $("#showbatchupdate").addClass("hide");
            }*/
            //获取时时彩类别列表
            $("#lot_three_menu").load(root+'/lottery/odds/${code}/'+type+'/categoryIndex.html');
            $("#lot_three_menu").show();
        });

        if(!$(".lot_two_menu [name='playcode']").hasClass('active')){
            $(".lot_two_menu [name='playcode']").eq(0).trigger("click");
        }

        $("#defaultValue").on("blur",function (e) {
            var val = this.value;
            if(!isNaN(val)){
                if(parseFloat(val)<=0){
                    page.showPopover(e,{},"danger",window.top.message.player_auto['请输入大于0的正数'],true);

                }
            }else{
                page.showPopover(e,{},"danger",window.top.message.player_auto['请输入数字'],true);
            }
        });
    });
</script>