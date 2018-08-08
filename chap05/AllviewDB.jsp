<!--k15전아현 / 2018.06.25.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
<head>
    <title>*TBL전체조회</title>
</head>
<body>
    <strong><h1>조회</h1></strong>
    <br><br>

<%

Class.forName("com.mysql.jdbc.Driver");
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
//Connection : DB와 연결 위한 객체

Statement k15_stmt = k15_conn.createStatement();
//Statement : Query문 실행하는 객체


String k15_rank = "count(data02.sum)+1 from examtable data01"
        +" left join(select kor+eng+mat as sum from examtable) data02"
        +" on (data01.kor + data01.eng + data01.mat) < data02.sum group by name, studentid, kor, eng, mat, (data01.kor + data01.eng + data01.mat), avg order by studentid;";

ResultSet k15_rset = k15_stmt.executeQuery("select name, studentid, kor, eng, mat, kor+eng+mat as sum, (kor+eng+mat)/3 as avg, " + k15_rank);
%>

<table cellspacing=1 width=600 border=1>
<tr>
<td width=50><p align=center>이름</p></td>
<td width=50><p align=center>학번</p></td>
<td width=50><p align=center>국어</p></td>
<td width=50><p align=center>영어</p></td>
<td width=50><p align=center>수학</p></td>
<td width=50><p align=center>총점</p></td>
<td width=50><p align=center>평균</p></td>
<td width=50><p align=center>등수</p></td>
<%-- 테이블에 존재하는 column뿐만 아니라 총점, 평균, 등수 column 출력할 수 있도록 이와 같이 표 생성 --%>
</tr>

<%
while (k15_rset.next()) {
    out.println("<tr>");
    out.println("<td width=50><p align=center>"+"<a href=\"oneviewDB.jsp?key=" + 
    Integer.toString(k15_rset.getInt(2)) +"\">"+ k15_rset.getString(1)+"</a></p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(2))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(3))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(4))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(5))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(6))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(7))+"</p></td>");
    out.println("<td width=50><p align=center>"+Integer.toString(k15_rset.getInt(8))+"</p></td>");
    out.println("</tr>");
}
k15_rset.close();
k15_stmt.close();
k15_conn.close();
//ResultSet, Statement, Connection 객체 닫아줌
%>
</table>
</body>
</html>