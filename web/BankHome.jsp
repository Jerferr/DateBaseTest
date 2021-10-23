<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello</title>
</head>
<body>
    选择登录身份
    <form name="form" method="post" action="/Client" onsubmit="return checkEmpty(this);">
        <input type="radio" name="usertype" value="admin">柜员<br>
        <input type="radio" name="usertype" value="guest">客户<br>
        请输入账号及密码：<br>
        账号：<input type="text" name="username"><br>
        密码：<input type="password" name="pwd"><br>
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
