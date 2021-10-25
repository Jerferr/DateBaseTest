<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Success Page</title>
    <%
        String pageId = (String) session.getAttribute("pageId");
    %>
</head>
<body>
<h1 style="margin-left: auto">成功！</h1>
<input type="button" value="返回业务页面" onclick="returnPage()">
</body>
<script>
    function returnPage(){
        if(<%= pageId.equals("admin")%>){
            window.location.href = "/Admin.jsp";
        }else {
            window.location.href = "/Guest.jsp";
        }
    }
</script>
</html>
