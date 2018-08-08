<!--k15전아현 / 2018.06.05.-->

<HTML>
<HEAD>
<%!
String k15_arr[] = new String[]{"111", "222", "333"};
//문자열 배열 k15_arr 생성하여 값을 설정
%>
</HEAD>
<BODY>
<%
try {
    //try : 예외 상황 입력
    out.println(k15_arr[4]+"<br>");
    //k15_arr 배열의 4번째 item을 출력하고자 하지만 배열은 2번째까지만 존재
} catch(Exception e) {
    out.println("error==>"+e+"<========<br>");
//catch : 예외 처리 이유 설명
//Exception 객체 e 호출하여 error 내용 화면에 출력
}
%>
Good...
</BODY>
</HTML>