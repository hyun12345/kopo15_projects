<!--k15전아현 / 2018.08.07.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<%!
public void deletefile(String command) {
    StringBuffer buf = new StringBuffer();
    buf.append("<data>"); // 이미지 파일 지우는 명령어 날리기 시작.. <data> 태그
        {   
            int linecount = 1;
                    
            String line=""; 
            
            Runtime rt = Runtime.getRuntime(); 
            Process ps = null;
            
            try	{
            ps = rt.exec(command); 
                
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
                        if(iCnt==1)	buf.append("<time>"+retval[i]+"</time>");
                        else if(iCnt==2)	buf.append("<apm>"+retval[i]+"</apm>");
                        else if(iCnt==3)	buf.append("<CPU>"+retval[i]+"</CPU>");
                        else if(iCnt==4)	buf.append("<user>"+retval[i]+"</user>");
                        else if(iCnt==5)	buf.append("<nice>"+retval[i]+"</nice>");
                        else if(iCnt==6)	buf.append("<system>"+retval[i]+"</system>");
                        else if(iCnt==7)	buf.append("<iowait>"+retval[i]+"</iowait>");
                        else if(iCnt==8)	buf.append("<steal>"+retval[i]+"</steal>");
                        else if(iCnt==9)	buf.append("<idle>"+retval[i]+"</idle>");
                    }
                }
                linecount++;
            } 
            br.close();
        } catch(Exception e) { 
            e.printStackTrace(); 	  
        }
    }
    buf.append("</data>");
}

public void deleterecord(int id) throws Exception{

    Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a"); // Connection 객체 생성
    Statement k15_stmt = k15_conn.createStatement(); // Statement 객체 생성

    ResultSet k15_rset = k15_stmt.executeQuery("select rootid, relevel, recnt from gongji where id = "+ id +";");

    k15_rset.next();
    int rootid = k15_rset.getInt(1);
    int thisrelevel = k15_rset.getInt(2);
    int thisrecnt = k15_rset.getInt(3);
    int count_content = 0;
    String str_upperid = "";
    int upperid = 0;

    // 이제 하위 댓글이 남아있는지 확인한다.
    // 다음 같거나 높은 레벨의 recnt 값을 찾아온다( 존재하지 않을 수도 있다. )
    k15_rset=k15_stmt.executeQuery("select min(recnt) from gongji where rootid = "+ rootid +" and relevel <= "+ thisrelevel +" and recnt > "+ thisrecnt +";");
    // 직속 상위댓글이 아닌 다음 상위나 같은 레벨의 댓글의 최대 recnt( 댓글 순서 )값을 불러온다.
    k15_rset.next(); // FETCH
    String nextupperlevelrecnt = k15_rset.getString(1); // nextupperlevelrecnt 변수에 저장한다.
    int deleted_recnt = 0;
    if (nextupperlevelrecnt == null) { // 이후에 상위 레벨의 댓글이 존재하지 않는 경우
        k15_rset = k15_stmt.executeQuery("select count(*) from gongji where rootid = "+ rootid +" and relevel >= "+ thisrelevel +" and recnt >= "+ thisrecnt +";");
        // 상위나 같은 레벨의 댓글이 존재하지 않으므로 relevel이 thisrelevel 보다 크고(즉, 지운 글보다 하위레벨 댓글들), recnt가 thisrecnt 보다 큰(즉, 지운 글에 달린 댓글) 댓글들 중에 내용이 있는 것이 있는지 확인한다.
        k15_rset.next();
        deleted_recnt = k15_rset.getInt(1);

        k15_rset = k15_stmt.executeQuery("select count(content) from gongji where rootid = "+ rootid +" and relevel >= "+ thisrelevel +" and recnt >= "+ thisrecnt +";");
        // 상위나 같은 레벨의 댓글이 존재하지 않으므로 relevel이 thisrelevel 보다 크고(즉, 지운 글보다 하위레벨 댓글들), recnt가 thisrecnt 보다 큰(즉, 지운 글에 달린 댓글) 댓글들 중에 내용이 있는 것이 있는지 확인한다.
        k15_rset.next();
        count_content = k15_rset.getInt(1);
        if (count_content == 0) { // 내용 남아있는 댓글이 없으면
            k15_stmt.execute("delete from gongji where rootid = "+ rootid +" and recnt >= "+ thisrecnt +";");
        }
        k15_rset = k15_stmt.executeQuery("select max(id) from gongji where rootid = "+ rootid +" and relevel < "+ thisrelevel +" and recnt < "+ thisrecnt +";");
        k15_rset.next();
        str_upperid = k15_rset.getString(1);
        if (str_upperid != null) {
            upperid = Integer.parseInt(str_upperid);
            deleterecord(upperid);
        }
    } else {  // 그게 아닌 경우
        k15_rset = k15_stmt.executeQuery("select count(*) from gongji where rootid = "+ rootid +" and relevel >= "+ thisrelevel +" and recnt >= "+ thisrecnt +" and recnt < '" + nextupperlevelrecnt + "';");
        // 상위나 같은 레벨의 댓글이 존재하지 않으므로 relevel이 thisrelevel 보다 크고(즉, 지운 글보다 하위레벨 댓글들), recnt가 thisrecnt 보다 큰(즉, 지운 글에 달린 댓글) 댓글들 중에 내용이 있는 것이 있는지 확인한다.
        k15_rset.next();
        deleted_recnt = k15_rset.getInt(1);

        k15_rset = k15_stmt.executeQuery("select count(content) from gongji where rootid = "+ rootid +" and relevel >= "+ thisrelevel +" and recnt >= "+ thisrecnt +" and recnt < '" + nextupperlevelrecnt + "';");
        // 상위 레벨의 댓글이 존재하므로 relevel이 thisrelevel 보다 크고(즉, 지운 글보다 하위레벨 댓글들), recnt가 thisrecnt 보다 크고(즉, 지운 글에 달린 댓글) nextupperlevelrecnt 보다 작은 댓글들 중에 내용이 있는 것이 있는지 확인한다.
        k15_rset.next();
        count_content = k15_rset.getInt(1);
        if (count_content == 0) {
            k15_stmt.execute("delete from gongji where rootid = "+ rootid +" and recnt >= " + thisrecnt + " and recnt < '"+ nextupperlevelrecnt + "';");
            k15_stmt.execute("update gongji set recnt = (recnt - "+ deleted_recnt +") where rootid = "+ rootid +" and recnt >= "+ (thisrecnt + deleted_recnt) +" and recnt < '"+ (nextupperlevelrecnt + deleted_recnt) +"';");
        }
        k15_rset = k15_stmt.executeQuery("select max(id) from gongji where rootid = " + rootid + " and relevel < " + thisrelevel + " and recnt < " + thisrecnt + ";");
        k15_rset.next();
        str_upperid = k15_rset.getString(1);
        if (str_upperid != null) {
            upperid = Integer.parseInt(str_upperid);
            deleterecord(upperid);
        }
    }
    k15_rset.close(); // ResultSet  객체 닫아줌
    k15_stmt.close(); // Statement  객체 닫아줌
    k15_conn.close(); // Connection 객체 닫아줌
}

