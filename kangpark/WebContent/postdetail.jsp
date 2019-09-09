<%@page import="com.hk.dtos.PostDto"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	/*  selector표현식의 대표적인 표현식3가지: id,> class,> tagName
		class="a"  ---> .a   (같은이름을 중복해서 선언할 수 있다.)
		id="b"     ---> #b   (같은 이름 중복을 선언할 수 없다.)
	*/
	#replyForm{display: none;}
	#container{
		height: 400px;
		width: 800px;
		border: 1px solid red;
		overflow: auto;
	}

</style>
<script type="text/javascript">
	
</script>
</head>
<body>
<%
 	PostDto pdto = (PostDto)request.getAttribute("pdto");
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	LoginDto dto = (LoginDto)request.getAttribute("dto");
%>
<jsp:include page="header.jsp"  />
<div id="container">
<h1>게시글상세보기</h1>
<table border="1">
	<tr>
		<th>번호</th>
		<td><%=pdto.getSeq() %></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=dto.getId()%></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><%=pdto.getTitle() %></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly"><%=pdto.getContent() %></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<button onclick="replyForm()">답글</button>
			<button onclick="updateForm(${dto.seq})">수정</button>
			<button onclick="delPost(${dto.seq})">삭제</button>
<%-- 			<button onclick="location.href='postcontroller.do?command=boardlist&boardseq=<%=%>'">글목록</button> --%>
		</td>
	</tr>
</table>
<div id="replyForm">
<h1>답글달기</h1>
<form action="PostController.do" method="post" >
<input type="hidden" name="command" value="replyPost"/>
<input type="hidden" name="seq" value="${dto.seq}"/>
<table border="1">
	<tr>
		<th>아이디</th>
		<td><input type="text" name="id" class="inputval"/></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" class="inputval"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content" class="inputval"></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="답글등록"/>
			<input type="button" value="목록" 
			          onclick="location.herf='PostController.do?command=PostList'"/>
		</td>
	</tr>
</table>
</form>
</div>
</div>
<script type="text/javascript">
	function replyForm(){
// 		$("#replyForm").css("display","block");
// 		$("#replyForm").toggle();
		$("#replyForm").show();
		var replyPosition=$("#replyForm").offset().top;//div태그의 상단 위치를 구함
		$("#container").animate({
			"scrollTop":replyPosition
		},1000);
		//animate({css속성값정의},지연시간,easing)
	}
	function updateForm(seq){
		location.href="PostController.do?command=UpdatePost&seq="+seq;
	}
	function delPost(seq){
		location.href="PostController.do?command=muldel&chk="+seq;
	}
</script>
</body>
</html>









