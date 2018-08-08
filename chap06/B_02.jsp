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
request.setCharacterEncoding("utf-8");

Class.forName("com.mysql.jdbc.Driver");
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
Statement k15_stmt = k15_conn.createStatement();
%>

<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td height=50 width=200 align=center><a href="A_01.jsp"><font size=5>후보등록</font></a></td>
<td height=50 width=200 align=center bgcolor=yellow><a href="B_01.jsp"><font size=5>투표</font></a></td>
<td height=50 width=200 align=center><a href="C_01.jsp"><font size=5>개표결과</font></a></td></tr>
</table>
<%
try{
int id  = Integer.parseInt(request.getParameter("choice_who"));
//정수 변수 id 생성하여 select form choice_who의 value를 파라미터로 받아와 정수형으로 형변환
int age = Integer.parseInt(request.getParameter("choice_age"));
//정수 변수 age 생성하여 select form choice_age의 value를 파라미터로 받아와 정수형으로 형변환

String k15_Query = "insert into Tupyo_table (id, age) values (" + id + ", " + age + ");";
k15_stmt.execute(k15_Query);
//id, age 변수를 대입하여 Tupyo_table에 데이터 insert 실행

k15_stmt.close();
k15_conn.close();
//DB 연결 위한 객체 닫아줌

out.println("<h1>투표를 완료하였습니다.</h1>");
}catch(Exception e){
out.println("<h1>투표에 실패했습니다.</h1>");
}
%>
</BODY>
</HTML>
