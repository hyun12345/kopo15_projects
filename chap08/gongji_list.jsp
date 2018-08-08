<!--k15전아현 / 2018.07.27.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD><title>*공지리스트</title></HEAD>
<style type="text/css">
a { text-decoration:none }
</style>
<BODY>

    <%
    String k15_from = request.getParameter("from");
    if (k15_from == null)
    k15_from = "1";

    int k15_from_int = Integer.parseInt(k15_from);
    //form 값을 파라미터로 받아와 null값인 경우 초기값을 1로 설정하여 정수형 변수 k15_form_int의 값으로 설정

    String k15_cnt = request.getParameter("cnt");
    if (k15_cnt == null)
    k15_cnt = "20";
    
    int k15_cnt_int = Integer.parseInt(k15_cnt);
    //cnt 값을 파라미터로 받아와 null값인 경우 초기값을 1로 설정하여 정수형 변수 k15_cnt_int 값으로 설정

    int k15_page_num = 10;
    int k15_page_print_num = k15_page_num * k15_cnt_int;
    //정수형 변수 k15_page_num의 값을 10으로 설정(한 화면에 출력되는 페이지 수)
    //정수형 변수 k15_page_print_num의 값을 k15_page_num * k15_cnt_int으로 설정(한 화면에 포함되는 총 게시물 수)
    %>

<%
Class.forName("com.mysql.jdbc.Driver");
// "com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
// Connection 객체명 = DriverManger.getConnection("필요한 정보");
// 데이터베이스와 연결
Statement k15_stmt = k15_conn.createStatement();
// Statement -> select 등을 실행함
// Query : SQL 명령문 자바에서도 실행가능하도록 함

String k15_count = "select count(*) from gongji;";
ResultSet k15_rset = k15_stmt.executeQuery(k15_count);
//twice_stock 테이블에서 전체 데이터 수를 조회하는 query문 실행

k15_rset.next();
int k15_LineCnt_two = k15_rset.getInt(1);
//ResultSet 객체 읽어들이며 첫번째 column의 값을 k15_LineCnt_two의 값으로 설정
%>
<table border=0 width=700 cellspacing=0 align=center><tr>
<%
int currentpage = (int)((k15_from_int + k15_cnt_int -1)/k15_cnt_int);
//현재 페이지 값을 나타내는 정수형 변수 currentpage 생성
//ex) form=2 cnt=2 -> 2+2-1 = 3/2 = int(1.5) = 1
out.println("<td align=center><h1>게시판</h1></td></tr><br>");
out.println("<tr><td align=right><strong><font size=3>from : " + k15_from_int +" / cnt : " + k15_cnt_int + "</font></strong><br></td></tr>");
//form, cnt 값 변수 대입하여 유동적으로 출력 가능하게 설정
out.println("<tr>");
out.println("<td colspan=5 align=right><strong><font size=3>현재 페이지 : " + currentpage + "</font></strong><br><br></td></tr></table>");
//currentpage 변수 대입하여 현재 페이지 출력되도록 설정
%>

