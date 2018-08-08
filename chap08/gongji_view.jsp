<!--k15전아현 / 2018.07.27.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD><title>*게시글확인</title></HEAD>


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
//문자열 변수 keyword_p 생성하여 gongji_list에서 "key" 값을 받아오는 파라미터 값으로 설정
int keyword_ID = Integer.parseInt(keyword_p);
//정수 변수 keyword_ID 생성하여 keyword_p의 값을 정수형으로 형변환한 값으로 설정
%>

<form method=post name='gongji_view'>
<table width=650 border=1 cellspacing=0 cellpadding=5 align=center>

<%
    String k15_Query = "select id, title, date_format(date, '%Y-%m-%d %H:%i:%s'), content, rootid, relevel, recnt, viewcnt, file1, file2, file3 from gongji where id = " + keyword_ID + ";";
    ResultSet k15_rset = k15_stmt.executeQuery(k15_Query);
    //gongji 테이블에서 where절로 id의 값이 keyword_ID와 일치할 경우 id, title, date, content column의 데이터를 조회하는 select문 실행
    
    k15_rset.next();
    String id = Integer.toString(k15_rset.getInt(1));
	String title = k15_rset.getString(2);
    String date = k15_rset.getString(3);
    String content = k15_rset.getString(4);
    String rootid = Integer.toString(k15_rset.getInt(5));
    String relevel = Integer.toString(k15_rset.getInt(6));
    String recnt = Integer.toString(k15_rset.getInt(7));
    int viewcnt = k15_rset.getInt(8);
    viewcnt++;
    String fileaddress1 = k15_rset.getString(9);
    String fileaddress2 = k15_rset.getString(10);
    String fileaddress3 = k15_rset.getString(11);

    out.println("<tr>");
    out.println("<td width=100><b>번호</b></td><td>" + id + "</td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>제목</b></td><td>" + title + "</td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>일자</b></td><td>" + date + "</td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>조회수</b></td><td>" + viewcnt + "</td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>내용</b></td>");
    out.println("<td><div style=\"width:500px; height:250px;\">" + content + "</div></td></tr>");
    //out.println("<td><textarea id=content>" + content + "</textarea></td></tr>");
    out.println("<tr>");
    
    out.println("<td width=100><b>첨부된 파일</b></td><td>");

    if(fileaddress1 != null) {
        String filename1 = fileaddress1.substring(fileaddress1.lastIndexOf("/")+1);
        out.println("<a href = " + fileaddress1 + " download><img src = download.png width=23 height=23>" + filename1 + "</a><br>");
    }
    if(fileaddress2 != null) {
        String filename2 = fileaddress2.substring(fileaddress2.lastIndexOf("/")+1);
        out.println("<a href = " + fileaddress2 + " download><img src = download.png width=23 height=23>" + filename2 + "</a><br>");
    } 
    if(fileaddress3 != null) {
        String filename3 = fileaddress3.substring(fileaddress3.lastIndexOf("/")+1);
        out.println("<a href = " + fileaddress3 + " download><img src = download.png width=23 height=23>" + filename3 + "</a><br>");
    }
    if(fileaddress1 == null && fileaddress2 == null && fileaddress3 == null) {
        out.println("첨부된 파일 없음");
    } 
    out.println("</td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>원글</b></td><td>" + rootid + "</td></tr>");
    out.println("<tr>");
    out.println("<td width=100><b>댓글수준</b></td><td>" + relevel);
    out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    out.println("<b>댓글내 순서</b>&nbsp;" + recnt + "</td></tr>");
    //각 변수의 값을 표에 출력하도록 설정
    //내용을 textarea readonly로 출력하도록 하여 입력한 값이 그대로 출력되도록 설정
    //border:0; : 테두리 없애기 / background-color:transparent; : 배경색 투명하게 filter:chroma(color=ffffff); :스크롤바 투명하게 설정
    String update_viewcnt = "update gongji set viewcnt = " + viewcnt + " where id = " + keyword_ID + ";";
    k15_stmt.execute(update_viewcnt);
%>
</table>
<table width=650 align=center>
<tr>
<td width=600></td>
<td><input type=button value="목록" OnClick="location.href='gongji_list.jsp'"></td>
<%-- '목록' 버튼 생성하여 클릭하면 gongji_list.jsp 페이지로 이동하도록 설정 --%>
<%
out.println("<td><input type=button value=\"수정\" OnClick=\"location.href='gongji_update.jsp?key=" + id + "'\"></td>");
//'수정' 버튼 생성하여 클릭하면 key 값을 keyword_ID의 값으로 가지며 gongji_update.jsp 페이지로 이동하도록 설정
out.println("<td><input type=button value=\"삭제\" OnClick=\"location.href='gongji_delete.jsp?key=" + id + "'\"></td>");
out.println("<td><input type=button value=\"댓글\" OnClick=\"location.href='gongji_reinsert.jsp?key=" + id + "'\"></td>");

k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>
</tr></table>
</form>
</BODY>
</HTML>

