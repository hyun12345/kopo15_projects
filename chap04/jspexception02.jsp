<!--k15전아현 / 2018.06.05.-->

<%@ page errorPage="error.jsp" %>
<%-- errorPage를 error.jsp로 설정--%>

<HTML>
<HEAD>
<%!
String k15_arr[] = new String[]{"111", "222", "333"};
//문자열 배열 k15_arr 생성하여 값을 설정
%>
</HEAD>
<BODY>
<%
    out.println(k15_arr[4]+"<br>");
    //k15_arr 배열의 4번째 item을 출력하고자 하지만 배열은 2번째까지만 존재
%>
</BODY>
</HTML>