%>

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
//문자열 변수 keyword_p 생성하여 C_01.jsp에서 "key" 값을 받아오는 파라미터 값으로 설정
int keyword_ID = Integer.parseInt(keyword_p);
%>

<%
try{
//try catch문 활용하여 오류 상황 발생시 출력문 설정

String k15_Query = "select rootid, relevel, file1, file2, file3 from gongji where id = " + keyword_ID + ";";
ResultSet k15_rset = k15_stmt.executeQuery(k15_Query);
k15_rset.next(); 
int rootid = k15_rset.getInt(1);
int relevel = k15_rset.getInt(2);
String fileaddress1 = k15_rset.getString(3);
String fileaddress2 = k15_rset.getString(4);
String fileaddress3 = k15_rset.getString(5);
//문자열 변수 name, imageaddress 생성하여 ResultSet 객체 읽어들이며 값 받아옴

if (fileaddress1 != null) {
    k15_stmt.execute("update gongji set file1 = null where id=" + keyword_ID);
    deletefile("rm /var/lib/tomcat7/webapps/ROOT"+ fileaddress1);
}

if (fileaddress2 != null) {
    k15_stmt.execute("update gongji set file2 = null where id=" + keyword_ID);
     deletefile("rm /var/lib/tomcat7/webapps/ROOT"+ fileaddress2);
}

if (fileaddress3 != null) {
    k15_stmt.execute("update gongji set file3 = null where id=" + keyword_ID);
    deletefile("rm /var/lib/tomcat7/webapps/ROOT"+ fileaddress3);
}

String k15_delete = "update gongji set title = '<a href=\"javascript:void(0)\"><span style=\"color:gray;\">삭제된 글입니다.</a>', content = (null), delete_date = date_format(now(), '%Y-%m-%d %H:%i:%s'), delete_type = 'Y' where id =" + keyword_ID + ";";
k15_stmt.executeUpdate(k15_delete);

deleterecord(keyword_ID);

out.println("<center><h1>게시글이 삭제되었습니다.</h1>");
//정상적으로 실행됬을 때의 출력문 설정
out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table></center>");

k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌
} catch(Exception e) {
k15_stmt.close();
k15_conn.close();

out.println("<center><h1>게시글 삭제를 실패했습니다.</h1>");  
out.println(e.toString());
//오류상황 발생했을 때의 출력문 설정

out.println("<form method=post action=\"gongji_list.jsp\">");
out.println("<table width=650>");
out.println("<tr>");
out.println("<td width=600></td>");
out.println("<td><input type=submit value=\"목록으로 돌아가기\"></td>");
out.println("</form></table></center>");
}
%>
</BODY></HTML>