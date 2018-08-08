<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD><title>*Make gongji table</title></HEAD>
<BODY>
<h1>Make table</h1>

<%
request.setCharacterEncoding("utf-8");
//문다 Encoding을 utf-8로 설정하여 한글 데이터 입력 가능하도록 설정

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
String k15_query = "create table gongji(id int not null primary key auto_increment, title varchar(70), date date, content text, update_date date) DEFAULT CHARSET=utf8;";
//문자열 변수 k15_query 생성하여 gongji 테이블 생성하는 create문 설정
//id column은 not null, primary key 제약사항과 자동적으로 값이 더해지도록 auto_increment 설정
//title, content를 문자열 입력받는 type으로 각각 varchar(70), text로 설정한 뒤 date column의 type을 date로 설정
k15_stmt.execute(k15_query);

String k15_sql = "";
//문자열 변수 k15_sql 생성하여 초기값을 ""로 설정
k15_sql = "insert into gongji(title, date, content) values('공지사항1', date(now()), '공지사항내용1');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into gongji(title, date, content) values('공지사항2', date(now()), '공지사항내용2');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into gongji(title, date, content) values('공지사항3', date(now()), '공지사항내용3');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into gongji(title, date, content) values('공지사항4', date(now()), '공지사항내용4');";
k15_stmt.execute(k15_sql);
k15_sql = "insert into gongji(title, date, content) values('공지사항5', date(now()), '공지사항내용5');";
k15_stmt.execute(k15_sql);
//gongji 테이블에 data insert 하는 insert문 설정

//테이블 gongji 생성이 완료되었음을 알리는 출력문 설정
out.println("gongji 테이블 생성을 완료하였습니다.<br>");

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