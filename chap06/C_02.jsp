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

String keyword_p= request.getParameter("key");
//문자열 변수 keyword_p 생성하여 C_01.jsp에서 "key" 값을 받아오는 파라미터 값으로 설정
int keyword_ID = Integer.parseInt(keyword_p);
//정수 변수 keyword_ID 생성하여 keyword_p 값을 정수형으로 형변환한 값으로 설정

String k15_Query_1 = "select count(*) from Tupyo_table where id = " + keyword_ID + ";";
ResultSet k15_rset = k15_stmt.executeQuery(k15_Query_1);
//Tupyo_table에서 id column의 값이 keyword_ID 변수 값과 일치하는 경우 전체 수 조회

k15_rset.next();
Double totalCount =  (double)(k15_rset.getInt(1));
//실수 변수 totalCount 생성하여 ResultSet 객체 읽어들이는 동안 그 값을 첫번째 column을 실수형으로 형변환
%>

<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td height=50 width=200 align=center><a href="A_01.jsp"><font size=5>후보등록</font></a></td>
<td height=50 width=200 align=center><a href="B_01.jsp"><font size=5>투표</font></a></td>
<td height=50 width=200 align=center bgcolor=yellow><a href="C_01.jsp"><font size=5>개표결과</font></a></td></tr>
</table>

<%
String k15_Query_2 = "select id, name from hubo_table where id = " + keyword_ID + ";";
k15_rset = k15_stmt.executeQuery(k15_Query_2);
//hubo_table에서 id column의 값이 keyword_ID와 일치할 때 id, name 조회

k15_rset.next();
int id = k15_rset.getInt(1) ;
String name = k15_rset.getString(2);
//ResultSet 객체 읽어들이는 동안 정수형 변수 id, 문자열 변수 name의 값을 각각 첫번째, 두번째 column으로 설정

out.println("<strong><h1>" + id + ". " + name + " 후보 득표성향 분석</h1></strong><br><br>");
//'id. name 후보 득표성향 분석' 출력문 설정
%>

<table border=1 width=600 cellspacing=0 cellpadding=5>
<tr>
<td width=200><p align=center>연령대</p></td>
<td width=400><p alig=center>&nbsp;&nbsp;득표율</p></td>
</tr>

<%
for(int i = 1; i < 10; i++){
//for문으로 정수형 변수 i의 초기값을 1로 설정하고 10보다 작은 동안 그 값이 1씩 더해지도록 설정
out.println("<tr><td width=200><p align=center>" + (i * 10) + "대</p></td>");
//(i * 10) 대를 출력하여 연령대 화면에 출력 
out.println("<td width=400><p align=left>");

String k15_Query_age = "select count(*) from Tupyo_table where id = " + keyword_ID + " and age = " + (i * 10) + ";";
k15_rset = k15_stmt.executeQuery(k15_Query_age);
//Tupyo_table에서 id의 값이 keyword_ID와 일치하고(AND) age의 값이 (i * 10)와 일치할 때 전체 카운트 수 조회
//age 값을 select form으로 10, 20, 30...으로 받아왔기 때문에 (i*10) 필요

    k15_rset.next();
    //ResultSet 객체 읽어들이는 동안 아래 실행문 실행
    if(totalCount != 0) {
    //if조건으로 totalCount의 값이 0이 아닌 경우 설정
    out.println("<img src=bar.jpg width=" + (int) (300 * (k15_rset.getInt(1)/ totalCount)) + " height=20>");
    //그래프의 넓이를 첫번째 column의 값을 totalCount 변수로 나눈 뒤 300px 곱하여 정수형으로 형변환한 값으로 설정 / 높이는 20px
    out.println(k15_rset.getInt(1) + "(" + (int)((k15_rset.getInt(1)/ totalCount) * 100) + "%)");
    //그래프의 수치를 첫번째 column의 값을 totalCount 변수로 나눈 뒤 100 곱하여 정수형으로 형변환한 값으로 설정한 뒤 퍼센트지로 출력
    } else {
    //else문으로 그 외 경우 설정
    out.println("<img src=bar.jpg width=0 height=20>");
    //totalCount의 값이 0인 경우이기 때문에 그래프의 넓이는 0으로 설정
    out.println(k15_rset.getInt(1) + "(0%)");
    //첫번째 column의 값(0) 받아와 출력하고 (0%) 출력
    }
    out.println("</p></td></tr>");
}

%>
</table>
<%
k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB 연결에 필요한 객체 닫아줌
%>
</BODY>
</HTML>
