<%@page import="com.hk.util.Util"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="com.hk.dtos.PostDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%
	List<PostDto> list = (List<PostDto>)request.getAttribute("list");
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
%>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
	table {
    width: 80%;
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
 	 th {
    background-color: #ee82ee;
    }
    #header{
    display: table;
    margin-left: auto;
    margin-right: auto;
    }
</style>
</head>
<body>
<div id="header">
<h1><%=bdto.getTitle() %></h1>
</div>
<form action="HomeController.do" method="post">
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
				if(pdto.getDelflag()==1){
			%>
			<tr>
				<td><%=pdto.getSeq() %></td>
				<td><%=pdto.getId() %></td>
				<td>
					<%Util.setArrowNbsp(pdto.getDepth());%>
					<%=Util.getArrowNbsp()%>
					<a href="HomeController.do?command=noticedetail&PostSeq=<%=pdto.getSeq()%>&MemberSeq=<%=pdto.getMember_seq()%>"><%=pdto.getTitle()%></a>
					
				</td>
				
				<td><%=pdto.getCategory_title()%></td>

				<td><%=Util.getToDate(pdto.getRegdate()) %></td>
				<td><%=pdto.getReadcount()%></td>
			</tr>
			<%
			}
		}
	}
	%>
	<tr>
		<td colspan="6">
		<%if(!ldto.getRole().equals("USER")){
		%>
			<input type="button" value="글추가"
			       onclick="location.href='HomeController.do?command=InsertNoticeForm&boardseq=<%=bdto.getSeq()%>'"/>
			<% 
			}       
			%>
		
			<input type="button" value="돌아가기" 
			       onclick="location.href='LoginController.do?command=login&id=<%=ldto.getId()%>&password=<%=ldto.getPassword()%>'"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>