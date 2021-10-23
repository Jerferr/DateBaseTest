package com.Test;

public class TradeResult {
    String tradeDate;
    int tradeType;
    int userID;
    long serialNum;
    double sum;
    int tradeSource;

    public TradeResult() {
        tradeType = 0;
        userID = 0;
        serialNum = 0;
        sum = 0;
        tradeDate = "0000-00-00";
        tradeSource = 0;
    }

    public void setTradeDate(String td) {
        tradeDate = td;
    }
    public void setUserID(int id) {
        userID = id;
    }
    public void setSerialNum(long sn) {
        serialNum = sn;
    }
    public void setSum(double s) {
        sum = s;
    }
    public void setTradeType(int tt) {
        tradeType = tt;
    }
    public void setTradeSource(int ts) {
        tradeSource = ts;
    }
    public double getSum() {
        return this.sum;
    }
    public int getTradeSource(){return this.tradeSource;}
    public int getTradeType(){return this.tradeType;}
    public String getTradeDate(){return this.tradeDate;}
    public int getUserID(){return this.userID;}
    public long getSerialNum(){return this.serialNum;}
}
