<%@page import="com.hk.dtos.CategoryDto"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="com.hk.dtos.PostDto"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jqery-latest.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
	table {
    width: 40%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    display: table;
    margin-left: auto;
    margin-right: auto;
  	}
 	th,td{
    border-bottom: 1px solid #444444;
    padding: 10px;
 	 }
    #header{
    display: table;
    margin-left: auto;
    margin-right: auto;
    }
</style>
</head>
<body>
<%
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
	PostDto pdto = (PostDto)request.getAttribute("pdto");
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	LoginDto dto = (LoginDto)request.getAttribute("dto");
%>
<div id="container">
<div id="header">
<h1>게시글상세보기</h1>
</div>
<table border="1">
	<tr>
		<th>번호</th>
		<td><%=pdto.getSeq() %></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=pdto.getId()%></td>
	</tr>
	<tr>
		<th>제목</th>
		<td>[<%=pdto.getCategory_title() %>]&nbsp;<%=pdto.getTitle() %></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly"><%=pdto.getContent() %></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<%if(ldto.getId().equals(pdto.getId())){
				%>
			<button onclick="location.href = 'HomeController.do?command=noticeUpdateForm&PostSeq=<%=pdto.getSeq()%>&MemberSeq=<%=pdto.getMember_seq()%>'">수정</button>
			<button onclick="del(<%=pdto.getSeq()%>)">삭제</button>
			<% 
			}%>
			<button onclick="location.href='HomeController.do?command=notice&boardseq=<%=bdto.getSeq()%>'">글목록</button>
		</td>
	</tr>
</table>
</div>
</div>
<script type="text/javascript">
	function del(seq){
		if(confirm("삭제하시겠습니까?")==true){
			location.href = 'HomeController.do?command=noticedelete&PostSeq='+seq;
		}
	}
</script>
<%@include file="footer.jsp"%>
</body>
</html>