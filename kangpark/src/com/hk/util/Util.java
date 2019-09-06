package com.hk.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Util {

	public static String getToDate(Date regDate){
		String r = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		r = sdf.format(regDate);
		return r;
	}
}
