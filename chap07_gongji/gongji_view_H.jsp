<!--k15전아현 / 2018.07.23.-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>

<HTML>
<HEAD>
<script language="JavaScript">
//버튼에 적용되는 submitForm(mode) 함수 생성
function submitForm(mode){
    if(mode == "write") {
        fm.action = "gongji_write.jsp";
    //mode의 값이 write와 일치하는 경우 버튼 클릭하면 gongji_write.jsp로 이동하도록 설정
    } else if(mode == "delete") {
        fm.action = "gongji_delete.jsp"
    //mode의 값이 delete 일치하는 경우 버튼 클릭하면 gongji_delete.jsp로 이동하도록 설정
    }
fm.submit();
//fm이라는 이름의 form 실행되도록 설정
}
</script>
</HEAD>

<BODY>
<form method=post name='fm'>
<%-- post 방식 : html 페이지에 form 형태에서 값을 전달 / form 이름을 fm으로 설정 --%>
<table width=650 border=1 cellspacing=1 cellpadding=5>
<tr>
<td><b>번호</b></td>
<td>1</td>
</tr>
<tr>
<td><b>제목</b></td>
<td>공지사항1</td>
</tr>
<tr>
<td><b>일자</b></td>
<td>2018-01-14</td>
</tr>
<tr>
<td><b>내용</b></td>
<td>공지사항내용1</td>
</tr>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="목록" OnClick="location.href='gongji_list_H.jsp'"></td>
<%-- '목록' 버튼 생성하여 클릭시 gongji_list_H.jsp에 링크 접속되도록 설정 --%>
<td><input type=button value="수정" OnClick="location.href='gongji_update_H.jsp?key=1'"></td>
<%-- '수정' 버튼 생성하여 클릭시 gongji_update_H.jsp에 링크 접속되도록 하며 key 값 가지도록 설정 --%>
</tr></table>
</form>
</BODY></HTML>