<!--k15전아현 / 2018.06.05.-->

<%@ page contentType="text/html; charset=UTF-8" %>
<%-- UTF-8 : 한글 인코딩(라틴어 아닌 언어) --%>

<HTML>
<BODY>
<% String k15_myUrl = "http://www.kopo.ac.kr"; %>
<%-- 문자열 변수 k15_myUrl 생성하여 그 값을 "http://www.kopo.ac.kr"로 설정 --%>
<a href="<%= k15_myUrl %>">Hello</a> World. 웰컴
<%-- <a href="홈페이지 주소"></a> : 입력한 홈페이지 주소에 연결 --%>
<%-- <%= %> : 기호 뒤에 변수 값 출력 --%>
<%-- 즉 Hello라고 입력한 문자에 링크를 연결(k15_myUrl 변수 값) --%>
</BODY>
</HTML>