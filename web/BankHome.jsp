<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Hello</title>
</head>
<body>
    选择登录身份
    <form name="form" method="post" action="${pageContext.request.contextPath}/Client" onsubmit="return checkEmpty(this);">
        <label>
            <input type="radio" name="usertype" value="admin">
        </label>柜员<br>
        <label>
            <input type="radio" name="usertype" value="guest">
        </label>客户<br>
        请输入账号及密码：<br>
        账号：<label>
        <input type="text" name="username">
    </label><br>
        密码：<label>
        <input type="password" name="pwd">
    </label><br>
        <input type="submit" value="确定">
    </form>
</body>
<script>
    function checkEmpty(form){
        if(form.usertype.value === ""){
            alert("请选择用户类型");
            return false;
        }else if(form.username.value === ""){
            alert("请填写用户名");
            form.username.focus();
            return false;
        }else if(form.pwd.value === ""){
            alert("请填写密码");
            form.pwd.focus();
            return false;
        }else {
            return true;
        }
    }
</script>
</html>
