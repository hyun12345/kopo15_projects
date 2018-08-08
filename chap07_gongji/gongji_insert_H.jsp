<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD>
<script language="JavaScript">
//버튼에 적용되는 submitForm(mode) 함수 생성
function submitForm(mode){
    fm.action = "gongji_write.jsp?key=INSERT";
    //버튼 클릭하면 key 값을 INSERT로 가지는 동시에 gongji_write.jsp로 이동하도록 설정
    fm.submit();
}
</script>
</HEAD>

<BODY>
<form method=post name='fm'>
<%-- post 방식 : html 페이지에 form 형태에서 값을 전달 / form 이름을 fm으로 설정 --%>
<table width=650 border=1 cellspacing=1 cellpadding=5>
<tr>
<td><b>번호</b></td>
<td>신규(insert)<input type=hidden name=id value="INSERT"></td>
</tr>
<tr>
<td><b>제목</b></td>
<td><input type=text name=title size=70 maxlength=70></td>
</tr>
<tr>
<td><b>일자</b></td>
<td>2018-03-25</td>
</tr>
<tr>
<td><b>내용</b></td>
<td><textarea style="width:500px; height:250px;" name=content cols=70 row=600></textarea></td>
<%-- textarea : 텍스트를 입력할 수 있는 텍스트 상자 설정 / cols : 가로 텍스트 수 & rows : 세로 텍스트 수 --%>
</tr>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="취소" OnClick="location.href='gongji_list_H.jsp'"></td>
<%-- '취소' 버튼 클릭 시 gongji_list_H.jsp 페이지에 접속되도록 설정 --%>
<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
<%-- '쓰기' 버튼 클릭 시 submitForm 함수에 write 값 대입하도록 설정 --%>
</tr></table>
</form>
</BODY></HTML>
