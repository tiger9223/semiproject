<%@page import="com.hk.dtos.PostDto"%>
<%@page import="com.hk.util.Util"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">

// 	function allSel(ele){
// 		var chks=document.getElementsByName("chk");
// 		for(var i=0;i<chks.length;i++){
// 			chks[i].checked=ele;
// 		}
// 	}
	function allSel(ele){
// 		document.getElementsByTagName("input")[0].attr();
		//js객체를 jq로 변환할때는  $(jsObj) 로 작성해주면 해결 
// 		$(ele).attr("title","체크박스");
		$("input[name=chk]").prop("checked",$(ele).prop("checked"));
	}
	
	//js: 페이지로딩 이벤트 구현---> window.onload=function(){ 기능정의  }
	//jq:    ""           ---> $(document).ready(function(){기능정의})
	//                         $(function(){기능정의})
	$(function(){
		//document.getElementsByTagName("form")
		//이벤트메서드: change(), click(), mouseover()..... 
		//필터링메서드: eq(), find(), children(),
		//트리탐색메서드: next(), prev().....
		$("form").submit(function(){
			var bool=true;
			var count=$(this).find("input[name=chk]:checked").length;//체크된 input태그의 개수
			if(count==0){
				alert("최소하나이상 체크해야된다~~");
				bool=false;
			}
			return bool;
		});
		
		//내용 미리보기 ajax구현
		//hover() 메서드를 사용해서 마우스 커서가 올라갈때와 나갈때에 대한 이벤트 처리
		$("td>a").hover(function(){
			var seq=$(this).parent().prev().prev().text();//seq구함
// 			alert(seq);
			$.ajax({
				url:"ContentAjax.do",  //요청URL
// 				data:"seq="+seq,
				data:{"seq":seq} ,     //해당URL로 전송할 데이터
				dataType:"json",       //서버로부터 전달될 데이터 타입
				method:"post",         //데이터 전송방식
				success:function(obj){ //서버통신에 성공했다면 기능을 실행(obj:전달된 데이터를 저장)
// 					alert(obj);
				//서버에서 text로 받았을때 화면 처리
// 					$("#contentView").val(obj);

					//서버에서 json으로 받았을 때 화면 처리
					var dto=obj["dto"];
					$("#contentView").val(dto["content"]);
				},
				error:function(){      //서버통신에 실패했을 때 실행
					alert("서버통신실패!!");
				}
			});
		},function(){
			$("#contentView").val("");
		});
		
		
		//상세내용 보기
		//slice(s,e) : 엘리먼트를 인덱스를 활용해서 여러개를 추출할 수 있다.
		$("#detail").click(function(){
			$("th").slice(5, 8).toggle().end().slice(9).toggle();
// 			$("th").slice(9).toggle();
			$("tr").each(function(){
				$(this).children("td").slice(5,8).toggle().end().slice(9).toggle();
			});
//			alert($("th:hidden").length);
			$("tr").last().children("td").attr("colspan",$("th:visible").length);
		});
	});//onload
	
</script>
<%
	LoginDto ldto = (LoginDto)request.getAttribute("ldto");
	List<PostDto> list = (List<PostDto>)request.getAttribute("list");
	BoardDto bldto = (BoardDto)request.getAttribute("bdto");
%>
<style type="text/css">
	img{width: 12px; height: 12px;}
	
</style>
</head>
<body> 
<h1><%=bldto.getTitle()%> 목록보기</h1>
<textarea rows="2" cols="30" id="contentView"></textarea>
<button id="detail">상세정보</button>
<form action="PostController.do" method="post">
<input type="hidden" name="command" value="muldel" />
<table border="1">
	<col width="50px" />
	<col width="50px" />
	<col width="100px" />
	<col width="300px" />
	<col width="100px" />
	<col width="50px" />
	<col width="50px" />
	<tr>
		<th><input type="checkbox" name="all" onclick="allSel(this)"/></th>
		<th>번호</th>
		<th>작성자</th>
		<th>제 목</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<%if(list==null || list.size()==0){
	%>
	<tr>
		<td colspan="10">-----------------작성된 글이 없습니다-----------------</td>
	</tr> 
	<%
	}else{
		for(PostDto dto:list){
			%>
			<tr>
				<td><input type="checkbox" name="chk" value="<%=dto.getSeq()%>"/></td>
				<td><%=dto.getSeq() %></td>
				<td><%=dto.getId() %></td>
				<td>
				<%
				if(dto.getDelflag()==11){
					%>삭제된 글입니다.<%
				}else{
					%>
					<a href="PostController.do?command=boarddetail&seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a>
					<%
				}
				%>
				</td>
				<td><%=Util.getToDate(dto.getRegdate()) %></td>
				<td><%=dto.getReadcount() %></td>
			</tr>
			<%
		}
	}
	%>
	<tr>
		<td colspan="6">
			<input type="button" value="글추가" 
			       onclick="location.href='PostController.do?command=insertForm&listseq=<%=bldto.getSeq()%>'"/>
			<input type="submit" value="글삭제"/>       
		</td>
	</tr>
</table>
</form>
</body>
</html>