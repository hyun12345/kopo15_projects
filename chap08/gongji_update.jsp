<!--k15전아현 / 2018.07.27.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD>
<title>*게시글수정</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#content').summernote({
			height: 300,
            width:500,
            minHeight: 300,      // 최소 높이값(null은 제한 없음)
            maxHeight: 300,  
			focus: true,
            lang: 'ko-KR',
            placeholder:'내용을 입력하십시오.',
            toolbar: [
            ['font', ['bold']],
            ['fontname', ['fontname']],
            ['fontsize', ['fontsize']],
            ['color', ['color']],        
            ['help', ['help']]
            ]            // 한국어 지정(기본값은 en-US)
		});
	});
</script>

<script language="JavaScript">
  //문자열 변수 대입하는 checkSpecial 함수 생성
 function checkSpecial(str) {
          var specialstring = /[<|>|;]/gi;
           //변수 specialstring의 값을 특수문자 정규표현식으로 설정
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

    //'수정' 버튼 클릭시 실행되는 함수
    function submitForm(mode){
    var title = gongji_update.title.value;
    //변수 title, content 생성하여 그 값을 gongji_update 이름의 form 에서 title, content 값을 받아온 것으로 설정

        if(title == "" || title == null){
        alert("제목을 입력하세요.");
        gongji_update.title.value="";
        gongji_update.title.focus();
        return false;
        //if 조건으로 title 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
        } else if (title.substr(0,1) == ' ') {
        alert("첫 글자에 공백은 올 수 없습니다.");  
        gongji_update.title.value="";
        gongji_update.title.focus();
        return false;
        //else if 조건으로 title의 첫글자가 ' '인 경우 경고창을 띄우고 false 값 반환
        } else if(checkSpecial(title) == false) {
        alert("제목에 '<,>,;' 특수문자를 입력할 수 없습니다.");
        gongji_update.title.value="";
        gongji_update.title.focus();
        return false;
        } else if(content == "" || content == null){
        alert("내용을 입력하세요.");
        gongji_update.content.value="";
        gongji_update.content.focus();
        return false;
        //else if 조건으로 content 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
       }else{
        if(mode == "update") {
        gongji_update.content.value = $('#content').summernote('code');
        gongji_update.action = "gongji_write.jsp";
        //mode의 값이 update와 일치하면 gongji_write.jsp 실행
        gongji_update.submit();                
        //gongji_update form의 파라미터 전송
        }
    }}
</script></HEAD>


<BODY>
<%
request.setCharacterEncoding("utf-8");
//문자 Encoding을 utf-8로 설정하여 한글 데이터 입력 가능하도록 설정

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

<form method=post name='gongji_update' enctype="multipart/form-data">
<table width=700 border=1 cellspacing=0 cellpadding=5 align=center>

<%
    String k15_Query = "select id, title, content, date_format(date, '%Y-%m-%d %H:%i:%s') as date from gongji where id = " + keyword_ID + ";";
    ResultSet k15_rset = k15_stmt.executeQuery(k15_Query);
    //gongji 테이블에서 id column의 값이 keyword_ID와 일치하는 경우 전체 데이터를 조회하는 select문 실행
    k15_rset.next();
    String id = Integer.toString(k15_rset.getInt(1));
	String title = k15_rset.getString(2);
    String content = k15_rset.getString(3);
    String date = k15_rset.getString(4);
    //ResultSet 읽어들여 문자열 변수 id, title, date, content 생성하여 각각의 column 값을 받아옴

    out.println("<tr>");
    out.println("<td align=center><b>번호</b></td>");
    out.println("<td><input type=text name=id size=70 maxlength=70 value=" + id + " readonly>");
    out.println("<input type=hidden name=key value=\"UPDATE\" readonly>");
    out.println("</td></tr>");
    out.println("<tr>");
    out.println("<td align=center><b>제목</b></td>");
    out.println("<td><input type=text name=title size=70 maxlength=70 value=\"" + title + "\" placeholder=\"제목을 입력하십시오.\" required></td></tr>");
    out.println("<tr>");
    out.println("<td align=center><b>일자</b></td>");
    out.println("<td>" + date + "<input type=hidden name=date value=" + date + " readonly></td></tr>");
    out.println("<tr>");
    out.println("<td align=center><b>내용</b></td>");
    out.println("<td><div id=content>" + content + "</div>");
    out.println("<input type=hidden name=content value=\"\"></td>");
    //title 값에 "'"가 입력한 내용 그대로 받아올 수 있도록 ""로 묶음
    //placeholder로 입력창 기본 출력문구 설정

    k15_rset.close();
	k15_stmt.close();
	k15_conn.close();
   //DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>
</table>

<table width=700 align=center>
<tr>
<td width=650></td>
<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
<td><input type=button value="수정" OnClick="submitForm('update')"></td>
<td><input type=button value="삭제" OnClick="location.href='gongji_delete.jsp?key=<%= id%>'"></td>
</tr></table>
</form>


</BODY></HTML>