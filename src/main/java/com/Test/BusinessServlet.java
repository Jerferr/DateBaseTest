package com.Test;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class BusinessServlet extends HttpServlet{

    public BusinessServlet(){
        super();
    }
    //设置JDBC连接相关常量
    static final String ConnContent = "jdbc:sqlserver://182.92.211.169:1433;databaseName=BankDB;user=U1;password=0";
    static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    protected void doPost(HttpServletRequest request, HttpServletResponse response){
        Connection connection;
        ResultSet resultSet;
        String tradeType = request.getParameter("tradeType");
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");

        try{
            Class.forName(DB_DRIVER);
            connection = DriverManager.getConnection(ConnContent);

            switch (tradeType) {
                case "save": {
                    double saveBLA;
                    String tradeDate;
                    long serialNum = System.currentTimeMillis();

                    saveBLA = Double.parseDouble(request.getParameter("saveBla"));
                    tradeDate = request.getParameter("tradeDate");

                    //查询账户类型，定期存款不能存取
                    try {
                        String SQL0 = "select ATYPE from BankDB.dbo.Accounts where ID = ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL0);
                        preparedStatement.setInt(1, Integer.parseInt(userName));
                        resultSet = preparedStatement.executeQuery();

                        while (resultSet.next()) {
                            int accountType = resultSet.getInt("ATYPE");
                            if (accountType != 1) {
                                session.setAttribute("pageId", "guest");
                                session.setAttribute("message", "账户类型不支持此业务！");
                                response.sendRedirect("/Failed.jsp");
                                return;
                            }
                        }
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //更新账户，添加存款数目
                    try {
                        String SQL1 = "update BankDB.dbo.Accounts set BLA = BLA + ? where ID = ?;";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL1);
                        preparedStatement.setDouble(1, saveBLA);
                        preparedStatement.setInt(2, Integer.parseInt(userName));
                        preparedStatement.executeUpdate();
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //添加交易记录
                    try {
                        String SQL2 = "insert into BankDB.dbo.Trades (SNUM, ID, TIME, TTYPE, SUM, SOUR)" +
                                "values(?,?,?,?,?,?);";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL2);
                        preparedStatement.setLong(1, serialNum);
                        preparedStatement.setInt(2, Integer.parseInt(userName));
                        preparedStatement.setString(3, tradeDate);
                        preparedStatement.setInt(4, 1);
                        preparedStatement.setDouble(5, saveBLA);
                        preparedStatement.setInt(6, 1);
                        preparedStatement.executeUpdate();
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //重定向至成功页面
                    session.setAttribute("pageId", "guest");
                    response.sendRedirect("/Success.jsp");
                    return;

                }
                case "withdraw": {
                    double withdrawBLA;
                    String tradeDate;
                    long serialNum = System.currentTimeMillis();

                    withdrawBLA = Double.parseDouble(request.getParameter("withdrawBla"));
                    tradeDate = request.getParameter("tradeDate");

                    //查询账户类型，定期存款不能存取
                    try {
                        String SQL0 = "select ATYPE from BankDB.dbo.Accounts where ID = ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL0);
                        preparedStatement.setInt(1, Integer.parseInt(userName));
                        resultSet = preparedStatement.executeQuery();

                        while (resultSet.next()) {
                            int accountType = resultSet.getInt("ATYPE");
                            if (accountType != 1) {
                                session.setAttribute("pageId", "guest");
                                session.setAttribute("message", "账户类型不支持此业务！");
                                response.sendRedirect("/Failed.jsp");
                                return;
                            }
                        }
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //查询余额，保证存款可以顺利进行
                    try {
                        String SQL1 = "select BLA from BankDB.dbo.Accounts where ID = ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL1);
                        preparedStatement.setInt(1, Integer.parseInt(userName));
                        resultSet = preparedStatement.executeQuery();

                        while (resultSet.next()) {
                            double curBLA = resultSet.getDouble("BLA");
                            System.out.println(curBLA);
                            if (withdrawBLA > curBLA) {
                                session.setAttribute("pageId", "guest");
                                session.setAttribute("message", "取款金额大于账户余额！");
                                response.sendRedirect("/Failed.jsp");
                                return;
                            } else if (curBLA == 0) {
                                session.setAttribute("pageId", "guest");
                                session.setAttribute("message", "账户中余额为0！");
                                response.sendRedirect("/Failed.jsp");
                                return;
                            }
                        }
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //更新账户，扣除取款数目
                    try {
                        String SQL2 = "update BankDB.dbo.Accounts set BLA = BLA - ? where ID = ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL2);
                        preparedStatement.setDouble(1, withdrawBLA);
                        preparedStatement.setInt(2, Integer.parseInt(userName));
                        preparedStatement.executeUpdate();
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //添加交易记录
                    try {
                        String SQL3 = "insert into BankDB.dbo.Trades (snum, id, time, ttype, sum, sour)" +
                                "values (?,?,?,?,?,?)";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL3);
                        preparedStatement.setLong(1, serialNum);
                        preparedStatement.setInt(2, Integer.parseInt(userName));
                        preparedStatement.setString(3, tradeDate);
                        preparedStatement.setInt(4, 2);
                        preparedStatement.setDouble(5, withdrawBLA);
                        preparedStatement.setInt(6, 1);
                        preparedStatement.executeUpdate();
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //重定向至成功页面
                    session.setAttribute("pageId", "guest");
                    response.sendRedirect("/Success.jsp");
                    return;

                }
                case "querybalance":
                    double balance = -1;
                    try {
                        String SQL1 = "select BLA from BankDB.dbo.Accounts where ID = ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL1);
                        preparedStatement.setInt(1, Integer.parseInt(userName));
                        resultSet = preparedStatement.executeQuery();

                        while (resultSet.next()) {
                            balance = resultSet.getDouble("BLA");
                        }
                        session.setAttribute("pageId", "guest");
                        session.setAttribute("userBla", balance);
                        response.sendRedirect("/Result.jsp");
                        return;
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    break;
                case "querytrade":
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");

                    //查询存入交易
                    try {
                        String SQL1 = "select SNUM, ID, TIME, TTYPE, SOUR, SUM from BankDB.dbo.Trades where ID = ? and TIME >= ? and TIME <= ? and TTYPE = 1 order by TIME;";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL1);
                        preparedStatement.setInt(1, Integer.parseInt(userName));
                        preparedStatement.setString(2, startDate);
                        preparedStatement.setString(3, endDate);
                        resultSet = preparedStatement.executeQuery();

                        //resultSet.last();
                        int cnt;//= resultSet.getRow();
                        TradeResult[] saveResult = new TradeResult[200];
                        for (int i = 0; i < 200; i++) {
                            saveResult[i] = new TradeResult();
                            saveResult[i].sum = 0;
                            saveResult[i].tradeSource = 0;
                            saveResult[i].tradeDate = " ";
                            saveResult[i].tradeType = 0;
                            saveResult[i].serialNum = 0;
                            saveResult[i].userID = 0;
                        }
                        //resultSet.first();
                        cnt = 0;
                        double totalIncome = 0;

                        long snum;
                        double s;
                        int id;
                        int tt;
                        String t;
                        int sour;

                        while (resultSet.next()) {
                            snum = resultSet.getLong("SNUM");
                            s = resultSet.getDouble("SUM");
                            id = resultSet.getInt("ID");
                            tt = resultSet.getInt("TTYPE");
                            t = resultSet.getString("TIME");
                            sour = resultSet.getInt("SOUR");
                            System.out.println(snum + " " + s + " " + id + " " + tt + " " + t + " " + sour);

                            saveResult[cnt].serialNum = snum;
                            saveResult[cnt].sum = s;
                            saveResult[cnt].userID = id;
                            saveResult[cnt].tradeType = tt;
                            saveResult[cnt].tradeDate = t;
                            saveResult[cnt].tradeSource = sour;
                            totalIncome += s;
                            cnt++;
                        }

                        session.setAttribute("saveResult", saveResult);
                        session.setAttribute("totalIncome", totalIncome);
                        session.setAttribute("saveItemNum", cnt);
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //查询取款
                    try {
                        String SQL2 = "select * from BankDB.dbo.Trades where ID = ? and TIME >= ? and TIME <= ? and TTYPE = 2 order by TIME;";
                        PreparedStatement preparedStatement = connection.prepareStatement(SQL2);
                        preparedStatement.setInt(1, Integer.parseInt(userName));
                        preparedStatement.setString(2, startDate);
                        preparedStatement.setString(3, endDate);
                        resultSet = preparedStatement.executeQuery();

                        //resultSet.last();
                        int cnt;//= resultSet.getRow();
                        TradeResult[] withdrawResult = new TradeResult[200];
                        //resultSet.first();
                        cnt = 0;
                        double totalExpenditure = 0;
                        for (int i = 0; i < 200; i++) {
                            withdrawResult[i] = new TradeResult();
                            withdrawResult[i].sum = 0;
                            withdrawResult[i].tradeSource = 0;
                            withdrawResult[i].tradeDate = " ";
                            withdrawResult[i].tradeType = 0;
                            withdrawResult[i].serialNum = 0;
                            withdrawResult[i].userID = 0;
                        }

                        while (resultSet.next()) {
                            withdrawResult[cnt].setSerialNum(resultSet.getLong("SNUM"));
                            withdrawResult[cnt].setSum(resultSet.getDouble("SUM"));
                            withdrawResult[cnt].setUserID(resultSet.getInt("ID"));
                            withdrawResult[cnt].setTradeType(resultSet.getInt("TTYPE"));
                            withdrawResult[cnt].setTradeDate(resultSet.getString("TIME"));
                            withdrawResult[cnt].setTradeSource(resultSet.getInt("SOUR"));
                            totalExpenditure += withdrawResult[cnt].getSum();
                            cnt++;
                        }

                        session.setAttribute("withdrawResult", withdrawResult);
                        session.setAttribute("totalExpenditure", totalExpenditure);
                        session.setAttribute("withdrawItemNum", cnt);

                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    }

                    //重定向至结果页面
                    session.setAttribute("pageId", "guest");
                    response.sendRedirect("/TradeResult.jsp");
                    return;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
