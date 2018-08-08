<!--k15전아현 / 2018.06.25.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%-- java.io.모든파일 import / 한글 출력 위해 UTF-8로 인코딩 --%>

<html>
<head>
    <title>*TBL생성</title>
    <%-- 출력 제목 메뉴명과 동일하게 설정 --%>
</head>
<body>


<%
try {
    //try{}catch{}문 활용하여 오류 발생시 출력문 설정

		Class.forName("com.mysql.jdbc.Driver");
		// "com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨
		// 필요없는 기능이므로 주석처리해도 실행 가능

        Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
		// Connection 객체명 = DriverManger.getConnection("필요한 정보");
		// 데이터베이스와 연결

		Statement k15_stmt = k15_conn.createStatement();
		// Statement -> select, create 등을 실행함
		// Query : SQL 명령문 자바에서도 실행가능하도록 함

        String k15_Query = "create table examtable(" + "name varchar(20)," + "studentid int not null auto_increment primary key,"
				+ "kor int," + "eng int," + "mat int)" + 
                "DEFAULT CHARACTER SET utf8 collate utf8_general_ci;";
        k15_stmt.execute(k15_Query);
        k15_stmt.execute("alter table examtable auto_increment = 209901");
		k15_stmt.close();
		k15_conn.close();
        out.println("<strong><h1>테이블만들기 OK </h1></strong>");
} catch (SQLException e) {
out.println("<strong><h1>※ERROR※<br>테이블을 생성하지 못했습니다.</h1></strong>");
}
%>

</body>
</html>