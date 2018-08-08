<!--k15전아현 / 2018.07.19.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- utf-8로 웹에서 출력되도록 언어 설정 --%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<HTML>
<HEAD>
<title>*후보등록</title>
<%-- 탭에 출력되는 제목 설정 --%>
</HEAD>
<BODY>
<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td width=200 align=center bgcolor=yellow><a href="A_01_H.jsp"><font size=4>후보등록</font></a></td>
<td width=200 align=center><a href="B_01_H.jsp"><font size=4>투표</font></a></td>
<td width=200 align=center><a href="C_01_H.jsp"><font size=4>개표결과</font></a></td></tr>
<%-- 현재 접속한 메뉴의 배경 색이 노란색이 되도록 bgcolor 설정 / <a> 태그 활용하여 각 메뉴에 접속 가능하도록 설정 --%>
</table>

<h1>후보등록</h1>
<br><br>
<table border=1 width=600 cellspacing=0 width=600 border=1>
<tr><td><p align=center>후보명 입력</p></td></tr>
<tr><td>
<form method="post" action="A_02_H.jsp">
<%-- post 방식 : html 페이지에 form 형태에서 값을 전달 / A_02_H.jsp 페이지에서 실행 --%>
기호 : <input type="text" name="id" value="1" readonly>
<%-- text 형식으로 값을 입력하며 받는 값의 이름을 id로 설정하고 그 값을 1로 설정 / 입력 불가능(read only) --%>
이름 : <input type="text" name="name" value="김일동" readonly>
<%-- text 형식으로 값을 입력하며 받는 값의 이름을 name으로 설정하고 그 값을 김일동으로 설정 / 입력 불가능(read only) --%>
<input type="submit" value="삭제">
<%-- '삭제' 버튼을 클릭하면 실행되도록 설정 --%>
</tr></td>
<tr><td>
<form method="post" action="A_02_H.jsp">
기호 : <input type="text" name="id" value="2" readonly>
이름 : <input type="text" name="name" value="김이동" readonly>
<input type="submit" value="삭제">
</tr></td>
<tr><td>
<form method="post" action="A_02_H.jsp">
기호 : <input type="text" name="id" value="3" readonly>
이름 : <input type="text" name="name" value="김삼동" readonly>
<input type="submit" value="삭제">
</tr></td>
<tr><td>
<form method="post" action="A_02_H.jsp">
기호 : <input type="text" name="id" value="4" readonly>
이름 : <input type="text" name="name" value="김사동" readonly>
<input type="submit" value="삭제">
</tr></td>
<tr><td>
<form method="post" action="A_03_H.jsp">
<%-- post 방식 : html 페이지에 form 형태에서 값을 전달 / A_03_H.jsp 페이지에서 실행 --%>
기호 : <input type="text" name="id" value="" readonly>
이름 : <input type="text" name="name" value="" readonly>
<input type="submit" value="추가">
<%-- '추가' 버튼을 클릭하면 실행되도록 설정 --%>
</tr></td>
</table>
</BODY>
</HTML>
