<%@ page contentType="text/html;charset=UTF-8"%>
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
            window.location.href = "${pageContext.request.contextPath}/Admin.jsp";
        }else {
            window.location.href = "${pageContext.request.contextPath}/Guest.jsp";
        }
    }
</script>
</html>
