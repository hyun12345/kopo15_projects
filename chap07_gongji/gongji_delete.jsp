<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<BODY>
<%
Class.forName("com.mysql.jdbc.Driver");
// "com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
// Connection 객체명 = DriverManger.getConnection("필요한 정보");
// 데이터베이스와 연결
Statement k15_stmt = k15_conn.createStatement();
// Statement -> select 등을 실행함
// Query : SQL 명령문 자바에서도 실행가능하도록 함

String keyword_p= request.getParameter("key");
//문자열 변수 keyword_p 생성하여 C_01.jsp에서 "key" 값을 받아오는 파라미터 값으로 설정
int keyword_ID = Integer.parseInt(keyword_p);
%>

<%
try{
//try catch문 활용하여 오류 상황 발생시 출력문 설정

String k15_Query = "delete from gongji where id = " + keyword_ID + ";";
k15_stmt.executeUpdate(k15_Query);

out.println("<h1>게시글이 삭제되었습니다.</h1>");
//정상적으로 실행됬을 때의 출력문 설정
out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table>");

k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌
} catch(Exception e) {
k15_stmt.close();
k15_conn.close();

out.println("<h1>게시글 삭제를 실패했습니다.</h1>");  
out.println(e.toString());
//오류상황 발생했을 때의 출력문 설정

out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table>");
}
%>
</BODY></HTML>