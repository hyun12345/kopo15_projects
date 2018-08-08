<!--k15전아현 / 2018.07.20.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<HTML>
<HEAD>
<title>*후보등록</title>
</HEAD>
<BODY>

<%
request.setCharacterEncoding("utf-8");

Class.forName("com.mysql.jdbc.Driver");
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
Statement k15_stmt = k15_conn.createStatement();
%>

<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td height=50 width=200 align=center bgcolor=yellow><a href="A_01.jsp"><font size=5>후보등록</font></a></td>
<td height=50 width=200 align=center><font size=5><a href="B_01.jsp">투표</a></font></td>
<td height=50 width=200 align=center><font size=5><a href="C_01.jsp">개표결과</a></font></td></tr>
</table>
<%
try{
int id = Integer.parseInt(request.getParameter("id"));
//정수형 변수 id 생성하여 A_01.jsp에서 받아오는 id의 값, 즉 파라미터 값으로 설정하여 정수형으로 형변환
String name = request.getParameter("name");
//문자열 변수 name 생성하여 A_01.jsp에서 받아오는 name의 값, 즉 파라미터 값으로 설정


String k15_Query = "insert into hubo_table (id, name) values (" + id + ", '" + name + "');";
k15_stmt.execute(k15_Query);
//hubo_table에 id, name 변수 대입하여 data insert 실행

k15_stmt.close();
k15_conn.close();

out.println("<h1>후보등록 결과 : 후보가 추가되었습니다.</h1>");
//정상적으로 실행됬을 때의 출력문 설정
}catch(Exception e){
out.println("<h1>후보 추가를 실패했습니다.</h1>");
//오류상황 발생했을 때의 출력문 설정
}
%>
</BODY>
</HTML>

