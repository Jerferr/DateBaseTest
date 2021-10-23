package com.Test;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class HelloDBServlet extends HttpServlet{
    //Driver and DataBase_URL
    static final String ConnContent = "jdbc:sqlserver://182.92.211.169:1433;databaseName=SPJ;user=U1;password=0";

    public HelloDBServlet(){
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        Connection conn;
        Statement stat;
        response.setContentType("text/html;charset=GBK");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>\n" +
                "<html>\n" +
                "<head><title>" +
                "数据库连接测试" +
                "</title></head>" +
                "<body>\n" +
                "<h1 align=\"center\">" +
                "数据库连接测试" +
                "</h1>\n");
        try{
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(ConnContent);
            stat = conn.createStatement();
            String sql = "select * from P";
            ResultSet res = stat.executeQuery(sql);

            while(res.next()){
                String PNO = res.getString("PNO");
                String PNAME = res.getString("PNAME");
                String COLOR = res.getString("COLOR");
                int WEIGHT = res.getInt("WEIGHT");
                out.println("PNO:" + PNO);
                out.println("PNAME:" + PNAME);
                out.println("COLOR:" + COLOR);
                out.println("WEIGHT:" + WEIGHT);
                out.println("<br />");
            }
            out.println("</body></html>");

            res.close();
            stat.close();
            conn.close();
        } catch (Exception se){
            se.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        doPost(request, response);
    }
}
