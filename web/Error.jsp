<%--
  Created by IntelliJ IDEA.
  User: jerfe
  Date: 2021/10/21
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error Page</title>
</head>
<body>
<h1 style="margin-left: auto">账户名或密码错误，5秒后返回登录页面</h1>
<script>setTimeout(function (){window.location.href="/BankHome.jsp";},5000);</script>
</body>
</html>
