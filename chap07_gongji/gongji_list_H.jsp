<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<BODY>
<table cellspacing=1 width=650 border=1>
<tr>
<td width=50><p align=center>번호</p></td>
<td width=500><p align=center>제목</p></td>
<td width=100><p align=center>등록일</p></td>
</tr>
<tr>
<td width=50><p align=center>1</p></td>
<td width=500><p align=center><a href='gongji_view_H.jsp?key=1'> 공지사항1</a></p></td>
<td width=100><p align=center>2018-01-14</p></td>
</tr>
<tr>
<td width=50><p align=center>1</p></td>
<td width=500><p align=center><a href='gongji_view_H.jsp?key=2'> 공지사항2</a></p></td>
<td width=100><p align=center>2018-01-15</p></td>
</tr>
</table>
<%-- 게시글 제목에 gongji_view_H.jsp 에서 key값이 설정한 값과 일치하는 경우의 게시글과 링크 연결되도록 설정 --%>
<table width=650>
<tr>
<td width=550></td>
<td><input type=button value="신규" OnClick="location.href='gongji_insert_H.jsp'"></td>
<%-- '신규' 버튼 생성하여 클릭시 gongji_insert_H.jsp 연결되도록 링크 설정 --%>
</tr>
</table>
</BODY>
</HTML>
