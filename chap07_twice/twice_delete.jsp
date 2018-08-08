<!--k15전아현 / 2018.07.25.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD><title>*㈜트와이스 재고 현황-상품삭제</title></HEAD>
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
//문자열 변수 keyword_ID 생성하여 "key" 값을 받아오는 파라미터 값으로 설정
%>

<table cellspacing=0 width=650 border=1>
<tr>
<td align=center><h1>㈜트와이스 재고 현황-상품삭제</h1></td></tr>
<tr><td align=center>
<br>

<%
try{
//try catch문 활용하여 오류 상황 발생시 출력문 설정

String k15_Query = "select name, img from twice_stock where id = '" + keyword_ID + "';";
ResultSet k15_rset = k15_stmt.executeQuery(k15_Query);

k15_rset.next(); 
String name = k15_rset.getString(1);
String imageaddress = k15_rset.getString(2);
//문자열 변수 name, imageaddress 생성하여 ResultSet 객체 읽어들이며 값 받아옴

out.println("<strong><h1>[" + name + "]상품이 삭제되었습니다.</h1></strong><br><br>");
//정상적으로 실행됬을 때의 출력문 설정

String k15_delete = "delete from twice_stock where id = '" + keyword_ID + "';";
k15_stmt.executeUpdate(k15_delete);
//where절로 id의 값이 keyword_ID의 값과 일치할 때 해당 데이터 삭제되도록 delete문 설정

out.println("<data>");
        {
            String command = "rm /var/lib/tomcat7/webapps/ROOT/" + imageaddress; 
            //문자열 변수 command 생성하여 실행할 명령어를 값으로 설정
            //업로드한 파일을 삭제하기 위한 명령어이므로 "rm /var/lib/tomcat7/webapps/ROOT/" + imageaddress; 를 값으로 설정
                
            int linecount = 1;
                    
            String line=""; 
            
            Runtime rt = Runtime.getRuntime(); 
            Process ps = null;
            
            try	{
            ps = rt.exec(command); 
            //ps는 exec() 메소드 활용하여 command를 실행

            BufferedReader br = new BufferedReader( 
                                        new InputStreamReader( 
                                            new SequenceInputStream(ps.getInputStream(), ps.getErrorStream()) ) ); 
                
            String retval[];
                
            while((line = br.readLine()) != null) {
                if(linecount==4){	//5번째 줄이 Average가 보이는 줄
                    retval=line.split(" ");
                    int iCnt=0;
                    for(int i=0;i<retval.length;i++){
                        retval[i]=retval[i].replaceAll(" ","");
                        if(retval[i].isEmpty()) continue;
                        iCnt++;	
                        if(iCnt==1)	out.println("<time>"+retval[i]+"</time>");
                        else if(iCnt==2)	out.println("<apm>"+retval[i]+"</apm>");
                        else if(iCnt==3)	out.println("<CPU>"+retval[i]+"</CPU>");
                        else if(iCnt==4)	out.println("<user>"+retval[i]+"</user>");
                        else if(iCnt==5)	out.println("<nice>"+retval[i]+"</nice>");
                        else if(iCnt==6)	out.println("<system>"+retval[i]+"</system>");
                        else if(iCnt==7)	out.println("<iowait>"+retval[i]+"</iowait>");
                        else if(iCnt==8)	out.println("<steal>"+retval[i]+"</steal>");
                        else if(iCnt==9)	out.println("<idle>"+retval[i]+"</idle>");
                    }
                }
                linecount++;
            } 
            br.close();
        }catch(Exception e) { 
            e.printStackTrace(); 	  
        } 
    }
    out.println("</data>");

out.println("<form method=post action=\"twice_list.jsp\">");
out.println("<table width=600>");
out.println("<tr>");
out.println("<td width=550></td>");
out.println("<td><input type=submit value=\"재고현황\"></td>");
out.println("</form></table>");

k15_stmt.close();
k15_conn.close();
} catch(Exception e) {
k15_stmt.close();
k15_conn.close();

out.println("<h1>상품 삭제를 실패했습니다.</h1>");  
out.println(e.toString());
//오류상황 발생했을 때의 출력문 설정

out.println("<form method=post action=\"twice_list.jsp\">");
out.println("<table width=600>");
out.println("<tr>");
out.println("<td width=550></td>");
out.println("<td align=center><input type=submit value=\"재고현황\"></td>");
out.println("</form></table>");
}
%>
</td></table>
</BODY></HTML>