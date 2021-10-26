<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>QueryResult Page</title>
</head>
<body>
<%
    String pageId = (String) session.getAttribute("pageId");

    DecimalFormat df = new DecimalFormat("0.00");
    double curBla = (double) session.getAttribute("userBla");
%>
<h1>您的账户余额为：</h1><br>
<p><%= df.format(curBla)+" CNY"%></p>
<input type="button" value="返回业务页面" onclick="returnPage()">
</body>
<script>
    function returnPage(){
        if(<%= pageId.equals("admin")%>){
            window.location.href = "${pageContext.request.contextPath}/Admin.jsp";
        }else {
            window.location.href = "${pageContext.request.contextPath}/Guest.jsp";
        }
    }
</script>
</html>
