<%--
  Created by IntelliJ IDEA.
  User: jerfe
  Date: 2021/10/21
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UserTypeError Page</title>
</head>
<body>
<h1 style="margin-left: auto">用户类型选择错误！请返回重新选择，5秒后自动返回登录页面</h1>
<script>setTimeout(function (){window.location.href="/BankHome.jsp";},5000);</script>
</body>
</html>
