<!--k15전아현 / 2018.06.05.-->

<%@ page contentType="text/html; charset=UTF-8" %>
<%-- UTF-8 : 한글 인코딩(라틴어 아닌 언어) --%>

<HTML>
<HEAD>
<%!         //JSP의 변수 함수를 선언하는 부분
private String k15_call1() {
    //private 문자열 함수 k15_call1() 생성
    String k15_a = "abc";
    String k15_b = "efg";
    //문자열 변수 k15_a, k15_b의 값 각각 설정
    return (k15_a+k15_b);
    //반환 값을 (k15_a + k15_b)로 설정
}
private Integer k15_call2() {
    //private 정수형 함수 k15_call2() 생성

    Integer k15_a = 1;
    Integer k15_b = 2;
     //정수형 변수 k15_a, k15_b의 값 각각 설정

    return (k15_a+k15_b);
     //반환 값을 (k15_a + k15_b)로 설정


}
%>
</HEAD>
<BODY>
String 연산 : <%=k15_call1()%><br>
Integer 연산 : <%=k15_call2()%><br>
<%--<BODY></BODY>안에 화면에 출력할 내용 입력 --%>
<%-- <%= %> 안에 함수 입력하여 함수 호출--%>
Good...
</BODY>
</HTML>