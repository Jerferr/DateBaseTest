<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Welcome!</title>
    <style>
        #all_light{
            opacity: 70%;
            width: 100%;
            height: 2300px;
            background: #000;
            position: absolute;
            top: 0;
            left: 0;
            display: none;
            z-index: 2;
        }
        #contents{
            width: 500px;
            height: 500px;
            background: #fff;
            display: none;
            z-index: 3;
            position: absolute;
            top: 100px;
            left: 400px;
        }
        #withdraw{
             width: 500px;
             height: 500px;
             background: #fff;
             display: none;
             z-index: 3;
             position: absolute;
             top: 100px;
             left: 400px;
         }
        #querybalance{
            width: 500px;
            height: 500px;
            background: #fff;
            display: none;
            z-index: 3;
            position: absolute;
            top: 100px;
            left: 400px;
        }
        #querytrade{
            width: 500px;
            height: 500px;
            background: #fff;
            display: none;
            z-index: 3;
            position: absolute;
            top: 100px;
            left: 400px;
        }
        input{
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    选择业务类型：<br>
    <label>
        <input type="radio" name="tradetype" value="save">
    </label>存款<br>
    <label>
        <input type="radio" name="tradetype" value="withdraw">
    </label>取款<br>
    <label>
        <input type="radio" name="tradetype" value="querybalance">
    </label>查询余额<br>
    <label>
        <input type="radio" name="tradetype" value="querytrade">
    </label>查询记录<br>
        <input type="button" onclick="buttonClick()" value="确认">

    <div id="contents" style="">
        <div style="width: 500px;height: 40px;">
            <p style="margin-left: 100px;">输入信息：</p>
            <hr>
            <form action="${pageContext.request.contextPath}/Guest" method="post" style="margin-left: 100px;" onsubmit="return checkSave(this);">
                <label>
                    <input type="text" hidden name="tradeType" value="save">
                </label>
                存款金额:<label>
                <input name="saveBla" type="text">
            </label><br>
                存款日期:<label>
                <input name="tradeDate" type="text">
            </label><br>
                <input type="submit" value="确认">
            </form>
            <input type="button" onclick="cancelButton()" value="取消" style="margin-left: 100px;">
        </div>
    </div>

    <div id="withdraw" style="">
        <div style="width: 500px;height: 40px;">
            <p style="margin-left: 100px;">输入信息：</p>
            <hr>
            <form action="${pageContext.request.contextPath}/Guest" method="post" style="margin-left: 100px;" onsubmit="return checkWithdraw(this);">
                <label>
                    <input type="text" hidden name="tradeType" value="withdraw">
                </label>
                取款金额:<label>
                <input name="withdrawBla" type="text">
            </label><br>
                取款日期:<label>
                <input name="tradeDate" type="text">
            </label><br>
                <input type="submit" value="确认">
            </form>
            <input type="button" onclick="cancelButton()" value="取消" style="margin-left: 100px;">
        </div>
    </div>

    <div id="querybalance" style="">
        <div style="width: 500px;height: 40px;">
            <p style="margin-left: 100px;">输入信息：</p>
            <hr>
            <form action="${pageContext.request.contextPath}/Guest" method="post" style="margin-left: 100px;">
                <label>
                    <input type="text" hidden name="tradeType" value="querybalance">
                </label>
                是否查询？<br>
                <input type="submit" value="确认">
            </form>
            <input type="button" onclick="cancelButton()" value="取消" style="margin-left: 100px;">
        </div>
    </div>

    <div id="querytrade" style="">
        <div style="width: 500px;height: 40px;">
            <p style="margin-left: 100px;">输入信息：</p>
            <hr>
            <form action="${pageContext.request.contextPath}/Guest" method="post" style="margin-left: 100px;" onsubmit="return checkQueryTrade(this);">
                <label>
                    <input type="text" hidden name="tradeType" value="querytrade">
                </label>
                起始日期:<label>
                <input name="startDate" type="text">
            </label><br>
                终止日期:<label>
                <input name="endDate" type="text">
            </label><br>
                <input type="submit" value="确认">
            </form>
            <input type="button" onclick="cancelButton()" value="取消" style="margin-left: 100px;">
        </div>
    </div>

    <div id="all_light">
    </div>
    <input type="button" value="退出登录" onclick="logOut()">

</body>
<script>
    function buttonClick(){
        let testObj = document.getElementsByName("tradetype");
        for(let i = 0; i < testObj.length; i ++) {
            if (testObj[i].checked) {
                if(testObj[i].value === "save"){
                    document.getElementById("contents").style.display = "block";
                    document.getElementById("all_light").style.display = "block";
                    return;
                }else if(testObj[i].value === "withdraw"){
                    document.getElementById("all_light").style.display = "block";
                    document.getElementById("withdraw").style.display = "block";
                    return;
                }else if(testObj[i].value === "querybalance"){
                    document.getElementById("all_light").style.display = "block";
                    document.getElementById("querybalance").style.display = "block";
                    return;
                }else if(testObj[i].value === "querytrade"){
                    document.getElementById("all_light").style.display = "block";
                    document.getElementById("querytrade").style.display = "block";
                    return;
                }else {
                    return;
                }
            }
        }
    }
    function cancelButton(){
        let testObj = document.getElementsByName("tradetype");
        for(let i = 0; i < testObj.length; i ++) {
            if (testObj[i].checked) {
                if(testObj[i].value === "save"){
                    document.getElementById("contents").style.display = "none";
                    document.getElementById("all_light").style.display = "none";
                    return;
                }else if(testObj[i].value === "withdraw"){
                    document.getElementById("all_light").style.display = "none";
                    document.getElementById("withdraw").style.display = "none";
                    return;
                }else if(testObj[i].value === "querybalance"){
                    document.getElementById("all_light").style.display = "none";
                    document.getElementById("querybalance").style.display = "none";
                    return;
                }else if(testObj[i].value === "querytrade"){
                    document.getElementById("all_light").style.display = "none";
                    document.getElementById("querytrade").style.display = "none";
                    return;
                }else {
                    return;
                }
            }
        }
    }

    function checkSave(form){
        let re = /^[+-]?(0|([1-9]\d*))(\.\d+)?$/;
        let DateRe = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

        if(form.saveBla.value === ""){
            alert("存款金额不能为空！");
            form.saveBla.focus();
            return false;
        } else if(form.saveBla.value <= 0.0){
            alert("存款金额不能小于或等于0！");
            form.saveBla.focus();
            return false;
        } else if(form.tradeDate.value === ""){
            alert("存款日期不能为空！");
            form.tradeDate.focus();
            return false;
        } else if(!re.test(form.saveBla.value)){
            alert("请在金额处输入数字！");
            form.saveBla.focus();
            return false;
        }else if(!DateRe.test(form.tradeDate.value)){
            alert("存款日期格式错误！");
            form.tradeDate.focus();
            return false;
        }else {
            return true;
        }
    }

    function checkWithdraw(form){
        let re = /^[+-]?(0|([1-9]\d*))(\.\d+)?$/;
        let DateRe = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

        if(form.withdrawBla.value === ""){
            alert("取款金额不能为空！");
            form.withdrawBla.focus();
            return false;
        }else if(form.withdrawBla.value <= 0.0){
            alert("取款金额不能小于或等于0！");
            form.withdrawBla.focus();
            return false;
        }else if(form.tradeDate.value === ""){
            alert("取款日期不能为空！");
            form.tradeDate.focus();
            return false;
        }else if(!re.test(form.withdrawBla.value)){
            alert("请在金额处输入数字！");
            form.withdrawBla.focus();
            return false;
        }else if(!DateRe.test(form.tradeDate.value)){
            alert("取款日期格式错误！");
            form.tradeDate.focus();
            return false;
        }else {
            return true;
        }
    }

    function checkQueryTrade(form){
        let DateRe = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

        if(form.startDate.value === ""){
            alert("起始日期不能为空！");
            form.startDate.focus();
            return false;
        }else if(form.endDate.value === ""){
            alert("终止日期不能为空！");
            form.endDate.focus();
            return false;
        }else if(!DateRe.test(form.startDate.value) || !DateRe.test(form.endDate.value)){
            alert("日期格式不正确！");
            return false;
        }else {
            return true;
        }
    }

    function logOut(){
        window.location.href = "/BankHome.jsp";
    }
</script>
</html>
