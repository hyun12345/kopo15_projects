<!--k15전아현 / 2018.07.24.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD>
<title>*Drop gongji table</title>
</HEAD>
<BODY>
<h1>Drop table</h1>

<%
Class.forName("com.mysql.jdbc.Driver");
// "com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
// Connection 객체명 = DriverManger.getConnection("필요한 정보");
// 데이터베이스와 연결
Statement k15_stmt = k15_conn.createStatement();
// Statement -> select 등을 실행함
// Query : SQL 명령문 자바에서도 실행가능하도록 함
%>
<%
try{
k15_stmt.execute("truncate table gongji;");  
k15_stmt.execute("drop table gongji;");
out.println("gongji 테이블 삭제를 완료하였습니다<br>");
}catch(Exception e) {
    out.println("gongji 테이블을 삭제할 수 없습니다.<br>");
}
%>