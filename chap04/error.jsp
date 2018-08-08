<!--k15전아현 / 2018.06.05.-->

<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" %>
<%-- isErrorPage의 값이 "true" --%>

<HTML>
<BODY>
이런 에러다..<br>
이 파일명은 error.jsp<br>
<br>*ERROR MESSAGE*<br>
<%-- 이와 같은 내용 화면에 출력되도록 설정 --%>
<%=exception%><br>
<%=exception.getClass()%><br>
<%=exception.getMessage()%><br>
<%-- 객체 exception과 getClass(), getMessage() 함수를 호출한 결과를 각각 화면에 출력 --%>
</BODY>
</HTML>