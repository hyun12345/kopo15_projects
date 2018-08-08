<!--k15전아현 / 2018.06.25.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
<head>
    <title>*선택조회</title>
</head>
<body>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
//Connection : DB와 연결 위한 객체
Statement k15_stmt = k15_conn.createStatement();
//Statement : Query문 실행하는 객체

String key_word_S= request.getParameter("key");
//문자열 변수 key_word_S 생성하여 AllviewDB.jsp에서 "key" 값을 받아오는 파라미터 값으로 설정
int key_word_I = Integer.parseInt(key_word_S);
//정수 변수 key_word_I 생성하여 key_word_S의 값을 정수형으로 형변환한 값으로 설정

String k15_Query = "select * from examtable where studentid = " + key_word_I + ";";
//문자열 변수 k15_Query 생성하여 examtable에서 전체를 조회하는 select문에 where절로  studentid의 값이 key 값을 받아오는 key_word_I와 일치할 경우로 설정
ResultSet k15_rset= k15_stmt.executeQuery(k15_Query);
//ResultSet : 실행문(Query문) 받아서 처리하는 객체

%>

<table cellspacing=1 width=500 border=1>
<tr>
<td width=50><p align=center>이름</p></td>
<td width=50><p align=center>학번</p></td>
<td width=50><p align=center>국어</p></td>
<td width=50><p align=center>영어</p></td>
<td width=50><p align=center>수학</p></td>
</tr>

<%
    k15_rset.next(); 
    out.println("<strong><h1>[" + k15_rset.getString(1) + "]조회</h1></strong><br><br>");
    out.println("<tr>");
    out.println("<td width=50><p align=center>"+k15_rset.getString(1)+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(2))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(3))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(4))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(5))+"</p></td>");
    out.println("</tr>");
    //파라미터로 각 column의 값을 받아 출력되도록 설정

k15_rset.close();
k15_stmt.close();
k15_conn.close();
%>
</table>
</body>
</html>