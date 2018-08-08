<!--k15전아현 / 2018.07.27.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.util.*" %>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%-- MultipartRequest 클래스 사용하기 위해 import --%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%-- 파일 업로드 시 기존의 파일명과 동일한 파일이 있을 때 덮어쓰기를 방지하는 DefaultFileRenamePolicy 클래스 사용하기 위해 import --%>

<HTML>
<HEAD><title>*게시글 입력완료</title></HEAD>
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

<%
try{
    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
    //MultipartRequest 객체 multi 생성
    //request : MultipartRequest와 연결될 request 객체 / 그 외의 request 변수들은 위에서 선언하고 갑을 부여함
    //중복되는 파일명을 처리하기위해 DefaultFileRenamePolicy 객체도 생성

    String key = multi.getParameter("key");
    String id = multi.getParameter("id");
    String title = multi.getParameter("title");
    String date = multi.getParameter("date");
    String content = multi.getParameter("content");

    //id, title, date, content의 값을 받아 각각 변수로 설정

    title = title.replace("'", "''");
    title = title.replace("<", "&lt");
    title = title.replace(">", "&gt");
    content = content.replace("'", "''"); 

    String fileaddress1 = ""; 
    String serverfilename1 = "";
    
    String fileaddress2 = ""; 
    String serverfilename2 = "";
    
    String fileaddress3 = ""; 
    String serverfilename3 = "";

    String k15_Query1 = "";
    String k15_Query2 = "";
    String k15_Query3 = "";

    try {
        if(key.equals("INSERT")) {
            String k15_lastinsert = "SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'kopo15' AND TABLE_NAME = 'gongji';";
            ResultSet k15_rset = k15_stmt.executeQuery(k15_lastinsert);
            k15_rset.next();
            int rootid_new = k15_rset.getInt(1);

            serverfilename1 = multi.getFilesystemName("file1");
            serverfilename2 = multi.getFilesystemName("file2");
            serverfilename3 = multi.getFilesystemName("file3");
            
            k15_Query1 = "insert into gongji (title, date, content, rootid, relevel, recnt, viewcnt";
            k15_Query2 = ") values ('" + title + "', date_format(now(), '%Y-%m-%d %H:%i:%s'), '" + content + "', " + rootid_new + ", 0, 0, 0";
            k15_Query3 = ");";

            if(serverfilename1 != null) {
            fileaddress1 = saveFolder+"/"+serverfilename1;
            k15_Query1 += ", file1";
            k15_Query2 += ", '" + fileaddress1 + "'";
            }

            if(serverfilename2 != null) {
            fileaddress2 = saveFolder+"/"+serverfilename2;
            k15_Query1 += ", file2";
            k15_Query2 += ", '" + fileaddress2 + "'";
            } 

            if(serverfilename3 != null) {
            fileaddress3 = saveFolder+"/"+serverfilename3;
            k15_Query1 += ", file3";
            k15_Query2 += ", '" + fileaddress3 + "'";
            } 
            
            k15_stmt.execute(k15_Query1 + k15_Query2 + k15_Query3);

        } else if(key.equals("REINSERT")) {

            String rootid = multi.getParameter("rootid");
            int relevel = Integer.parseInt(multi.getParameter("relevel"));
            int recnt = Integer.parseInt(multi.getParameter("recnt"));

            serverfilename1 = multi.getFilesystemName("file1");
            serverfilename2 = multi.getFilesystemName("file2");
            serverfilename3 = multi.getFilesystemName("file3");

            k15_Query1 = "insert into gongji (title, date, content, rootid, relevel, recnt, viewcnt";
            k15_Query2 = ") values ('" + title + "', date_format(now(), '%Y-%m-%d %H:%i:%s'), '" + content + "', '" + rootid + "', " + relevel + ", " + recnt + ", 0";
            k15_Query3 = ");";

            if(serverfilename1 != null) {
            fileaddress1 = saveFolder+"/"+serverfilename1;
            k15_Query1 += ", file1";
            k15_Query2 += ", '" + fileaddress1 + "'";
            }

            if(serverfilename2 != null) {
            fileaddress2 = saveFolder+"/"+serverfilename2;
            k15_Query1 += ", file2";
            k15_Query2 += ", '" + fileaddress2 + "'";
            } 

            if(serverfilename3 != null) {
            fileaddress3 = saveFolder+"/"+serverfilename3;
            k15_Query1 += ", file3";
            k15_Query2 += ", '" + fileaddress3 + "'";
            }   

            k15_stmt.execute(k15_Query1 + k15_Query2 + k15_Query3);
        } else if(key.equals("UPDATE")) {
            
            String k15_update_date = "select date_format( " + date + ", '%Y-%m-%d %H:%i:%s'), date_format(now(), '%Y-%m-%d %H:%i:%s') from gongji;";
            //date(now())를 column 값으로 입력하는 것으로 대체 가능 
            ResultSet k15_rset = k15_stmt.executeQuery(k15_update_date);
            k15_rset.next();
            String date_forupdate = k15_rset.getString(1);
            String update_date = k15_rset.getString(2);

            String k15_Query = "update gongji set title = '" + title + "', content = '" + content + "', update_date = '" + update_date + "' where id =" + Integer.parseInt(id) + ";";
            k15_stmt.execute(k15_Query);
            //id의 갑싱 'INSERT'와 일치하지 않는 모든 경우 변수 값을 받아 update문 실행되도록 설정
            //update 날짜 별도로 입력하기 위해 update_date column에 변수 값 대입
        }

    k15_stmt.close();
    k15_conn.close();
    //DB에 연결하기 위해 생성하였던 각 객체 닫아줌

out.println("<center><h1>게시글 생성 및 수정이 완료되었습니다.</h1>");
//정상적으로 실행됬을 때의 출력문 설정
out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table></center>");
//gongji_list.jsp와 링크가 연결된 submit button 생성하여 목록으로 돌아갈 수 있도록 설정

} catch(Exception e) {
k15_stmt.close();
k15_conn.close();

out.println("<center><h1>게시글 생성 및 수정을 실패했습니다.</h1>");  
out.println(e.toString());
//오류상황 발생했을 때의 출력문 설정

out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table></center>");
//gongji_list.jsp와 링크가 연결된 submit button 생성하여 목록으로 돌아갈 수 있도록 설정
}} catch(Exception e) {
out.println(e.toString());
}
%>
</BODY></HTML>