<!--k15전아현 / 2018.06.05.-->

<%@ page contentType="text/html; charset=UTF-8" %>
<%-- UTF-8 : 한글 인코딩(라틴어 아닌 언어) --%>

<HTML>
<HEAD>
<%!             //JSP의 변수 함수를 선언하는 부분
    private class AA {
    //private class AA 생성
        private int k15_Sum(int i, int j) {
    //두 정수형 변수 대입하는 private 정수형 함수 k15_Sum 생성
        return i + j;
    //반환 값을 i + j로 설정
        }
    }
AA aa = new AA();
//AA 클래스의 객체 aa 생성
%>
</HEAD>
<BDOY>
<% out.println("2+3=" + aa.k15_Sum(2,3));%><br>
<%-- aa객체에 k145_Sum 함수 호출하여 2, 3 대입 --%>
Good...
</BODY>
</HTML>