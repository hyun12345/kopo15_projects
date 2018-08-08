<!--k15전아현 / 2018.07.24.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD><title>*㈜트와이스 재고 현황-상품상세</title>
</HEAD>
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

String keyword_ID = request.getParameter("key");
//문자열 변수 keyword_p 생성하여 gongji_list에서 "key" 값을 받아오는 파라미터 값으로 설정
//정수 변수 keyword_ID 생성하여 keyword_p의 값을 정수형으로 형변환한 값으로 설정
%>
<table cellspacing=0 width=750 border=1>
<tr>
<td align=center><h1>㈜트와이스 재고 현황-상품상세</h1></td></tr>
<tr><td align=center>
<br>
<form method=post name='gongji_view'>
<table width=700 border=1 cellspacing=0 cellpadding=5>

<%
    String k15_Query = "select id, name, format(stock_count, 0), date_format(update_date, '%Y-%m-%d %H:%i'), date_format(insert_date, '%Y-%m-%d %H:%i'), content, img from twice_stock where id = '" + keyword_ID + "';";
    ResultSet k15_rset = k15_stmt.executeQuery(k15_Query);
    //twice_stock 테이블에서 where절로 id의 값이 keyword_ID와 일치할 경우 모든 column의 데이터를 조회하는 select문 실행
    
    k15_rset.next();
    String id = k15_rset.getString(1);
	String name = k15_rset.getString(2);
    String stock_count = k15_rset.getString(3);
    String update_date = k15_rset.getString(4);
    String insert_date = k15_rset.getString(5);
    String content = k15_rset.getString(6);
    String image = k15_rset.getString(7);
    //ResultSet 객체 읽어들여 각 column의 문자열 변수 생성하여 각각의 column 값을 받아옴

    out.println("<tr>");
    out.println("<td width=100><b>상품 번호</b></td>");
    out.println("<td>" + id + "<input type=hidden name=id value=" + id +" ></td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>상품명</b></td>");
    out.println("<td>" + name + "<input type=hidden name=name value=" + name + "></td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>재고 현황</b></td>");
    out.println("<td>" + stock_count + "<input type=hidden name=stock_count value=" + stock_count + "></td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>상품등록일</b></td>");
    out.println("<td>" + insert_date + "<input type=hidden name=insert_date value=" + insert_date + "></td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>재고등록일</b></td><td>" + update_date + "</td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>내용</b></td>");
    out.println("<td>" + content + "<input type=hidden name=content value=" + content + "></td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>상품사진</b></td>");
    out.println("<td>");
    out.println("<table width=550 border=0 cellspacing=0 cellpadding=5>");
    out.println("<img src='"+ image +"' width=\"300\" >");
    //img column에 저장된 이미지 파일의 경로 값을 image 변수에 받아와 <img> 태그 활용하여 화면에 출력
    out.println("<input type=hidden name=imageaddress value=" + image + ">");
    out.println("</td></tr></table>");
    //각 변수의 값을 표에 출력하도록 설정
    //input type을 hidden으로 하여 각 column의 값을 value로 가지도록 설정
%>
</table>
<br>
<table width=700>
<tr>
<td width=650></td>
<%
out.println("<td><input type=button value=\"재고현황\" OnClick=\"location.href='twice_list.jsp'\"></td>");
out.println("<td><input type=button value=\"상품삭제\" OnClick=\"location.href='twice_delete.jsp?key=" + id + "'\"></td>");
out.println("<td><input type=button value=\"재고 수정\" OnClick=\"location.href='twice_update.jsp?key=" + id + "'\"></td>");
//'재고현황', '상품삭제', '재고수정' 버튼 각각 생성하여 클릭하는 링크를 별도로 지정

k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>
</tr></table>
</form>
</BODY>
</HTML>

