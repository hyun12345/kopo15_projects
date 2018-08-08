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
<td height=50 width=200 align=center><a href="B_01_H.jsp"><font size=4>투표</font></a></td>
<td height=50 width=200 align=center bgcolor=yellow><a href="C_01_H.jsp"><font size=4>개표결과</font></a></td></tr>
</table>

<h1>후보별 득표 결과</h1>
<br>
<table border=1 width=600 cellspacing=0 cellpadding=5>
<tr>
<td width=75><p align=center>이름</p></td>
<td width=500><p alig=center>인기도</p></td>
</tr>
<tr>
<td width=75><a href="C_02_H.jsp"><p align=center>효민</p></a></td>
<%-- '효민' 클릭하면 C_02_H.jsp 페이지로 이동하도록 <a> 태그 설정(다른 이름도 마찬가지로 설정) --%>
<td width=75><p align=left><img src=bar.jpg width=100 height=20> 100(25%)</p></td>
<%-- 현재 jsp 파일이 위치한 폴더에 존재하는 이미지 파일을 img src로 호출하여 너비, 높이 지정하여 화면에 출력  --%>
<%-- 그래프 숫자와 퍼센트 출력문 설정 --%>
</tr>
<tr>
<td width=75><a href="C_02_H.jsp"><p align=center>보람</p></a></td>
<td width=75><p align=left><img src='bar.jpg' width=300 height=20> 300(75%)</p></td>
</tr>
<tr>
<td width=75><a href="C_02_H.jsp"><p align=center>은정</p></a></td>
<td width=75><p align=left><img src='bar.jpg' width=200 height=20> 200(50%)</p></td>
</tr>
<tr>
<td width=75><a href="C_02_H.jsp"><p align=center>지연</p></a></td>
<td width=75><p align=left><img src='bar.jpg' width=80 height=20> 80(20%)</p></td>
</tr>
<tr>
<td width=75><a href="C_02_H.jsp"><p align=center>효연</p></a></td>
<td width=75><p align=left><img src='bar.jpg' width=80 height=20> 80(20%)</p></td>
</tr>
<tr>
<td width=75><a href="C_02_H.jsp"><p align=center>큐리</p></a></td>
<td width=75><p align=left><img src='bar.jpg' width=80 height=20> 80(20%)</p></td>
</tr>
<tr>
<td width=75><a href="C_02_H.jsp"><p align=center>화영</p></a></td>
<td width=75><p align=left><img src='bar.jpg' width=80 height=20> 80(20%)</p></td>
</tr>
</table>
</BODY>
</HTML>
