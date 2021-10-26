<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.Test.TradeResult" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Result Page</title>
</head>
<%
    String pageId = (String) session.getAttribute("pageId");

    TradeResult[] saveResult = new TradeResult[200];
    TradeResult[] withdrawResult = new TradeResult[200];
    for(int i = 0; i < 200; i++){
        saveResult[i] = new TradeResult();
        withdrawResult[i] = new TradeResult();
    }
    saveResult = (TradeResult[]) session.getAttribute("saveResult");
    withdrawResult = (TradeResult[]) session.getAttribute("withdrawResult");

    double totalIncome = (double) session.getAttribute("totalIncome");
    double totalExpenditure = (double) session.getAttribute("totalExpenditure");

    int saveItemNum = (int) session.getAttribute("saveItemNum");
    int withdrawItemNum = (int) session.getAttribute("withdrawItemNum");

    DecimalFormat df = new DecimalFormat("0.00");
%>
<body>
<h1>存款记录如下：</h1><br>
<table>
    <tr><td>
        流水号
    </td>
        <td>
            交易日期
        </td>
        <td>
            交易金额
        </td>
    </tr>
    <%for (int i = 0; i < saveItemNum; i ++) {%>
    <tr>
        <td><%= saveResult[i].getSerialNum()%>
        </td>
        <td><%= saveResult[i].getTradeDate()%>
        </td>
        <td><%= df.format(saveResult[i].getSum())%> CNY</td>
    </tr>
    <%}%>
</table><br>
<h1>取款记录如下：</h1><br>
<table>
    <tr><td>
            流水号
        </td>
        <td>
            交易日期
        </td>
        <td>
            交易金额
        </td>
    </tr>
    <%for (int i = 0; i < withdrawItemNum; i ++) {%>
    <tr>
        <td><%= withdrawResult[i].getSerialNum()%>
        </td>
        <td><%= withdrawResult[i].getTradeDate()%>
        </td>
        <td><%= df.format(withdrawResult[i].getSum())%> CNY</td>
    </tr>
    <%}%>
</table><br>
<h1>总收支如下：</h1>
<table>
    <tr>
        <td>
            总收入
        </td>
        <td>
            <%= df.format(totalIncome)%> CNY
        </td>
    </tr>
    <tr>
        <td>
            总支出
        </td>
        <td>
            <%= df.format(totalExpenditure)%> CNY
        </td>
    </tr>
</table>
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
