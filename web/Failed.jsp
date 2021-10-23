<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String mes = (String) session.getAttribute("message");
%>
<head>
    <title>Failed Page</title>
</head>
<body>
<h1><%
    PrintWriter printWriter = response.getWriter();
    printWriter.println(mes);
%></h1>
<h2>5秒后返回业务页面</h2>
<script>setTimeout(function (){window.location.href="/Guest.jsp";},5000);</script>
</body>
</html>
