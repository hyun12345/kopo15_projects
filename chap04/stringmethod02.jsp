<!--k15전아현 / 2018.06.05.-->

<%@ page contentType="text/html; charset=UTF-8" %>

<HTML>

<BODY>
<%! 
String k15_arr[] = new String[]{"111", "222", "333"};
//문자열 배열 k15_arr 생성하여 값 설정
String k15_str = "abc,efg,hij";
//문자열 변수 k15_str 생성하여 값 설정
String k15_str_arr[] = k15_str.split(",");
//문자열 배열 k15_str_arr 생성하여 변수 k15_str의 값을 ","로 나눈 값으로 설정
%>
k15_arr[0] : <%= k15_arr[0]%> <br>
k15_arr[1] : <%= k15_arr[1]%> <br>
k15_arr[2] : <%= k15_arr[2]%> <br>
k15_str_arr[0] : <%= k15_str_arr[0]%> <br>
k15_str_arr[1] : <%= k15_str_arr[1]%> <br>
k15_str_arr[2] : <%= k15_str_arr[2]%> <br>
Good...
<%-- 두 배열 index값 넣어 출력 --%>
</BODY>
</HTML>