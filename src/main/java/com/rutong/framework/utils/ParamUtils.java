package com.rutong.framework.utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ParamUtils {

    public static String getParameterNo(String lastNumberNo) {
        DecimalFormat df = new DecimalFormat("000");
        SimpleDateFormat sdfMonth = new SimpleDateFormat("yyyyMMdd");
        String strLastMonth = lastNumberNo.substring(2, 10);
        String strLastNo = lastNumberNo.substring(10);
        String strNowNo = df.format(Integer.parseInt(strLastNo) + 1);
        Calendar cal = Calendar.getInstance(); // 使用默认时区和语言环境获得一个日历。
        String strNowMonth = sdfMonth.format(cal.getTime());
        if (!strNowMonth.equals(strLastMonth)) {
            strNowNo = "001";
        }
        String no = lastNumberNo.substring(0, 2) + sdfMonth.format(cal.getTime()) + strNowNo;
        return no;
    }


}
