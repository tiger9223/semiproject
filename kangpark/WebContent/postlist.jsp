<%@page import="java.util.Map"%>
<%@page import="com.hk.dtos.CategoryDto"%>
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
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	List<PostDto> list = (List<PostDto>)request.getAttribute("list");
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
	Map<String, Integer> map = (Map<String, Integer>)request.getAttribute("pmap");
	//List<CategoryDto> clist = (List<CategoryDto>)request.getAttribute("clist");
%>
<style type="text/css">
	img{
	width: 12px;
	height: 12px;
	}
	table {
    width: 80%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  	}
 	th,td{
    border-bottom: 1px solid #444444;
    padding: 10px;
 	 }
</style>
</head>
<body> 
<div id="div">
<h1><%=bdto.getTitle()%></h1>
<form action="PostController.do" method="post">
<input type="hidden" name="command" value="muldel" />
<table border="1">
	<col width="50px" />
	<col width="100px" />
	<col width="300px" />
	<col width="70px" />
	<col width="100px" />
	<col width="50px" />
	<tr>
		<th>번호</th>
		<th>작성자</th>
		<th>제 목</th>
		<th>유형</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<%if(list==null || list.size()==0){
	%>
	<tr>
		<td colspan="6">-----------------작성된 글이 없습니다-----------------</td>
	</tr> 
	<%
	}else{
		for(PostDto pdto:list){
			%>
			<tr>
				<td><%=pdto.getSeq() %></td>
				<td><%=pdto.getId() %></td>
				<td>
				<%
				if(pdto.getDelflag()==0){
					%>삭제된 글입니다.<%
				}else{
					%>
					<%Util.setArrowNbsp(pdto.getDepth());%>
					<%=Util.getArrowNbsp()%>
					<a href="PostController.do?command=PostDetail&PostSeq=<%=pdto.getSeq()%>&MemberSeq=<%=pdto.getMember_seq()%>"><%=pdto.getTitle()%></a>
					<%
				}
				%>
				</td>
				
				<td><%=pdto.getCategory_title()%></td>

				<td><%=Util.getToDate(pdto.getRegdate()) %></td>
				<td><%=pdto.getReadcount()%></td>
			</tr>
			<%
		
		}
	}
	%>
	<tr>
		<td colspan="6">
			<input type="button" value="글추가"
			       onclick="location.href='PostController.do?command=InsertForm&boardseq=<%=bdto.getSeq()%>'"/>
			&nbsp;
			<input type="button" value="돌아가기" 
			       onclick="location.href='LoginController.do?command=login&id=<%=ldto.getId()%>&password=<%=ldto.getPassword()%>'"/>
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>