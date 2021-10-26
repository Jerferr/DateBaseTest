package com.Test;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

//ClientServlet 负责处理客户页面提交的请求
public class ClientServlet extends HttpServlet {
    public ClientServlet(){
        super();
    }
    static final String ConnContent = "jdbc:sqlserver://182.92.211.169:1433;databaseName=BankDB;user=U1;password=0";
    static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException{
        Connection connection;
        ResultSet resultSet;
        response.setContentType("text/html;charset=GBK");
// 确认身份
        String userType = request.getParameter("usertype");
        String userName = request.getParameter("username");
        String password = request.getParameter("pwd");
        if(userType.equals("admin")){
            if(userName.equals("admin") && password.equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/Admin.jsp");
                return;
            }else {
                response.sendRedirect(request.getContextPath() + "/TypeError.jsp");
                return;
            }
        }
        try{
            Class.forName(DB_DRIVER);

            connection = DriverManager.getConnection(ConnContent);
            String SQL = "select PWD from BankDB.dbo.Accounts where ID =?";
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setInt(1, Integer.parseInt(userName));
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next()){
                int curPWD =  resultSet.getInt("PWD");
                if(password.equals(Integer.toString(curPWD))){
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userName", userName);
                    response.sendRedirect(request.getContextPath() + "/Guest.jsp");
                    return;
                }else {
                    response.sendRedirect(request.getContextPath() + "/Error.jsp");
                    return;
                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException{
        doPost(request, response);
    }
}
