<%@ include file="include.base.js.jsp" %>
<script>
    var isTempDomain =<%=SessionManagerCommon.getSiteDomain(request).getIsTemp()%>;
</script>
<script type="text/javascript">
    curl(['gb/components/select'], function (Page) {
        select = new Page();
    });
    curl(['zeroClipboard', 'UE', 'clipboard'], function (zeroClipboard, UE, Clipboard) {
        window.ZeroClipboard = zeroClipboard;
        window.UE = UE;
        window.clipboard = Clipboard;
    });
</script>