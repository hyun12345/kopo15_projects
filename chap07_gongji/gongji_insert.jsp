<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD>
<title>*게시글쓰기</title>
<script language="JavaScript">
 //문자열 변수 대입하는 checkSpecial 함수 생성
 function checkSpecial(str) {
          var specialstring = /[<>;]/gi;
           //변수 specialstring의 값을 '<>;'의 특수문자 정규표현식으로 설정
          var isValid = true;
          //변수 isValid의 값을 true로 설정
          if(specialstring.test(str)) {
            //.test(str) : str에 해당 패턴이 있는지 여부를 나타내는 메소드
              isValid = false;
            //대입한 변수에 특수문자가 존재하면 false값을 isValid 변수의 값으로 저장
          }
          return isValid;
        //isValid 변수 반환   
      }

    //'신규' 버튼 클릭시 실행되는 함수
    function submitForm(){
    var title = gongji_write.title.value;
    var content = gongji_write.content.value;
    //변수 title, content 생성하여 그 값을 gongji_write 이름의 form 에서 title, content 값을 받아온 것으로 설정

        if(title == "" || title == null){
        alert("제목을 입력하세요.");
        gongji_write.title.value="";
        gongji_write.title.focus();
        return false;
        //if 조건으로 title 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
        } else if (title.substr(0,1) == ' ') {
        alert("첫 글자에 공백은 올 수 없습니다.");  
        gongji_write.title.value="";
        gongji_write.title.focus();
        return false;
        //else if 조건으로 title의 첫글자가 ' '인 경우 경고창을 띄우고 false 값 반환
        } else if(checkSpecial(title) == false) {
        alert("제목에 '<, >, ;' 특수문자를 입력할 수 없습니다.");
        gongji_write.title.value="";
        gongji_write.title.focus();
        return false;
        //else if 조건으로 title 변수를 checkSpecial 함수에 대입하여 true 값을 반환할 경우의 조건식 설정
        //특수문자가 입력되는 경우 이와 같은 경고창을 띄우고 title 값을 ""로 설정하고 false값 반환  
        } else if(checkSpecial(content) == false) {
        alert("내용에 '<, >, ;' 특수문자를 입력할 수 없습니다.");
        gongji_write.content.value="";
        gongji_write.content.focus();
        return false;
        //else if 조건으로 content 변수를 checkSpecial 함수에 대입하여 true 값을 반환할 경우의 조건식 설정
        //특수문자가 입력되는 경우 이와 같은 경고창을 띄우고 title 값을 ""로 설정하고 false값 반환  
        } else if(content == "" || content == null){
        alert("내용을 입력하세요.");
        gongji_write.content.value="";
        gongji_write.content.focus();
        return false;
        //else if 조건으로 content 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
        }else{
        gongji_write.action = "gongji_write.jsp?key=INSERT";
        //gongji_write form의 파라미터 전송 대상을 gongji_write.jsp?key=INSERT로 지정
        gongji_write.submit();                
        //gongji_write form의 파라미터 전송
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

String k15_date = "select date_format(now(), '%Y-%m-%d');";
ResultSet k15_rset = k15_stmt.executeQuery(k15_date);
//now() : 현재 연월일 시분초 조회
//date_format(now(), '%Y-%m-%d') : 현재 연월일 시분초를 YYYY-mm-dd 형태로 조회
%>

<form method=post name=gongji_write>
<%-- form의 이름을 gongji_write로 설정 --%>
<table width=650 border=1 cellspacing=0 cellpadding=5>
<tr>
<td><b>번호</b></td>
<td>신규(insert)<input type=hidden name=key value="INSERT" readonly></td>
<%-- 번호(id)의 경우 auto_increment 설정이 되어있으므로 입력불가능(readonly) 설정 뒤 value는 INSERT를 갖도록 설정 --%>
<%-- type=hidden : 사용자에게 보이지 않지만 서버로 넘어가는 필드 --%>
</tr>
<tr>
<td><b>제목</b></td>
<td><input type=text name=title size=70 maxlength=70 placeholder="제목을 입력하십시오." required></td>
<%-- type=text : 텍스트 형태로 입력 받음 / size=70 : 폭 70px / 최대 문자 길이 : maxlength / 필수입력사항(required) --%>
</tr>
<tr>
<td><b>일자</b></td>
<%
k15_rset.next();
String date = k15_rset.getString(1);
//ResultSet 객체 읽어들여 문자열 변수 date 생성한 뒤 첫번째 column 값 받아옴
out.println("<td>" + date + "<input type=hidden name=date value=" + date + " readonly></td>");
//입력 불가능한(readonly) hidden type으로 생성하여 value를 date로 설정
%>
</tr>
<tr>
<td><b>내용</b></td>
<td><textarea style="width:500px; height:250px;" name=content cols=70 row=600 placeholder="내용을 입력하십시오." required></textarea></td>
<%-- textarea의 넓이를 500, 높이를 250으로 설정 / cols : 가로 텍스트 수 & rows : 세로 텍스트 수 --%>
</tr>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
<%-- '취소' 버튼 생성하여 클릭하면 gongji_list.jsp 페이지로 이동하도록 설정 --%>
<td><input type=button value="쓰기" OnClick="submitForm()"></td>
<%-- '쓰기' 버튼 생성하여 클릭하면 submitForm() --%>
</tr></table>
<%
k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>
</form>
</BODY></HTML>