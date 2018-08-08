<!--k15전아현 / 2018.06.05.-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<%
request.setCharacterEncoding("utf-8");
//입력값 한글 인코딩 될 수 있도록 설정
String name = request.getParameter("name");
//문자열 변수 k15_name의 값은 request 객체 사용하여 "username"의 값을 받아옴

String k15_studentid = request.getParameter("studentid");
if (k15_studentid == null) {
    k15_studentid = "0";
}
int studentid = Integer.parseInt(k15_studentid);

String k15_kor = request.getParameter("kor");
if (k15_kor == null) {
    k15_kor = "0";
}
int kor = Integer.parseInt(k15_kor);

String k15_eng = request.getParameter("eng");
if (k15_eng == null) {
    k15_eng = "0";
}
int eng = Integer.parseInt(k15_eng);

String k15_mat = request.getParameter("mat");
if (k15_mat == null) {
    k15_mat = "0";
}
int mat = Integer.parseInt(k15_mat);

Class.forName("com.mysql.jdbc.Driver");
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
Statement k15_stmt = k15_conn.createStatement();

    	int newStudentID = 0;
        int minStudentID = 0; 
        int maxStudentID = 0; 
        ResultSet k15_rset = k15_stmt.executeQuery("select min(studentid + 1) from examtable where (studentid + 1) not in (select studentid from examtable);");
        
        while(k15_rset.next()) {
        newStudentID = k15_rset.getInt(1);
        }
        k15_rset = k15_stmt.executeQuery("select min(studentid) from examtable;");
        while(k15_rset.next()) {
        minStudentID = k15_rset.getInt(1);
        }
        k15_rset = k15_stmt.executeQuery("select max(studentid) from examtable;");
        while(k15_rset.next()) {
        maxStudentID = k15_rset.getInt(1);
        }
        if(minStudentID > 209901){ 
          newStudentID = 209901; 
          k15_stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('"+ name + "',"+ newStudentID +", '" + kor + "','" + eng + "','" + mat + "' );");
        } else if(newStudentID < maxStudentID){
          k15_stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('"+ name + "',"+ newStudentID +", '" + kor + "','" + eng + "','" + mat + "' );");
        } else if(maxStudentID == 0){
          newStudentID = 209901;
          k15_stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('"+ name + "',"+ newStudentID +", '" + kor + "','" + eng + "','" + mat + "' );");
        } else{
          newStudentID = maxStudentID + 1;
          k15_stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('"+ name + "',"+ newStudentID +", '" + kor + "','" + eng + "','" + mat + "' );");
 
        k15_stmt.close();
        k15_rset.close();
		k15_conn.close();
%>
<HTML>
<HEAD>
    <script type="text/javascript">
        function chkword(obj, maxByte) {

            var strValue = obj.value;
            var strLen = strValue.length;
            var totalByte = 0;
            var len = 0;
            var oneChar = "";
            var str2 = "";

            for (var i = 0; i < strLen; i++) {
                oneChar = strValue.charAt(i);
                if (escape(oneChar).length > 4) {
                    totalByte += 2;
                } else {
                    totalByte++;
                }

                // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
                if (totalByte <= maxByte) {
                    len = i + 1;
                }
            }

            // 넘어가는 글자는 자른다.
            if (totalByte > maxByte) {
                alert("한글 기준 10자를 초과 입력 할 수 없습니다.");
                str2 = strValue.substr(0, len);
                obj.value = str2;
                chkword(obj, 4000);
            }

            if (strValue.match(' ')) {
                alert("공백은 입력할 수 없습니다.");
                str2 = "";
                obj.value = str2;
            }

            if (strValue.match('\[~!@#$%^&*()_+|<>?:{}[]\]')) {
                alert("특수문자는 입력할 수 없습니다.");
                str2 = "";
                obj.value = str2;
            }
        }
    </script>

</HEAD>

<BODY>
    <strong>
        <h1>
            성적입력추가완료
        </h1>
    </strong>
    <br>
    <br>
    <form method="post" action="inputForm1.html">
        <table border=0 width=400 cellsapcing=1>
            <tr>
                <td align=right>
                    <input type="submit" value="뒤로가기">
                </td>
            </tr>
        </table>
        <table border=1 width=400 cellspacing=1>
            <tr>
                <td>
                        <p align=center>이름</p>
                </td>
                <td>
                    <center>
                        <input type="text" name="name" style="text-align:left; width:170px;" value="<%= name %>" onkeyup='chkword(this, 20)'>
                    </center>
                </td>
                </center>
            </tr>
            <tr>
                <td>
                    <p align=center>학번</p>
                </td>
                <td>
                    <center>
                        <input type="number" style="text-align:left; width:170px;" name="studentid" value="<%= newStudentID %>">
                    </center>
                </td>
            </tr>
            <tr>
                <td>
                        <p align=center>국어</p>
                </td>
                <td>
                    <center>
                        <input type="number" name="kor" style="text-align:left; width:170px;" value="<%= kor %>">
                    </center>
                </td>
            </tr>
            <tr>
                <td>
                        <p align=center>영어</p>
                </td>
                <td>
                    <center>
                        <input type="number" name="eng" style="text-align:left; width:170px;" value="<%= eng %>">
                    </center>
                </td>
            </tr>
            <tr>
                <td>
                        <p align=center>수학</p>
                </td>
                <td>
                    <center>
                        <input type="number" name="mat" style="text-align:left; width:170px;" value="<%= mat %>">
                    </center>
                </td>
            </tr>
        </table>
    </form>

</BODY>

</HTML>