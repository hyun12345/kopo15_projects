<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<BODY>

<%
request.setCharacterEncoding("utf-8");
//문자 Encoding을 utf-8로 설정하여 한글 데이터 입력 가능하도록 설정

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
    String key = request.getParameter("key");
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String date = request.getParameter("date");
    String content = request.getParameter("content");
    //id, title, date, content의 값을 받아 각각 변수로 설정

    title = title.replace("'", "''");
    content = content.replace("'", "''");
    //title, content 변수의 값으로 '가 입력되면 ''로 변경되도록 replace() 메소드 사용

    if(key.equals("INSERT")) {
        String k15_Query = "insert into gongji (title, date, content) values ('" + title + "', '" + date + "', '" + content + "');";
        k15_stmt.execute(k15_Query);
    //id의 값이 'INSERT'와 일치하는 경우 변수 값을 받아 insert문 실행되도록 설정
    } 
    if(key.equals("UPDATE")) {
        String k15_update_date = "select date(now());";
        //date(now())를 column 값으로 입력하는 것으로 대체 가능 
        ResultSet k15_rset = k15_stmt.executeQuery(k15_update_date);
        k15_rset.next();
        String update_date = k15_rset.getString(1);

        String k15_Query = "update gongji set title = '" + title + "', date = '" + date + "', content = '" + content + "', update_date = '" + update_date + "' where id =" + Integer.parseInt(id) + ";";
        k15_stmt.execute(k15_Query);
    //id의 갑싱 'INSERT'와 일치하지 않는 모든 경우 변수 값을 받아 update문 실행되도록 설정
    //update 날짜 별도로 입력하기 위해 update_date column에 변수 값 대입
    }

k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌

out.println("<h1>게시글 생성 및 수정이 완료되었습니다.</h1>");
//정상적으로 실행됬을 때의 출력문 설정
out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table>");
//gongji_list.jsp와 링크가 연결된 submit button 생성하여 목록으로 돌아갈 수 있도록 설정

} catch(Exception e) {
k15_stmt.close();
k15_conn.close();

out.println("<h1>게시글 생성 및 수정을 실패했습니다.</h1>");  
out.println(e.toString());
//오류상황 발생했을 때의 출력문 설정

out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table>");
//gongji_list.jsp와 링크가 연결된 submit button 생성하여 목록으로 돌아갈 수 있도록 설정
}
%>
</BODY></HTML>