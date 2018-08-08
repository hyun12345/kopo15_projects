<!--k15전아현 / 2018.07.25.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%-- MultipartRequest 클래스 사용하기 위해 import --%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%-- 파일 업로드 시 기존의 파일명과 동일한 파일이 있을 때 덮어쓰기를 방지하는 DefaultFileRenamePolicy 클래스 사용하기 위해 import --%>

<HTML>
<HEAD><title>*㈜트와이스 재고 현황-입력완료</title></HEAD>
<BODY>

<%
request.setCharacterEncoding("utf-8");
//문자 Encoding을 utf-8로 설정하여 한글 데이터 입력 가능하도록 설정

String realFolder = ""; 
// 문자열 변수 realFolder 생성하여 절대경로 저장될 수 있도록 값을 ""로 설정
String saveFolder = "/upload";
//문자열 변수 saveFolder 생성하여 이미지 출력에 필요한 파일 업로드할 폴더명으로 값을 설정
//파일질라 등 npp 프로그램 사용하여 /var/lib/tomcat7/webapps/ROOT/ 경로 밑에 upload 폴더 생성한 뒤 쓰기 권한 부여해야 함
String encType = "utf-8"; 
//문자열 변수 encType 생성하여 인코딩 타입의 값인 utf-8을 값으로 설정하여 한글 인코딩 되도록 설정
int maxSize = 5*1024*1024; 
//정수형 변수 maxSize 생성하여 그 값을 5Mb로 설정(업로드 가능한 최대 파일 크기)

ServletContext context = getServletContext();
//ServletContext : 웹어플리케이션이 필요한 환경(기능)을 제공 / 해당 어플리케이션의 모든 컴포넌트들이 사용 가능
//ServletContext 객체 context 생성한 뒤 getServletContext() 함수 활용하여 ServletContext 값 받아옴
realFolder = context.getRealPath(saveFolder);
//getRealPath() : 실제 경로 받아옴
//즉 realFolder의 값은 /var/lib/tomcat7/webapps/ROOT/upload가 됨

Class.forName("com.mysql.jdbc.Driver");
// "com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
// Connection 객체명 = DriverManger.getConnection("필요한 정보");
// 데이터베이스와 연결
Statement k15_stmt = k15_conn.createStatement();
// Statement -> select 등을 실행함
// Query : SQL 명령문 자바에서도 실행가능하도록 함
%>

<table cellspacing=0 width=650 border=1>
<tr>
<td align=center><h1>㈜트와이스 재고 현황-입력완료</h1></td></tr>
<tr><td align=center>
<br>
<%
try{
    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
    //MultipartRequest 객체 multi 생성
    //request : MultipartRequest와 연결될 request 객체 / 그 외의 request 변수들은 위에서 선언하고 갑을 부여함
    //중복되는 파일명을 처리하기위해 DefaultFileRenamePolicy 객체도 생성

    String key = multi.getParameter("key");
    String id = multi.getParameter("id");
    String name = multi.getParameter("name");
    String stock_count = multi.getParameter("stock_count");
    String update_date = multi.getParameter("update_date");
    String insert_date = multi.getParameter("insert_date");
    String content = multi.getParameter("content");
    //key값과 각 column의 값을 받아올 때 Request 객체가 아닌 MultipartRequest 객체의 값을 받아와야 함

    name = name.replace("'", "''");
    content = content.replace("'", "''");
    //name, content 변수의 값으로 '가 입력되면 ''로 변경되도록 replace() 메소드 사용
    
    String imageaddress = ""; 
    String serverfilename = "";
    // 이미지 경로가 저장될 문자열 변수 imageaddress, 이미지 명이 저장될 문자열 변수 serverfilename 생성하여 각각 초기값을 ""로  설정

    try {
        if(key.equals("INSERT")) {
            serverfilename = multi.getFilesystemName("imagefile");
            imageaddress = saveFolder+"/"+serverfilename; 
                        out.println(imageaddress);
            //serverfilename의 값을 서버에 실제로 업로드된 파일의 이름을 반환하는 getFilesystemName() 메소드 활용하여 imagefile의 값 받아옴
            //imageaddress의 값을 'saveFolder의 값/serverfilename의 값'으로 설정

            String k15_Query = "insert into twice_stock (id, name, stock_count, update_date, insert_date, content, img) values ('" + id + "', '" + name + "', " + stock_count + ", now(), now(), '" + content + "', '" + imageaddress +"');";
            k15_stmt.execute(k15_Query);
            //key 값이 'INSERT'와 일치하는 경우 변수 값을 받아 insert문 실행되도록 설정
        } else if(key.equals("UPDATE")) {
            String k15_Query = "update twice_stock set stock_count = " + stock_count + ", update_date = now() where id = '" + id + "';";
            k15_stmt.execute(k15_Query);
            //key 값이 'UPDATE'와 일치하는 경우 변수 값을 받아 update문 실행되도록 설정
        }

        String k15_name = "select name from twice_stock where id = '" + id + "';";
        ResultSet k15_rset = k15_stmt.executeQuery(k15_name);

        k15_rset.next(); 
        out.println("<strong><h1>[" + k15_rset.getString(1) + "]상품이 등록/수정되었습니다.</h1></strong><br><br>");
        //where절로 id column의 값이 id 변수의 값과 일치할 때 name column을 조회하여 실행 완료 출력문 설정

        k15_stmt.close();
        k15_conn.close();
        //DB에 연결하기 위해 생성하였던 각 객체 닫아줌

        //정상적으로 실행됬을 때의 출력문 설정
        out.println("<form method=post action=\"twice_list.jsp\">");
        out.println("<table width=650>");
        out.println("<tr>");
        out.println("<td width=600></td>");
        out.println("<td><input type=submit value=\"재고현황\"></td>");
        out.println("</form></table>");
    } catch (SQLException e) {
    k15_stmt.close();
    k15_conn.close();

    String errorMessage = e.toString();
    if(errorMessage.indexOf("Duplicate")>-1){
    //.indexOf() 해당 문자열 중 문자의 값의 위치값 도출
    //즉 e.toString()을 값으로 가지는 문자열 변수 error<essage의 값 중 Duplicate 내용이 있으면 아래 실행문 실행
    out.println("<h1>상품 번호가 중복됩니다.</h1>");
    out.println("<span style=\"color:red; font-size:15pt;\"><b>-오류 내용-</b></span><br>" + e.toString());
    } else {
    out.println("<h1>상품 등록 및 수정을 실패했습니다.</h1>");  
    out.println("<span style=\"color:red; font-size:15pt;\"><b>-오류 내용-</b></span><br>" + e.toString());
    }
    //오류상황 발생했을 때의 출력문 설정
    //}
    out.println("<form method=post action=\"twice_list.jsp\">");
    out.println("<table width=650>");
    out.println("<tr>");
    out.println("<td width=600></td>");
    out.println("<td><input type=submit value=\"재고현황\"></td>");
    out.println("</form></table>");
    }

} catch(Exception e) {
out.println(e.toString());
}
%>
</td></table>
</BODY></HTML>