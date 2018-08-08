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

String k15_Query_1 = "select count(*) from Tupyo_table;";
ResultSet k15_rset_1 = k15_stmt.executeQuery(k15_Query_1);
//Tupyo_table에서 전체 수를 카운트하는 select문 실행

k15_rset_1.next();
Double totalCount =  (double)(k15_rset_1.getInt(1));
//실수 변수 totalCount 생성하여 ResultSet 객체를 읽는 동안 첫번째 column의 값 받아와 실수형으로 형변환
%>

<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td height=50 width=200 align=center><a href="A_01.jsp"><font size=5>후보등록</font></a></td>
<td height=50 width=200 align=center><a href="B_01.jsp"><font size=5>투표</font></a></td>
<td height=50 width=200 align=center bgcolor=yellow><a href="C_01.jsp"><font size=5>개표결과</font></a></td></tr>
</table>



<h1>후보별 득표율</h1>
<br>
<table border=1 width=600 cellspacing=0 cellpadding=5>
<tr>
<td width=200><p align=center>이름</p></td>
<td width=400><p alig=center>&nbsp;&nbsp;득표율</p></td>
<%-- &nbsp; : 띄어쓰기 --%>
</tr>

<%
String k15_Query_2 = "select hubo.id, hubo.name, count(tupyo.id) from hubo_table hubo left outer join Tupyo_table tupyo on hubo.id = tupyo.id group by hubo.id, hubo.name;";
ResultSet k15_rset_2= k15_stmt.executeQuery(k15_Query_2);
//hubo_table, Tupyo_table left outer join하여 select문 실행
//hubo_table의 id와 Tupyo_table의 id의 값이 같을 때 hubo_table의 id와 name으로 구분하여 hubo_table의 id, name, Tupyo_id에서 id의 수를 카운트 한 값 조회

while(k15_rset_2.next()) {
//while문으로 ResultSet 객체 읽어들이는 동안 아래 실행문 반복실행
out.println("<tr><td width=200 align=center><a href=\"C_02.jsp?key=" + Integer.toString(k15_rset_2.getInt(1)) + "\">" +
//key 값을 hubo_table의 id column의 값으로 설정하여 <a>태그 활용하여 C_02.jsp 페이지 링크 생성
Integer.toString(k15_rset_2.getInt(1)) + " " +  k15_rset_2.getString(2) + "</a></td>");
//이 링크를 '(hubo_table의)id name'에 연결되도록 설정
out.println("<td width=400><p align=left><img src=bar.jpg width=" + (int) (300 * (k15_rset_2.getInt(3)/ totalCount)) + " height=20>");
//bar.jpg 이미지 파일의 넓이를 Tupyo_table에서 id를 카운트 한 값을 totalCount로 나눈 뒤 300px를 곱하고 정수형으로 형변환한 값으로 설정 / 높이는 20px
out.println(k15_rset_2.getInt(3) + "(" + (int)((k15_rset_2.getInt(3)/ totalCount) * 100)+"%)</p></td></tr>");
//Tupyo_table에서 id를 카운트 한 값을 출력하고, 그 값을 totalCount로 나눈 뒤 100을 곱하여 정수형으로 형변환한 값을 퍼센트지로 출력
}
k15_rset_1.close();
k15_rset_2.close();
k15_stmt.close();
k15_conn.close();
//DB 연결에 필요한 객체 닫아줌
%>
</table>
</BODY>
</HTML>
