<!--k15전아현 / 2018.07.25.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD><title>*Create twice_stock table</title></HEAD>
<BODY>
<h1>Make table</h1>

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
String k15_query = "create table twice_stock(id varchar(40) not null primary key, name varchar(20), stock_count int, update_date datetime, insert_date datetime, content text, img text) DEFAULT CHARSET=utf8;";
//문자열 변수 k15_query 생성하여 gongji 테이블 생성하는 create문 설정
//id column은 not null, primary key 제약사항을 설정하며, 문자(알파벳) 들어갈 수 있도록 varchar(40)으로 생성
//name, content, img를 문자열 입력받는 type으로 varchar(20), text로 설정한 뒤 update_date, update_date column의 type을 datetime으로 설정
k15_stmt.execute(k15_query);

String k15_sql = "";
//문자열 변수 k15_sql 생성하여 초기값을 ""로 설정
k15_sql = "insert into twice_stock(id, name, stock_count, update_date, insert_date, content, img) values('1', '바나나', 10, now(), now(), '알래스카산 바나나로 맘모스의 아침식사', '/upload/danji.jpg');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into twice_stock(id, name, stock_count, update_date, insert_date, content, img) values('2', '따알기', 10, now(), now(), '신선한 따알기로 맘모스의 아침식사', '/upload/danji.jpg');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into twice_stock(id, name, stock_count, update_date, insert_date, content, img) values('3', '사아과', 12, now(), now(), '맛난 사아과로 맘모스의 아침식사', '/upload/danji.jpg');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into twice_stock(id, name, stock_count, update_date, insert_date, content, img) values('4', '배애애', 14, now(), now(), '쥬시한 배애애로 맘모스의 아침식사', '/upload/danji.jpg');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into twice_stock(id, name, stock_count, update_date, insert_date, content, img) values('5', '참외애', 15, now(), now(), '달콤한 참외애로 맘모스의 아침식사', '/upload/danji.jpg');";
k15_stmt.execute(k15_sql);
//twice_stock 테이블에 data insert 하는 insert문 설정

//테이블 twice_stock 생성이 완료되었음을 알리는 출력문 설정
out.println("twice_stock 테이블 생성을 완료하였습니다.<br>");

k15_stmt.close();
k15_conn.close();

}catch(Exception e) {
//오류상황 발생시 출력문 설정
out.println("테이블이 이미 존재합니다.<br>");

k15_stmt.close();
k15_conn.close();
}
%>
</BODY>
</HTML>