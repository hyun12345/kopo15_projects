<!--k15전아현 / 2018.07.19.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<HTML>
<HEAD>
<title>*투표</title>
</HEAD>
<BODY>
<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td height=50 width=200 align=center><a href="A_01_H.jsp"><font size=4>후보등록</font></a></td>
<td height=50 width=200 align=center bgcolor=yellow><a href="B_01_H.jsp"><font size=4>투표</font></a></td>
<td height=50 width=200 align=center><a href="C_01_H.jsp"><font size=4>개표결과</font></a></td></tr>
</table>

<h1>투표하기</h1>
<br>
<table border=1 width=600 cellspacing=0 cellpadding=5>
<tr><form method="post" action="B_02_H.jsp">
<%-- post 방식 : html 페이지에 form 형태에서 값을 전달 / B_02_H.jsp 페이지에서 실행 --%>
<td width=200><p align=center>
<%-- td width=200 : 행 너비 200 / p align=center : 가운데정렬 --%>
<select name = choice>
<%-- select 태그 : 드롭다운 박스 생성 / select 명을 choice로 설정 --%>
<option value=1>1 김일동
<option value=1>2 김이동
<option value=1>3 김삼동
<option value=1>4 김사동
<option value=1>5 김오동
<%-- 드롭다운 박스의 목록인 option 생성하여 각 값을 value로 설정 --%>
<%-- 화면에 출력되는 내용은 <option>과 </option> 사이에 설정 --%>
</select>
</p>
</td>
<td>
<input type=submit value="투표하기">
<%-- '투표하기' 버튼을 클릭하면 실행되도록 설정 --%>
</td>
</form>
</tr>
</table>
</BODY>
</HTML>
