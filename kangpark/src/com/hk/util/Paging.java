package com.hk.util;

import java.util.HashMap;
import java.util.Map;

public class Paging {
	
	//pageEndNum : 페이지 그룹의 마지막 번호
	//prePageNum : 전페이지의 첫번호
	//nextPageNum : 다음페이지의 마지막 번호
	//startPage : 시작페이지 번호
	//endPage : 끝페이지 번호
	//pcount : 총페이지수
	//pNum : 현재 보여줄 페이지 번호
	//pageRange : 한번에 보여줄 페이지 범위
	
	public static Map<String, Integer> pagingValue(int pcount, String pNum, int pageRange) {
		Map<String, Integer> map = new HashMap<>();
		int pNumber = Integer.parseInt(pNum);
		//페이지들을 5개씩 페이징 처리를 위해
		//1234(5) 6789(10) : 페이지 번호를 받아 해당 페이지의 마지막 페이지 번호를 구함
		int pageEndNum = ((pNumber-1)/pageRange+1)==1 ? pageRange : (((pNumber-1)/pageRange+1)*pageRange);
		int prePageNum = pageEndNum-pageRange==0 ? 1 : pageEndNum-pageRange;
		int nextPageNum = pageEndNum>=pcount ? pcount : pageEndNum+1;
		int startPage = pageEndNum-(pageRange-1);
		int endPage = pageEndNum>pcount ? pcount : pageEndNum;
		
		map.put("prePageNum", prePageNum);
		map.put("nextPageNum", nextPageNum);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		return map;
	}
	
}
