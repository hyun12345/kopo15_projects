<!--k15전아현 / 2018.07.20.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<HTML>
<HEAD>
<title>*투표</title>
</HEAD>
<BODY>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
Statement k15_stmt = k15_conn.createStatement();

String k15_Query = "select * from hubo_table;";
ResultSet k15_rset= k15_stmt.executeQuery(k15_Query);
//hubo_table에서 전체 데이터를 조회하는 query문 실행
%>

<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td height=50 width=200 align=center><a href="A_01.jsp"><font size=5>후보등록</font></a></td>
<td height=50 width=200 align=center bgcolor=yellow><a href="B_01.jsp"><font size=5>투표</font></a></td>
<td height=50 width=200 align=center><a href="C_01.jsp"><font size=5>개표결과</font></a></td></tr>
</table>

<h1>투표하기</h1>
<br>
<table border=1 width=600 cellspacing=0 cellpadding=5>
<tr><form method="post" action="B_02.jsp">
<%-- <%-- post 방식 : html 페이지에 form 형태에서 값을 전달 / form 이름을 B_02.jsp로 설정 --%>
<td width=200 align=center>

<select name=choice_who style="text-align:left; width:170px;" required>
<%-- select 태그 : 드롭다운 박스 생성 / select 명을 choice_who 설정 / 필수로 입력값 받도록 required 설정--%>
<%
out.println("<option value=\"\">후보 선택</option>");
//드롭다운 박스에 가장 처음 출력되는 옵션값을 '후보 선택'으로 설정하고 value는 없도록 설정
while(k15_rset.next()) {
out.println("<option value=\"" + Integer.toString(k15_rset.getInt(1)) + "\">" + 
                                Integer.toString(k15_rset.getInt(1)) + "번 " +  k15_rset.getString(2));
out.println("</option>");
//while문으로 ResultSet 객체 읽어들이는 동안 옵션 value를 id의 값으로, 출력문은 'id번 name'으로 설정
}
k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB 연결 위한 객체 닫아줌
%>
</select>

<select name=choice_age style="text-align:left; width:170px;" required>
<%-- select 태그 : 드롭다운 박스 생성 / select 명을 choice_age 설정 / 필수로 입력값 받도록 required 설정--%>
<option value="">투표자 연령대 선택</option>
<%-- 드롭다운 박스에 가장 처음 출력되는 옵션값을 '투표자 연령대 선택'으로 설정하고 value는 없도록 설정 --%>
<option value=10>10대</option>
<option value=20>20대</option>
<option value=30>30대</option>
<option value=40>40대</option>
<option value=50>50대</option>
<option value=60>60대</option>
<option value=70>70대</option>
<option value=80>80대</option>
<option value=90>90대</option>
<%-- 옵션 value를 10살 단위의 연령대로, 출력문 역시 마찬가지로 설정 --%>
</select>
<input type=submit value="투표하기">
<%-- '투표하기' 버튼을 클릭하면 실행되도록 설정 --%>
</td></form></tr></table>
</BODY>
</HTML>
