<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD><title>*공지리스트</title></HEAD>
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
%>

<table cellspacing=1 width=650 border=1>
<tr>
<td width=50><p align=center>번호</p></td>
<td width=500><p align=center>제목</p></td>
<td width=100><p align=center>등록일</p></td>
</tr>
<tr>
<%
    String k15_Query = "select id, title, date from gongji order by id desc;";
    ResultSet k15_rset = k15_stmt.executeQuery(k15_Query);
    //gongji 테이블에서 id, title, date column의 데이터를 조회하여 id column을 기준으로 내림차순으로 조회하는 select문 실행
    
    while (k15_rset.next()) {
    //while문으로 ResultSet 객체 읽어들이는 동안 아래 실행문 실행
    String id = Integer.toString(k15_rset.getInt(1));
	String title = k15_rset.getString(2);
    String date = k15_rset.getString(3);
    //문자열 변수 id, title, date 생성하여 각각의 column 값을 받아옴
	
    out.println("<form method=\"post\" action=\"gongji_insert.jsp\">");
    //post 방식 : html 페이지에 form 형태에서 값을 전달 / gongji_insert.jsp로 링크 연결되도록 설정
    out.println("<tr>");
    out.println("<td width=50><p align=center>" + id + "</p></td>");
    out.println("<td width=500><p align=left><a href=\"gongji_view.jsp?key=" + id + "\">" + title + "</a></p></td>");
    //<a> 태그 활용하여 key 값을 변수 id의 값으로 갖게 하고 title에 gongji_view.jsp 링크에 연결되도록 설정
    out.println("<td width=100><p align=center>" + date + "</p></td>");
    }

    k15_rset.close();
	k15_stmt.close();
	k15_conn.close();
   //DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>
</tr></table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=submit value="신규"></td>
<%-- '신규' 버튼 생성하여 클릭하면 form 실행되도록 설정 --%>
</tr>
</form>
</table>
</BODY>
</HTML>
