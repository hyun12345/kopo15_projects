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
<%-- 현재 접속한 메뉴의 배경 색이 노란색이 되도록 bgcolor 설정 / <a> 태그 활용하여 각 메뉴에 접속 가능하도록 설정 --%>
</table>

<h1>투표하기</h1>
<br>
<h1>투표를 완료하였습니다.</h1>
<%-- 투표가 완료되었음을 알려주는 문구 출력 --%>
</BODY>
</HTML>
