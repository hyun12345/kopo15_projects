<!--k15전아현 / 2018.07.26.-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- 기존에 만들어진 문서들과의 호환성 유지하기 위해 사용 / html 버전별로 지원 태그 다르므로 선언 --%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>


<HTML>
<HEAD>
<title>*㈜트와이스 재고 현황-상품등록</title>

<script language="JavaScript">
    //문자열 변수 대입하는 checkID 함수 생성
    function checkID(str) {
        var idstring = /^[0-9a-zA-Z]*$/;
        //변수 idstring 값을 숫자와 영어 문자의 값을 가지는 정규표현식으로 설정
        if(idstring.test(str)) {
            //.test(str) : str에 해당 패턴이 있는지 여부를 나타내는 메소드
            return true;
        } else {
            return false;
        }
    }

    //문자열 변수 대입하는 checkIDLength 함수 생성
    function checkIDLength(str) {
        if(str.length < 15) {
            //.length : 문자열 변수의 문자 길이를 나타냄
            //14자 넘어가지 않도록 범위 설정하여 true 값 반환
            return true;
        } else {
            return false;
        }
    }

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

    //이미지 파일 업로드 위한 uploadImage 함수 생성
    function uploadImage(event) {
        var k15_fr = new FileReader();
        //FileReader 객체 k15_fr 생성
        k15_fr.onload = function() {
        //.onload : 문서가 완벽히 로딩되었을 때 사용할 수 있는 함수
        var output = document.getElementById('output');
        //변수 output 생성하여 그 값을 문서의 id 값을 가져오는 document.getElementById() 활용
        output.src = k15_fr.result;
        //output.src(소스)의 값을 파일의 결과값 가져오도록 설정
        }
        k15_fr.readAsDataURL(event.target.files[0]);
        //readAsDataURL() : 업로드 파일 경로 읽어오는 함수
        //event.target.files[0] : 선택한 파일 가져옴(읽어옴)
    }

    //파일 확장자명 체크 위한 checkFile 함수 생성
    function checkFile(file){
       var filechecking = file.substr(file.lastIndexOf(".")).toLowerCase();
       //변수 filechecking 생성하여 substr()함수 활용하여대입한 파일의 . 앞까지만 문자를 자름 
       //toLowerCase() 함수 활용하여 모두 소문자로 변환
       
        if(file == '') {
            return true;
        }
        //if 조건으로 file의 값이 없으면(file 선택하지 않으면) true값 반환

        if (filechecking == '.png' || filechecking == '.jpg'||
            filechecking == '.jpeg' || filechecking == '.gif') {
            return true;
        //filechecking의 값이 위의 if 조건에 부합하면 true 반환
        } else {
            return false;
        }
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

    //'신규등록' 버튼 클릭시 실행되는 함수
    function submitForm(){
    var id = twice_insert.id.value;
    var stock_count = twice_insert.stock_count.value;

    var name = twice_insert.name.value;
    var content = twice_insert.content.value;

    var image_file = twice_insert.imagefile.value;
    var filecheck = twice_insert.imagefile;
    //변수 id, stock_count, name, content, image_file, filecheck 생성하여 
    //그 값을 twice_insert 이름의 form 에서 받아온 것으로 설정

        if(id == "" || id == null) {
        alert("상품 번호를 입력하세요.");
        twice_insert.id.value="";
        twice_insert.id.focus();
        return false;
        //if 조건으로 id의 값이 없는 경우 경고창을 띄우고 false 값 반환
        } else if (checkID(id) == false) {
        alert("상품 번호는 숫자와 영어만 입력 가능합니다.");  
        twice_insert.id.value="";
        twice_insert.id.focus();
        return false;
        //else if 조건으로 id의 값을 checkID() 함수에 대입하여 false를 반환하는 경우 경고창을 띄우고 false 값 반환
        } else if (checkIDLength(id) == false) {
        alert("상품 번호는 14자까지 입력 가능합니다.");  
        twice_insert.id.value="";
        twice_insert.id.focus();
        return false;
        //else if 조건으로 id의 값을 checkIDLength() 함수에 대입하여 false를 반환하는 경우 경고창을 띄우고 false 값 반환
        } else if(name == "" || name == null) {
        alert("상품명을 입력하세요.");
        twice_insert.name.value="";
        twice_insert.name.focus();
        return false;
        //else if 조건으로 name 값이 없는 경우 경고창을 띄우고 false 값 반환
        } else if (name.substr(0,1) == ' ') {
        alert("상품명 첫 글자에 공백은 올 수 없습니다.");  
        twice_insert.name.value="";
        twice_insert.name.focus();
        return false;
        //else if 조건으로 name 첫글자가 ' '인 경우 경고창을 띄우고 false 값 반환
        } else if(checkSpecial(name) == false) {
        alert("상품명에 '<, >, ;' 특수문자를 입력할 수 없습니다.");
        twice_insert.name.value="";
        twice_insert.name.focus();
        return false;
        //else if 조건으로 name 변수를 checkSpecial 함수에 대입하여 false를 반환할 경우 경고창을 띄우고 false 값 반환
        } else if(stock_count == '' || stock_count == null) {
        alert("재고 현황을 입력하세요.");
        twice_insert.stock_count.value='';
        twice_insert.stock_count.focus();
        return false;
        //else if 조건으로 stock_count 값이 없는 경우 경고창을 띄우고 false 값 반환
        } else if(stock_count < 0) {
        alert("재고 현황은 0 이상의 값이어야 합니다.");
        twice_insert.stock_count.value='';
        twice_insert.stock_count.focus();
        return false;
        //else if 조건으로 stock_count 값이 음수인 경우 경고창을 띄우고 false 값 반환
        } else if(stock_count >= 999999999) {
        alert("재고 현황의 값이 너무 큽니다.(최대값 : 999,999,999)");
        twice_insert.stock_count.value='';
        twice_insert.stock_count.focus();
        return false;
        //else if 조건으로 stock_count 값이 999999999보다 큰 경우 경고창을 띄우고 false 값 반환
        } else if(checkSpecial(content) == false) {
        alert("상품설명에 '<, >, ;' 특수문자를 입력할 수 없습니다.");
        twice_insert.content.value="";
        twice_insert.content.focus();
        return false;
        //else if 조건으로 content 변수를 checkSpecial 함수에 대입하여 false를 반환할 경우 경고창을 띄우고 false 값 반환
        } else if(content == "" || content == null) {
        alert("상품설명을 입력하세요.");
        twice_insert.content.value="";
        twice_insert.content.focus();
        return false;
        //else if 조건으로 content 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
        } else if(checkFile(image_file) == false) {
        alert("이미지 파일만 업로드 가능합니다.");
        twice_insert.image_file.value='';
        twice_insert.image_file.focus();
        return false;
        //else if 조건으로 image_file 변수를 checkFile 함수에 대입하여 false를 반환할 경우 경고창을 띄우고 false 값 반환
        } else if(CheckUploadFileSize(filecheck) == false){
        alert("파일 용량이 5MB보다 큽니다.");
        filecheck.value='';
        filecheck.focus();
        return false;
        } else {
        twice_insert.action = "twice_write.jsp?key=INSERT";
        twice_insert.submit();                
        //twice_insert form의 파라미터 전송
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

String k15_date = "select date_format(now(), '%Y-%m-%d %H:%i');";
ResultSet k15_rset = k15_stmt.executeQuery(k15_date);
//now() : 현재 연월일 시분초 조회
//date_format(now(), '%Y-%m-%d %H:%i') : 현재 연월일 시분초를 YYYY-mm-dd HH:mi 형태로 조회
%>
<table cellspacing=0 width=750 border=1>
<tr>
<td align=center><h1>㈜트와이스 재고 현황-상품등록</h1></td></tr>
<tr><td align=center>
<br>
<form method=post name=twice_insert enctype="multipart/form-data">
<%-- form의 이름을 twice_insert 설정 --%>
<table width=700 border=1 cellspacing=0 cellpadding=5>
<tr>
<td width=100><b>상품 번호</b></td>
<td width=600><input type=text name=id style='width:200px;' placeholder="상품번호를 입력하십시오." required>
<input type=hidden name=key value="INSERT" readonly></td>
<%-- type=hidden : 사용자에게 보이지 않지만 서버로 넘어가는 필드 --%>
</tr>
<tr>
<td width=100><b>상품명</b></td>
<td width=600><input type=text name=name style='width:200px;' maxlength=20 placeholder="상품명을 입력하십시오." required></td>
<%-- type=text : 텍스트 형태로 입력 받음 / size=70 : 폭 70px / 최대 문자 길이 : maxlength / 필수입력사항(required) --%>
</tr>
<tr>
<td width=100><b>재고 현황</b></td>
<td width=600><input type=number name=stock_count style='width:200px;' placeholder="재고 현황을 입력하십시오." required></td>
</tr>
<tr>
<td width=100><b>상품등록일</b></td>
<%
k15_rset.next();
String date = k15_rset.getString(1);
//ResultSet 객체 읽어들여 문자열 변수 date 생성한 뒤 첫번째 column 값 받아옴
out.println("<td width=600>" + date + "<input type=hidden name=insert_date value=" + date + " readonly></td>");
//입력 불가능한(readonly) hidden type으로 생성하여 value를 date로 설정
%>
</tr>
<tr>
<td width=100><b>재고등록일</b></td>
<%
out.println("<td width=600>" + date + "<input type=hidden name=update_date value=" + date + " readonly></td>");
%>
</tr>
<tr>
<td width=100><b>상품설명</b></td>
<td width=600><textarea style="width:400px; height:20px;" name=content cols=50 row=10 placeholder="상품설명을 입력하십시오." required>
</textarea></td>
<%-- textarea의 넓이를 400px, 높이를 20px로 설정 / cols : 가로 텍스트 수 & rows : 세로 텍스트 수 --%>
</tr>
<tr>
<td><b>상품사진</b></td>
<td>
<table width=550 border=0 cellspacing=0 cellpadding=5>
<tr>
<td>
<img id="output" width="260" height="200">
<%-- uploadImage() 함수에 대입하기 위해 id를 output으로 설정하여 즉시 화면에 출력 가능하도록 설정 --%>
</td>
<td>
<form method=post action=twice_write.jsp enctype="multipart/form-data">
<%-- enctype : 서버에 폼 데이터를 전송시 인코딩 방식을 지정함 / multipart/form-data : 전송 데이터를 인코딩하지 않으며 업로드할 때 사용 --%>
<input type=file name=imagefile accept="image/*" OnChange="uploadImage(event);">
<%-- accept=image/* : 이미지 파일만 선택 창에서 볼 수 있도록 지정 / onchange : 포커스 잃을 때 발생 --%>
<br><br>
<input type=text name=imagefilename placeholder="이미지파일 저장명 입력">
</td>
</tr>
<br><br></td></tr>
</table></table>
<br>
<table width=700>
<tr>
<td width=650></td>
<td><input type=button value="취소" OnClick="location.href='twice_list.jsp'"></td>
<%-- '취소' 버튼 생성하여 클릭하면 twice_list.jsp 페이지로 이동하도록 설정 --%>
<td><input type=button value="완료" OnClick="submitForm()"></td>
<%-- '완료' 버튼 생성하여 클릭하면 submitForm() --%>
</tr></table></form></table>
<%
k15_rset.close();
k15_stmt.close();
k15_conn.close();
//DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>
</BODY></HTML>