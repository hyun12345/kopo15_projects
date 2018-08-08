<!--k15전아현 / 2018.06.05.-->

<%@ page contentType="text/html; charset=UTF-8" %>
<%
request.setCharacterEncoding("utf-8");
//입력값 한글 인코딩 될 수 있도록 설정
String k15_name = request.getParameter("username");
//문자열 변수 k15_name의 값은 request 객체 사용하여 "username"의 값을 받아옴
String k15_password = request.getParameter("userpasswd");
//문자열 변수 k15_password 값은 request 객체 사용하여 "userpasswd"의 값을 받아옴
%>


<HTML>
<HEAD>
  <TITLE>로그인</TITLE>
  <%-- 페이지 제목 '로그인'으로 설정 --%>
</HEAD>

<BODY>
이름 : <%= k15_name %><br>
비밀번호 : <%= k15_password %><br>
<%-- 변수값 대입하여 화면에 결과 출력 --%>
</BODY>

</HTML>