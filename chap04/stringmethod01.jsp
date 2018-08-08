<!--k15전아현 / 2018.06.05.-->

<%@ page contentType="text/html; charset=UTF-8" %>

<HTML>
<HEAD>
<%!
String k15_str="abcdfeffasdsd";
//문자열 변수 k15_str 생성 후 값 설정
int k15_str_len = k15_str.length();
//정수형 변수 k15_str_len의 값을 k15_str변수의 값의 길이로 설정
String k15_str_sub = k15_str.substring(5);
//문자열 변수 k15_str_sub의 값을 k15_str변수의 0부터 카운트 하여 5번째 부터의 내용을 출력
int k15_str_loc = k15_str.indexOf("cd");
//정수형 변수 k15_str_loc의 값을 k15_str변수의 값 중 "cd"의 첫번째 문자인 c가 위치하는 index위치 출력
String k15_strL = k15_str.toLowerCase();
//문자열 변수 k15_strL의 값을 k15_str변수의 값을 소문자로 출력한 값으로 설정
String k15_strU = k15_str.toUpperCase();
//문자열 변수 k15_strU 값을 k15_str변수의 값을 대문자로 출력한 값으로 설정
%>
</HEAD>
<BODY>
k15_str : <%= k15_str%> <br>
k15_str_len : <%= k15_str_len%> <br>
k15_str_sub : <%= k15_str_sub%> <br>
k15_str_loc : <%= k15_str_loc%> <br>
k15_strL : <%= k15_strL%> <br>
k15_strU : <%= k15_strU%> <br>
<%-- 각 변수 호출하여 화면에 출력 --%>
Good...
</BODY>
</HTML>