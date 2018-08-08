<!--k15전아현 / 2018.06.05.-->

<%@ page 
import="java.io.*"
contentType="text/html; charset=UTF-8" %>
<%-- java.io.모든파일 import / 한글 출력 위해 UTF-8로 인코딩 --%>

<%
request.setCharacterEncoding("utf-8");
//입력값 한글 인코딩 될 수 있도록 설정
String k15_fromPT = request.getParameter("from");
//문자열 변수 k15_fromPT 값은 request 객체 사용하여 필드 "from"의 값을 받아옴
String k15_cntPT = request.getParameter("cnt");
//문자열 변수 k15_cntPT 값은 request 객체 사용하여 필드 "cnt"의 값을 받아옴
//freewifidata02.jsp?from20&cnt=30 : 20번째부터 30개 내용 출력
%>

<HTML>
<HEAD>
<% 
File k15_f = new File("/var/lib/tomcat7/webapps/ROOT/freewifidata.txt");
BufferedReader k15_br = new BufferedReader(new FileReader(k15_f));
String k15_readtxt;
// File 객체 k15_f 생성하여 새 파일 전국무료와이파이표준데이터.txt를 /var/lib/tomcat7/webapps/ROOT/ 주소에서 읽어옴
// BufferedReader 객체 k15_br 생성하여 k15_f 파일에 내용을 읽어냄(FileReader 객체를 생성하여 k15_f 대입)
// 문자열 변수 k15_readtxt 생성
 

if ((k15_readtxt = k15_br.readLine())==null) {
    out.println("빈 파일입니다");
    k15_br.close();
    return;
}
//문자열 k15_readtxt의 값을 k15_br.readLine()(k15_br에서 읽어드린 값)으로 설정하여 그 값이 null과 같을 때
//"빈 파일입니다"가 화면에 출력하도록 설정
//한 줄을 먼저 읽어야 필드명을 알 수 있으므로 null값인지 확인하기 위해 이와 같이 if 조건 설정
//k15_br.readLine() 입력하여 k15_f의 내용을 읽고 그 내용값을 k15_readtxt의 값으로 설정 가능


PrintWriter k15_pw = response.getWriter();
//printf 출력문 활용하기 위해 객체 생성
%>
</HEAD>

<BODY>
<%
String[] k15_field_name = k15_readtxt.split("\t");
//문자열 배열 k15_field_name 생성하여 k15_readtxt의 값을 \t로 구분

double k15_lat = 37.385750;
double k15_lng = 127.121282;
// 폴리텍대학 융합기술교육원 위도, 경도 변수로 설정

k15_pw.printf("k15_fromPT : %s<br>", k15_fromPT);
k15_pw.printf("k15_cntPT : %s<br><br>", k15_cntPT);
//k15_fromPT와 k15_cntPT를 출력하기 위한 출력문

int k15_LineCnt=0;
//정수형 변수 k15_LineCnt 생성하여 초기값을 0으로 설정
while((k15_readtxt = k15_br.readLine())!= null) {
//while문으로 k15_readtxt의 값이 k15_br을 한 줄 읽어낸 값일 때 그 값이 null과 같지 않으면 반복
    String[] k15_field = k15_readtxt.split("\t");
    //문자열 배열 k15_field 생성하여 k15_readtxt의 값을 \t로 구분

    k15_LineCnt++;
    // while문 조건 만족하는 동안 k15_LineCnt의 값 1씩 늘어나도록 설정

if(k15_LineCnt < Integer.parseInt(k15_fromPT)) continue;
//1씩 더해지는 k15_LineCnt의 값이 k15_fromPT를 정수형으로 형변환한 값보다 작으면 계속 되도록 continue; 실행문 설정
if(k15_LineCnt > Integer.parseInt(k15_fromPT) + Integer.parseInt(k15_cntPT) - 1) break;
//1씩 더해지는 k15_LineCnt의 값이 k15_fromPT를 정수형으로 형변환한 값에 k15_cntPT를 정수형으로 형병환한 값을 더한 값에서 1을 뺀 값보다 작으면
//빠져나오도록 break; 실행문 설정
    k15_pw.printf("**[%04d번째 항목]****************************************<br>", k15_LineCnt);
	// 위와 같은 내용에 정수(%04d : 네자리수에 맞추어 공백에 0 출력) 대입하여 출력
    k15_pw.printf("%s : %s<br>", k15_field_name[9], k15_field[9]);
    // k15_field_name[9] : 지번주소 / k15_field[9] : 지번 내용
    k15_pw.printf("%s : %s<br>", k15_field_name[12], k15_field[12]);
    // k15_field_name[12] :위도주소 / k15_field[12] : 위도 내용
    k15_pw.printf("%s : %s<br>", k15_field_name[13], k15_field[13]);
    // k15_field_name[13] : 경도주소 / k15_field[13] : 경도 내용
    double k15_dist = Math.sqrt(Math.pow(Double.parseDouble(k15_field[12])-k15_lat, 2) +
    Math.pow(Double.parseDouble(k15_field[13])-k15_lng,2));
    // Math.sqrt() : 루트 함수
	// Math.pow(Double, 2) : 제곱 함수(Double을 2제곱함)
	// Double.parseDouble() : 실수형으로 강제 형변환
    k15_pw.printf("현재 지점과 거리 : %f<br>", k15_dist);
    // 실수 변수 k15_dist 실수(%f)로 대입 받음
    k15_pw.printf("***********************************************************<br>");
}
k15_br.close();
// .close() 입력하여 파일 닫음
%>
</BODY>
</HTML>