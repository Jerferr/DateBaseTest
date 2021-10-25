<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<%
    String mes = (String) session.getAttribute("message");
    String pageId = (String) session.getAttribute("pageId");
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
<script>
    if(<%= pageId.equals("admin")%>){
        setTimeout(function (){window.location.href="/Admin.jsp";}, 5000);
    }else {
        setTimeout(function (){window.location.href="/Guest.jsp";},5000);
    }
</script>
</body>
</html>
