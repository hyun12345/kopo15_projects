<!--k15전아현 / 2018.07.20.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<HTML>
<HEAD>
<title>*후보등록</title>

<script language="JavaScript">
    // 특수문자 체크 함수
      function checkSpecial(str) {
          //문자열 변수 대입하는 checkSpecial 함수 생성
          var specialstring = /[~!@\#$%<>^&*\()\-=+_\’]/gi;
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
     
      // 공백 체크 함수
      function checkSpace(str) {
        //문자열 변수 대입하는 checkSpace 함수 생성
         if(str.search(/\s/) != -1) {
            //.search(/\s/) : 정규식 검색에서 첫 번째로 공백과 일치하는 부분 문자열을 찾는 메소드
            // /\s/ : 공백 문자
            return true;
            //if 조건으로 true인 경우 true 값 반환하도록 설정
         } else {
             false;
            //else문으로 그 외의 경우 false 값 반환하도록 설정
         }
      }

      //추가 버튼 클릭시 실행되는 함수
      function submitForm(){
          var name = check_form.name.value;
          //변수 name 생성하여 그 값을 check_form이라는 이름의 form 에서 name 변수의 값을 받아온 것으로 설정

          if(name == ""){
            alert("이름을 입력하세요.");
            check_form.name.value="";
            check_form.name.focus();
            return false;
            //if 조건으로 name의 값이 입력되지 않았을 때 이와 같은 경고창을 띄우고 false 값 반환
          } else if(checkSpace(name) == true) {
              alert("이름에 공백을 입력할 수 없습니다.");  
              check_form.name.value="";
              check_form.name.focus();
              return false;
            //else if 조건으로 name 변수를 checkSpace 함수에 대입하여 true 값을 반환할 경우의 조건식 설정
            //공백이 입력되는 경우 이와 같은 경고창을 띄우고 name의 값을 ""로 설정하고 false값 반환
          } else if(name.length > 10) {
              alert("이름은 최대 10자까지 입력 가능합니다.");  
              check_form.name.value="";
              check_form.name.focus();
              return false;
            //else if 조건으로 name 변수의 글자 수가 10이 넘으면 이와 같은 경고창을 띄우고 name의 값을 ""로 설정하고 false값 반환
          } else if(checkSpecial(name) == false) {
              alert("이름에 특수문자를 입력할 수 없습니다.");
              check_form.name.value="";
              check_form.name.focus();
              return false;
            //else if 조건으로 name 변수를 checkSpecial 함수에 대입하여 true 값을 반환할 경우의 조건식 설정
            //특수문자가 입력되는 경우 이와 같은 경고창을 띄우고 name의 값을 ""로 설정하고 false값 반환  
          } else{
                  check_form.action = "A_03.jsp";
                  //check_form form의 파라미터 전송 대상을 A_03.jsp로 지정
                  check_form.submit();                
                  //check_form form의 파라미터 전송
          }
      }
</script>
</HEAD>

<BODY>
<%
Class.forName("com.mysql.jdbc.Driver");
// "com.mysql.jdbc.Driver" 클래스가 메모리에 로드됨
// 필요없는 기능이므로 주석처리해도 실행 가능
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
// Connection 객체명 = DriverManger.getConnection("필요한 정보");
// 데이터베이스와 연결
Statement k15_stmt = k15_conn.createStatement();
// Statement -> select 등을 실행함
// Query : SQL 명령문 자바에서도 실행가능하도록 함


%>

<table border=1 height=50 width=600 cellspacing=0 cellpadding=5>
<tr><td height=50 width=200 align=center bgcolor=yellow><a href="A_01.jsp"><font size=5>후보등록</font></a></td>
<td height=50 width=200 align=center><font size=5><a href="B_01.jsp">투표</a></font></td>
<td height=50 width=200 align=center><font size=5><a href="C_01.jsp">개표결과</a></font></td></tr>
</table>

<h1>후보등록</h1>
<br><br>

<table border=1 width=600 cellspacing=0 width=600>


<%
    int startID = 1;
    int newID = 0;
    int minID = 0; 
    int midID = 0;
    int maxID = 0;
    //정수 변수 startID 생성하여 auto_increment default 값으로 설정한 1로 값 설정
    //정수 변수 newID, minID, midID, maxID 생성하여 각각 초기값을 0으로 설정
    
    ResultSet k15_rset = k15_stmt.executeQuery("select min(id + 1) from hubo_table where (id + 1) not in (select id from hubo_table);");
    //(id +1)의 최소값이 hubo_table의 id column에 없을 때 id+1의 최소값을 조회
    k15_rset.next();
    midID = k15_rset.getInt(1);
    //midID, 즉 id의 중간값을 첫번째 column 값 받아와 저장
    
    k15_rset = k15_stmt.executeQuery("select min(id) from hubo_table;");
    //hubo_table에서 id의 최소값을 조회
    k15_rset.next();
    minID = k15_rset.getInt(1);
    //minID, 즉 id의 최소값을 첫번째 column 값 받아와 저장 
    
    k15_rset = k15_stmt.executeQuery("select max(id) from hubo_table;");
    //hubo_table에서 id의 최대값을 조회
    k15_rset.next();
    maxID = k15_rset.getInt(1);
    //maxID, 즉 id의 최대값을 첫번째 column 값 받아와 저장
    
    if (minID > startID) { //startID보다 minID의 값이 클 때 newID의 값을 startid의 값으로 설정
        newID = startID;
    } else if (maxID == 0) { //newID중간값이 최대값이 0일 때 newID의 값을 startID의 값으로 설정
        newID = startID;
    } else if (midID < maxID) { //midID의 값이 maxID보다 작을 때 newID의 값을 midID의 값으로 설정
        newID = midID;
    } else if (maxID >= startID){ //maxID의 값이 startID의 값보다 크거나 같으면 newID의 값을 maxID+1의 값로 설정
        newID = (maxID + 1);
    } else { // 그 외의 경우 newID의 값을 startid의 값으로 설정
        newID = startID;
    }
%>

<%
    String k15_Query = "select * from hubo_table;";
    k15_rset = k15_stmt.executeQuery(k15_Query);
    //hubo_table에서 전체 데이터를 조회하는 select문 실행
    
    while (k15_rset.next()) {
    String id = Integer.toString(k15_rset.getInt(1));
	String name = k15_rset.getString(2);
    //문자열 변수 id, name 생성하여 각각의 column 값을 받아옴
	
    out.println("<form method=\"post\" action=\"A_02.jsp\">");
    //post 방식 : html 페이지에 form 형태에서 값을 전달 / A_02.jsp 페이지에서 실행
    out.println("<tr><td align=center>");
    out.println("기호 : <input type=\"number\" name=\"id\" value=\"" + id + "\" readonly>");
    out.println("이름 : <input type=\"text\" name=\"name\" value=\"" + name + "\" readonly>");
    //각각 number, text 형식으로 값을 입력하며 받는 값의 이름을 id, name으로 설정하고 그 값을 id, name 변수로 설정 
    //입력 불가능(read only)
    out.println("<input type=\"submit\" value=\"삭제\"></form>");
    //'삭제' 버튼을 클릭하면 실행되도록 설정
    out.println("</tr></td>");
    }

    k15_rset.close();
	k15_stmt.close();
	k15_conn.close();
   //DB에 연결하기 위해 생성하였던 각 객체 닫아줌
%>

<tr><td align=center>
<form method="post" name="check_form">
<%-- <%-- post 방식 : html 페이지에 form 형태에서 값을 전달 / form 이름을 check_form로 설정 --%>
기호 : <input type="number" name="id" value="<%= newID%>" readonly>
<%-- number로 입력받는 id의 값을 newID 변수를 받아 설정하며 입력 불가능 하도록 설정 --%>
이름 : <input type="text" name="name" placeholder="이름을 입력하십시오." required>
<%-- text로 입력받는 name의 칸에 '이름을 입력하십시오.' 문장이 출력되도록 설정하며 필수 입력사항으로 설정(required) --%>
<input type="button" value="추가" onClick="submitForm()">
<%-- '추가' button 클릭시 submitForm() 함수 실행하도록 설정 --%>
</form>
</tr></td>
</table>

</BODY>

</HTML>
