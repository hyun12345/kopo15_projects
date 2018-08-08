<!--k15전아현 / 2018.06.05.-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<HTML>
<head>
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

                if (totalByte <= maxByte) {
                    len = i + 1;
                }
            }

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
        }

        function removeChar(event) {
            event = event || window.event;
            var keyID = (event.which) ? event.which : event.keyCode;
            if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
                return;
            else
                event.target.value = event.target.value.replace(/[^0-9]/g, "");
        }
</script>

</head>

<BODY>
<%
request.setCharacterEncoding("utf-8");

String name = "해당학번없음";
String studentid = "";
String kor = "";
String eng = "";
String mat = "";

Class.forName("com.mysql.jdbc.Driver");
Connection k15_conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo15","root","88346846a");
Statement k15_stmt = k15_conn.createStatement();

String k15_searching = request.getParameter("search_studentid");
if (k15_searching == null) {
    k15_searching = "0";
}
int searching = Integer.parseInt(k15_searching);


String k15_Query = "select * from examtable where studentid = " + searching + ";";
ResultSet k15_rset= k15_stmt.executeQuery(k15_Query);

    while(k15_rset.next()) {
    name = k15_rset.getString(1);
    studentid = Integer.toString(k15_rset.getInt(2));
    kor = Integer.toString(k15_rset.getInt(3));
    eng = Integer.toString(k15_rset.getInt(4));
    mat = Integer.toString(k15_rset.getInt(5));
    }
	
    k15_rset.close();
	k15_stmt.close();
	k15_conn.close();
%>

    <strong>
        <h1>
            성적 조회후 정정 / 삭제
        </h1>
    </strong>
    <br>
    <br>
    
    <form method="post" name="search_form">
                    조회할 학번
                    <input type="text" type="number" onkeyup="removeChar(event)" name="search_studentid" value="" required>
                    <input type="submit" value="조회">
    </form>
    <br>

    <form method="post" action="updateDB.jsp">
        <table border=1 width=400 cellspacing=1>
            <tr>
                <td>
                        <p align=center>이름</p>
                </td>
                <td>
                    <center>
                        <input type="text" style="text-align:left; width:170px;" name="name" value="<%= name %>" pattern='^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]+$' required onkeyup='chkword(this, 20)'>
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
                        <input type="number" onkeyup="removeChar(event)" style="text-align:left; width:170px;" name="studentid" value="<%= studentid %>" readonly>
                    </center>
                </td>
            </tr>
            <tr>
                <td>
                        <p align=center>국어</p>
                </td>
                <td>
                    <center>
                        <input type="number" onkeyup="removeChar(event)" min=0 max=100 style="text-align:left; width:170px;" name="kor" value="<%= kor %>" required>
                    </center>
                </td>
            </tr>
            <tr>
                <td>
                        <p align=center>영어</p>
                </td>
                <td>
                    <center>
                        <input type="number" onkeyup="removeChar(event)" min=0 max=100 style="text-align:left; width:170px;" name="eng" value="<%= eng %>" required>
                    </center>
                </td>
            </tr>
            <tr>
                <td>
                        <p align=center>수학</p>
                </td>
                <td>
                    <center>
                        <input type="number" onkeyup="removeChar(event)" min=0 max=100 style="text-align:left; width:170px;" name="mat" value="<%= mat %>">
                    </center>
                </td>
            </tr>
        </table>

<%
if(studentid.length() != 0) {
out.println("<table border=0 width=400 cellsapcing=1>");
out.println("<tr><td width = 200></td>");
out.println("<td align=right><input type=\"submit\" value=\"수정\" onClick=\"return check_form()\"></td></form>");
out.println("<form method=\"post\" action=\"deleteDB.jsp\">");
out.println("<td><input type=\"hidden\" name=\"studentid\" value=\"" + studentid +"\"></td>");
out.println("<td align=right><input type=\"submit\" value=\"삭제\" onClick=\"return check_form()\"></td>");
out.println("</form>");
out.println("</tr>");
out.println("</table>");
}
%>
</BODY>


</HTML>

