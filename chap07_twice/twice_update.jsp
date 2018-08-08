<!--k15전아현 / 2018.07.25.-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD>
<title>*㈜트와이스 재고 현황-재고수정</title>

<script language="JavaScript">
    //숫자 변수 대입하는 checkstock_count 함수 생성
    function checkstock_count(num) {
        var stock_count_num = /^[0-9]*$/;
        //변수 stock_count_num 값을 숫자의 값을 가지는 정규표현식으로 설정
        if(stock_count_num.test(num)) {
            //.test(str) : num 해당 패턴이 있는지 여부를 나타내는 메소드
            return true;
        } else {
            return false;
        }
    }

    //'재고수정' 버튼 클릭시 실행되는 함수
    function submitForm(){
    var stock_count = twice_update.stock_count.value;
    //변수 stock_count 생성하여 그 값을 twice_update 이름의 form 에서 stock_count 값을 받아온 것으로 설정

        if(stock_count == '' || stock_count == null) {
        alert("재고 현황을 입력하세요.");
        twice_update.stock_count.value='';
        twice_update.stock_count.focus();
        return false;
        //else if 조건으로 stock_count 값이 없는 경우 경고창을 띄우고 false 값 반환
        } else if(stock_count < 0) {
        alert("재고 현황은 0 이상의 값이어야 합니다.");
        twice_update.stock_count.value='';
        twice_update.stock_count.focus();
        return false;
        //else if 조건으로 stock_count 값이 음수인 경우 경고창을 띄우고 false 값 반환
        } else if(stock_count > 999999999) {
        alert("재고 현황의 값이 너무 큽니다.(최대값 : 999,999,999)");
        twice_update.stock_count.value='';
        twice_update.stock_count.focus();
        return false;
        //if 조건으로 stock_count 값이 999999999보다 큰 경우 경고창을 띄우고 false 값 반환
        } else if (checkstock_count(stock_count) == false) {
        alert("재고 현황의 값은 숫자만 입력 가능합니다.");  
        twice_update.stock_count.value='';
        twice_update.stock_count.focus();
        return false;
        //else if 조건으로 stock_count 값을 checkstock_count() 함수에 대입하여 false를 반환하는 경우 경고창을 띄우고 false 값 반환
        } else {
        twice_update.action = "twice_write.jsp";
        //twice_write.jsp 링크로 이동
        twice_update.submit();
        //twice_update form의 파라미터 전송
        }
    }
</script></HEAD>
<BODY>

<%
request.setCharacterEncoding("utf-8");
//문자 Encoding을 utf-8로 설정하여 한글 데이터 입력 가능하도록 설정

Class.forName("com.mysql.jdbc.Driver");
//"com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
// Connection 객체명 = DriverManger.getConnection("필요한 정보");
// 데이터베이스와 연결
Statement k15_stmt = k15_conn.createStatement();
// Statement -> select 등을 실행함
// Query : SQL 명령문 자바에서도 실행가능하도록 함

String keyword_ID= request.getParameter("key");
//문자열 변수 keyword_p 생성하여 gongji_list에서 "key" 값을 받아오는 파라미터 값으로 설정

String k15_Query = "select id, name, stock_count, date_format(update_date, '%Y-%m-%d %H:%i'), content from twice_stock where id = '" + keyword_ID + "';";
ResultSet k15_rset = k15_stmt.executeQuery(k15_Query);

    k15_rset.next();
    String id = k15_rset.getString(1);
	String name = k15_rset.getString(2);
    int stock_count = k15_rset.getInt(3);
    String insert_date = k15_rset.getString(4);
    String content = k15_rset.getString(5);
    //ResultSet 객체 읽어들이며 select문으로 조회한 column 값 받아 변수의 값으로 설정
    //stock_count의 값을 정수형으로 받음
%>
<table cellspacing=0 width=750 border=1>
<tr>
<td align=center><h1>㈜트와이스 재고 현황-재고수정</h1></td></tr>
<tr><td align=center>
<br>

<form method=post name=twice_update enctype="multipart/form-data">
<%-- form의 이름을 twice_update 설정 --%>
<%-- enctype : 서버에 폼 데이터를 전송시 인코딩 방식을 지정함 / multipart/form-data : 전송 데이터를 인코딩하지 않으며 업로드할 때 사용 --%>
<table width=700 border=1 cellspacing=0 cellpadding=5>
<tr>
<%
out.println("<td width=100><b>상품 번호</b></td>");
out.println("<td width=600>" + id + "<input type=hidden name=id value=" + id + " readonly></td>");
out.println("<input type=hidden name=key value=\"UPDATE\" readonly></td>");
//입력 불가능한(readonly) hidden type으로 생성하여 value를 UPDATE로 설정
out.println("</tr>");
out.println("<tr>");
out.println("<td width=100><b>상품명</b></td>");
out.println("<td width=600>" + name + "<input type=hidden name=name value=" + name + " readonly></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width=100><b>재고 현황</b></td>");
out.println("<td width=600><input type=number name=stock_count value=" + stock_count + " required></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width=100><b>상품등록일</b></td>");
out.println("<td width=600>" + insert_date + "</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width=100><b>재고등록일</b></td>");
String k15_date = "select date_format(now(), '%Y-%m-%d %H:%i');";
ResultSet k15_rset_date = k15_stmt.executeQuery(k15_date);
k15_rset_date.next();
String update_date = k15_rset_date.getString(1);
out.println("<td width=600>" + update_date + "<input type=hidden name=update_date value=" + update_date + " readonly></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width=100><b>상품설명</b></td>");
out.println("<td width=600>"+ content + "<input type=hidden name=content value=" + content + " readonly></td></tr>");
out.println("</tr>");

out.println("<tr>");
out.println("<td width=100><b>상품사진</b></td>");
out.println("<td>");
String k15_img = "select img from twice_stock where id = '" + keyword_ID + "';";
k15_rset = k15_stmt.executeQuery(k15_img);
k15_rset.next();
String imageaddress = k15_rset.getString(1);
out.println("<table width=550 border=0 cellspacing=0 cellpadding=5>");
out.println("<tr>");
out.println("<td>");
out.println("<img src=" + imageaddress + " width=\"300\" >");
out.println("</td></tr></table>");
%>
<br><br>
</table>
<br>
<table width=700>
<tr>
<td width=650></td>
<td><input type=button value="재고수정" OnClick="submitForm()"></td>
<%-- '재고수정' 버튼 생성하여 클릭하면 submitForm() --%>
</tr></table></table></table>
<%
k15_rset_date.close();
k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>
</form>
</BODY></HTML>