<table cellspacing=1 width=700 border=1 align=center>
<tr>
<td width=50><p align=center>번호</p></td>
<td width=270><p align=center>제목</p></td>
<td width=120><p align=center>파일</p></td>
<td width=200><p align=center>등록일</p></td>
<td width=70><p align=center>조회수</p></td>
</tr>
<tr>
<%
    String k15_Query = "select id, title, viewcnt, date_format(date, '%Y-%m-%d %H:%i:%s'), timestampdiff(hour, date, now()), relevel, file1, file2, file3 from gongji order by rootid desc, recnt asc;";
    k15_rset = k15_stmt.executeQuery(k15_Query);
    //gongji 테이블에서 id, title, date column의 데이터를 조회하여 id column을 기준으로 내림차순으로 조회하는 select문 실행
    
    int k15_LineCnt_one=0;
    
    while (k15_rset.next()) {
    //while문으로 ResultSet 객체 읽어들이는 동안 아래 실행문 실행
    k15_LineCnt_one++;
    //while문이 반복되는 동안 변수 k15_LineCnt_one의 값 1씩 늘어나도록 설정
    if(k15_from_int % k15_cnt_int != 0) {
        if(k15_LineCnt_one < ((int)(k15_from_int / k15_cnt_int) * k15_cnt_int +1))
            continue;
    //if조건으로 k15_from_int의 값을 k15_cnt_int의 값으로 나누었을 때 나머지 값이 0이 아닌 경우
        //k15_LineCnt_one의 값이 ((int)(k15_from_int / k15_cnt_int) * k15_cnt_int +1))보다 작으면 continue
        //ex) form=3 cnt=2 -> 3/2 = (int)1.5 = 1*2 = 2+1 = 3
    } else {
        if(k15_LineCnt_one < (((int)(k15_from_int / k15_cnt_int) -1) * k15_cnt_int +1))
            continue;
    //if 조건 만족하지 않는 경우 k15_LineCnt_one의 값이 (((int)(k15_from_int / k15_cnt_int) -1) * k15_cnt_int +1))보다 작으면 continue
        //ex) form=2 cnt=1 -> 2/1 = (int)2 = 2-1 = 1 = 1*1 = 1+1 = 2
    }

    if(k15_from_int % k15_cnt_int != 0) {
        if(k15_LineCnt_one > ((int)(k15_from_int / k15_cnt_int) * k15_cnt_int +1) + k15_cnt_int -1)
            break;
    //if조건으로 k15_from_int의 값을 k15_cnt_int의 값으로 나누었을 때 나머지 값이 0이 아닌 경우
        //k15_LineCnt_one의 값이 ((int)(k15_from_int / k15_cnt_int) * k15_cnt_int +1) + k15_cnt_int -1)보다 크면 break
        //ex) form=3 cnt=2 -> 3/2 = (int)1.5 = 1*2 = 2+1 = 3+2 = 5-1 = 4
    } else {
        if(k15_LineCnt_one > (((int)(k15_from_int / k15_cnt_int) -1) * k15_cnt_int +1) + k15_cnt_int -1)
            break;
    //if 조건 만족하지 않는 경우 k15_LineCnt_one의 값이 (((int)(k15_from_int / k15_cnt_int) -1) * k15_cnt_int +1) + k15_cnt_int -1)보다 크면 break
        //ex) form=2 cnt=1 -> 2/1 = (int)2 = 2-1 = 1*1 = 1+1 = 2+2 = 4-1 = 3
    }
    String id = Integer.toString(k15_rset.getInt(1));
	String title = k15_rset.getString(2);
    int viewcnt = k15_rset.getInt(3);
    String date = k15_rset.getString(4);
    int new_date = k15_rset.getInt(5);
    int relevel = k15_rset.getInt(6);
    String fileaddress1 = k15_rset.getString(7);
    String fileaddress2 = k15_rset.getString(8);
    String fileaddress3 = k15_rset.getString(9);
    //문자열 변수 id, title, date 생성하여 각각의 column 값을 받아옴

    out.println("<tr>");
    out.println("<td width=50><p align=center>" + id + "</p></td>");
    out.println("<td width=400><p align=left><a href=\"gongji_view.jsp?key=" + id + "\">");
    if(relevel < 1) {
        if(new_date <= 24) {
            out.println(title + "<img src=new.png width=18 height=18></a></p></td>");
        } else {
            out.println(title + "</a></p></td>");
        }
    //<a> 태그 활용하여 key 값을 변수 id의 값으로 갖게 하고 title에 gongji_view.jsp 링크에 연결되도록 설정
    } else if(relevel >= 1) {
        for( int i = 0; i < relevel; i++) {
            out.print("&nbsp&nbsp");
        }
        if (relevel != 0) {
            if(new_date <= 24) {
                out.println("<img src=reply.png>" + title + "<img src=new.png width=18 height=18></a></p></td>");
            } else {
                out.println("<img src=reply.png>" + title + "</a></p></td>");
            }
        }
    }
    out.println("<td width=50><p align=center>");
    if(fileaddress1 != null) out.println("<img src=download.png width=18 height=18>");
    if(fileaddress2 != null) out.println("<img src=download.png width=18 height=18>");
    if(fileaddress3 != null) out.println("<img src=download.png width=18 height=18>");

    out.println("</p></td>");
    out.println("<td width=160><p align=center>" + date + "</p></td>");
    out.println("<td width=50><p align=center>" + viewcnt + "</p></td>");
    }
    out.println("</tr></table>");
    out.println("<table border=0 width=700 cellspacing=0 cellpadding=5 align=center><tr>");
    //페이지 이동 번호 출력되는 테이블 생성하여 border를 0으로 설정

    out.println("<td width=650 colspan=5 align=center><a href=\"gongji_list.jsp?from=1&cnt=" + k15_cnt_int + "\"> << </a>");
    //<< 클릭하면 from=1로 이동하도록 설정

    if(k15_from_int < k15_page_print_num) {
        out.println("<a href=\"gongji_list.jsp?from=1&cnt=" + k15_cnt_int + "\"> < </a>");
    //if조건으로 k15_from_int의 값이 k15_page_print_num보다 작으면 < 클릭하면 from의 값이 1, cnt의 값이 k15_cnt_int가 되도록 설정
    } else {
        out.println("<a href=\"gongji_list.jsp?from=" + ((int)((k15_from_int / k15_page_print_num)-1) * k15_page_print_num +1) + "&cnt=" + k15_cnt_int + "\"> < </a>");
    //if조건에 부합하지 않으면 from의 값이 ((int)((k15_from_int / k15_page_print_num)-1) * k15_page_print_num +1)가 되도록 설정
    //ex) k15_page_print_num=20 from=30 -> 30/20 = 1.5-1 =(int)0.5 = 0*20 = 0+1 = 1
    }
    int k15_start = (int) (k15_from_int / k15_page_print_num) * k15_page_num + 1;
    //정수 변수 k15_start의 값을 (int) ((k15_from_int / k15_page_print_num) * k15_page_num + 1)로 설정
    //ex)from=5 k15_page_print_num=20 -> 5/20 = (int)0.25 = 0*20 = 0+1 = 1

    for (int i = k15_start; i < (k15_start + k15_page_num) ; i++) {
    //for문으로 정수 i의 값이 k15_start와 같을 때 (k15_start + k15_page_num)의 값보다 작은 동안 1씩 더해지도록 설정
        if(i == currentpage) {
            out.println("<strong><a href=\"gongji_list.jsp?from=" + ((i-1)*k15_cnt_int+1) + "&cnt=" + k15_cnt_int + "\" style=\"margin:0 10px;\"><span style=\"color:#96ddf3; font-size:20pt; BORDER-BOTTOM: #96ddf3 2px solid;\">" + i + "</span></a></strong>");
        //if조건으로 i의 값이 currentpage(현재페이지)와 일치할 때 i에 span style 설정하여 구분되게 함
        } else {
            out.println("<strong><a href=\"gongji_list.jsp?from=" + ((i-1)*k15_cnt_int+1) + "&cnt=" + k15_cnt_int + "\" style=\"margin:0 10px;\"> " + i + "</a></strong>");
        //if조건에 부합하지 않은 경우 아무런 스타일도 지정하지 않은 채 i의 값 출력
        }
        if (k15_LineCnt_two % k15_cnt_int == 0 && (int)(k15_LineCnt_two / k15_cnt_int) == i) {
            break;
        //k15_LineCnt_two를 k15_cnt_int로 나눈 나머지 값이 0이고(AND) k15_LineCnt_two를 k15_cnt_int로 나눈 후 정수형으로 형변환한 값이 i면 빠져나오도록 break문 설정
        //출력되는 페이지에 딱 맞게 데이터가 있는 경우의 break문 설정에 해당
        } else if (k15_LineCnt_two % k15_cnt_int != 0 && (int)((k15_LineCnt_two / k15_cnt_int)+1) == i) {
            break;
        //k15_LineCnt_two를 k15_cnt_int로 나눈 나머지 값이 0이 아니고(AND) k15_LineCnt_two를 k15_cnt_int로 나눈 후 +1하여 정수형으로 형변환한 값이 i면 빠져나오도록 break문 설정
        //출력되는 페이지에 모자라게 데이터가 있는 경우의 break문 설저엥 해당(ex: 한 페이지당 5개의 데이터 있어야 하지만 3개만 있는 경우)
        }
    }

    if((int)((k15_from_int / k15_page_print_num)+1) * k15_page_print_num +1 > k15_LineCnt_two) {
    //if조건으로 k15_LineCnt_two의 값보다 (int)((k15_from_int / k15_page_print_num)+1) * k15_page_print_num +1의 값이 큰 경우에 따른 실행문 설정
    //k15_LineCnt_two : twice_stock에 존재하는 데이터의를 총 카운트 한 값
    //from=10 k15_page_print_num=20 -> 10/20 = 0.5+1 = (int)1.5 = 1*20 = 20+1 = 21
        if(k15_LineCnt_two % k15_cnt_int == 0) {
            out.println("<a href=\"gongji_list.jsp?from=" + (((int)(k15_LineCnt_two / k15_cnt_int) -1) * k15_cnt_int +1) + "&cnt=" + k15_cnt_int + "\"> > </a>");
        //하위 if조건으로 k15_LineCnt_two를 k15_cnt_int로 나눈 나머지 값이 0인 경우의 from 값을 설정하여 > 클릭시 적용
        //k15_LineCnt_two=20 k15_cnt_int=2 -> 20/2 = (int)10 = 10-1 = 9*2 = 18+1 = 19
        } else {
            out.println("<a href=\"gongji_list.jsp?from=" + ((int)(k15_LineCnt_two / k15_cnt_int) * k15_cnt_int +1) + "&cnt=" + k15_cnt_int + "\"> > </a>");
        //하위 if조건에 부합하지 않는 경우의 from값 설정하여 > 클릭시 적용(k15_LineCnt_two를 k15_cnt_int로 나눈 나머지 값이 0이 아닌 경우)
        //k15_LineCnt_two=20 k15_cnt_int로=3 -> 20/3 = (int)6.3 = 6*3 = 18+1 = 19
        }
    } else {
        out.println("<a href=\"gongji_list.jsp?from=" + ((int)((k15_from_int / k15_page_print_num) +1) * k15_page_print_num +1) + "&cnt=" + k15_cnt_int + "\"> > </a>");
    //상위 if조건에 부합하지 않는 경우의 from 값 설정하여 > 클릭시 적용
    //from=10 k15_page_print_num=20 k15_LineCnt_two=40 -> 10/20 = 0.5+1 = (int)1.5 = 1*20 = 20+1 = 21
    }
    
    if (k15_LineCnt_two % k15_cnt_int == 0) {
        out.println("<a href=\"gongji_list.jsp?from=" + (((int)(k15_LineCnt_two / k15_cnt_int) -1) * k15_cnt_int +1) + "&cnt=" + k15_cnt_int + "\"> >> </a>");
    //if조건으로 k15_LineCnt_two를 k15_cnt_int로 나눈 나머지 값이 0인 경우의 from 값을 설정하여 >> 클릭시 적용
    //k15_LineCnt_two=20 k15_cnt_int=2 -> 20/2 = (int)10 = 10-1 = 9*2 = 18+1 = 19
    } else {
        out.println("<a href=\"gongji_list.jsp?from=" + ((int)(k15_LineCnt_two/ k15_cnt_int) * k15_cnt_int +1) + "&cnt=" + k15_cnt_int + "\"> >> </a>");
    //if조건에 부합하지 않는 경우의 from 값을 설정하여 >> 클릭시 적용(k15_LineCnt_two를 k15_cnt_int로 나눈 나머지 값이 0이 아닌 경우)
    //k15_LineCnt_two=20 k15_cnt_int=3 -> 20/3 = (int)6.3 = 6*3 = 18+1 = 19
    }
    out.println("</td>");

    k15_rset.close();
	k15_stmt.close();
	k15_conn.close();
   //DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>

<td><input type=submit value="신규" OnClick="location.href='gongji_insert.jsp'"></td>
<%-- '신규' 버튼 생성하여 클릭하면 form 실행되도록 설정 --%>
</tr>
</form>
</table>
</BODY>
</HTML>
