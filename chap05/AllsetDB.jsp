<!--k15전아현 / 2018.06.25.-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
<head>
    <title>*TBL값넣기</title>
</head>
<body>
   

<%
try { 
        Class.forName("com.mysql.jdbc.Driver");
		// "com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨

        Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
		// Connection 객체명 = DriverManger.getConnection("필요한 정보");
		// 데이터베이스와 연결

		Statement k15_stmt = k15_conn.createStatement();
		// Statement -> select, create 등을 실행함
		// Query : SQL 명령문 자바에서도 실행가능하도록 함

        String k15_Query;
        //Query문을 설정할 문자열 변수 k15_Query 생성

        String [] name = {"나연", "정연", "모모", "사나", "지효", "미나", "다현", "채영", "쯔위"};
        int [] studentid = {209901, 209902, 209903, 209904, 209905, 209906, 209907, 209908, 209909};
        int [] kor = { 95, 95, 100, 100, 80, 100, 70, 80, 78};
        int [] eng = {100, 95, 100, 95, 100, 100, 70, 75, 79};
        int [] mat = {95, 95, 100, 90, 70, 70, 70, 72, 82};

        for(int i = 0; i < studentid.length; i++) {
		k15_Query = "insert into examtable"
					+ "(name, studentid, kor, eng, mat)"
					+ "values (" + "'" + name[i] + "'" + "," + studentid[i] + "," + kor[i] + "," + eng[i] + "," + mat[i] + ");";
		k15_stmt.execute(k15_Query);
}
		k15_stmt.close();
		k15_conn.close();

     out.println("<strong><h1>실습데이터 입력</h1></strong>");
}catch(Exception e) {
    out.println("<strong><h1><text=※ERROR※<br>데이터를 입력하지 못했습니다.</h1></strong>");
}
%>
</body>
</html>