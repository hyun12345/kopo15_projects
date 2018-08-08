<!--k15전아현 / 2018.07.27.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>


<HTML>
<HEAD>
<title>*게시글쓰기</title>
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
            width:600,
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
            ]         // 한국어 지정(기본값은 en-US)
		});
	});
</script>


<script language="JavaScript">
 //문자열 변수 대입하는 checkSpecial 함수 생성
 function checkSpecial(str) {
          var specialstring = /[<|>|;]/gi;
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

    //파일 사이즈 체크 위한 CheckUploadFileSize 함수 생성
    function CheckUploadFileSize(file) {
        if(file.value == '') {
            return true;
        }
        //if 조건으로 file의 값이 없으면(file 선택하지 않으면) true 값 반환
        
        var LimitSize = 5 * 1024 * 1024; 
        //LimitSize 변수 생성하여 최대 파일 크기 5 MB로 값 설정
        var FileSize = file.files[0].size;
        //FileSize 변수 생성하여 파일의 사이즈 값을 값으로 설정
       
        if (FileSize <= LimitSize) {
            return true;
        //if 조건으로 FileSize의 값이 LimitSize보다 작거나 같으면 true 값 반환
        } else {
            return false;
        }
    }

    //'신규' 버튼 클릭시 실행되는 함수
    function submitForm(){
    var title = gongji_insert.title.value;
    
    var filecheck1 = gongji_insert.file1;
    var filecheck2 = gongji_insert.file2;
    var filecheck3 = gongji_insert.file3;

        if(title == "" || title == null){
        alert("제목을 입력하세요.");
        gongji_insert.title.value="";
        gongji_insert.title.focus();
        return false;
        //if 조건으로 title 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
        } else if (title.substr(0,1) == ' ') {
        alert("첫 글자에 공백은 올 수 없습니다.");  
        gongji_insert.title.value="";
        gongji_insert.title.focus();
        return false;
        //else if 조건으로 title의 첫글자가 ' '인 경우 경고창을 띄우고 false 값 반환
        } else if(checkSpecial(title) == false) {
        alert("제목에 '<,>,;' 특수문자를 입력할 수 없습니다.");
        gongji_insert.title.value="";
        gongji_insert.title.focus();
        return false;
        } else if(content == "" || content == null){
        alert("내용을 입력하세요.");
        gongji_insert.content.value="";
        gongji_insert.content.focus();
        return false;
        //else if 조건으로 content 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
        } else if(CheckUploadFileSize(filecheck1) == false) {
        alert("파일1의 용량이 5MB보다 큽니다.");
        filecheck1.value='';
        filecheck1.focus();
        return false;
        } else if(CheckUploadFileSize(filecheck2) == false) {
        alert("파일2의 용량이 5MB보다 큽니다.");
        filecheck2.value='';
        filecheck2.focus();
        return false;
        } else if(CheckUploadFileSize(filecheck3) == false) {
        alert("파일3의 용량이 5MB보다 큽니다.");
        filecheck3.value='';
        filecheck3.focus();
        return false;
        } else {
        gongji_insert.content.value = $('#content').summernote('code');
        gongji_insert.action = "gongji_write.jsp?key=INSERT";
        //gongji_write form의 파라미터 전송 대상을 gongji_write.jsp?key=INSERT로 지정
        gongji_insert.submit();                
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

String k15_date = "select date_format(now(), '%Y-%m-%d %H:%i:%s');";
ResultSet k15_rset = k15_stmt.executeQuery(k15_date);
k15_rset.next();
String date = k15_rset.getString(1);
//now() : 현재 연월일 시분초 조회
//date_format(now(), '%Y-%m-%d') : 현재 연월일 시분초를 YYYY-mm-dd 형태로 조회
%>

<form method=post name=gongji_insert enctype="multipart/form-data">
<%-- form의 이름을 gongji_write로 설정 --%>
<table width=700 border=1 cellspacing=0 cellpadding=5 align=center>
<tr>
<td align=center><b>번호</b></td>
<td>신규(insert)<input type=hidden name=key value="INSERT" readonly></td>
<%-- 번호(id)의 경우 auto_increment 설정이 되어있으므로 입력불가능(readonly) 설정 뒤 value는 INSERT를 갖도록 설정 --%>
<%-- type=hidden : 사용자에게 보이지 않지만 서버로 넘어가는 필드 --%>
</tr>
<tr>
<td align=center><b>제목</b></td>
<td><input type=text name=title size=70 maxlength=70 placeholder="제목을 입력하십시오." required></td>
<%-- type=text : 텍스트 형태로 입력 받음 / size=70 : 폭 70px / 최대 문자 길이 : maxlength / 필수입력사항(required) --%>
</tr>
<tr>
<td align=center><b>일자</b></td>
<%
out.println("<td>" + date + "<input type=hidden name=date value=" + date + " readonly></td>");
//입력 불가능한(readonly) hidden type으로 생성하여 value를 date로 설정
%>
</tr>
<tr>
<td align=center><b>내용</b></td>
<td><div id=content></div>
<input type=hidden name=content value=""></td>
</tr>
<tr>
<td align=center><b>파일 첨부</b></td>
<td>
<form method=post action=gongji_write.jsp>
<%-- enctype : 서버에 폼 데이터를 전송시 인코딩 방식을 지정함 / multipart/form-data : 전송 데이터를 인코딩하지 않으며 업로드할 때 사용 --%>
<input type=file name=file1><br>
<input type=file name=file2><br>
<input type=file name=file3><br>
<%-- accept=image/* : 이미지 파일만 선택 창에서 볼 수 있도록 지정 / onchange : 포커스 잃을 때 발생 --%>
</td>
</tr>
</form>
</table>
<table width=700 align=center>
<tr>
<td width=650></td>
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
