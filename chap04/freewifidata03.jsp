<!--k15전아현 / 2018.06.05.-->

<%@ page 
import="java.io.*"
contentType="text/html; charset=UTF-8" %>
<%-- java.io.모든파일 import / 한글 출력 위해 UTF-8로 인코딩 --%>

   <% 
    String k15_from = request.getParameter("from");
    //문자열 변수 k15_from를 생성하여 그 값을 필드 "from"에 입력받는 값으로 설정
    if (k15_from == null)
    k15_from = "1";
    //k15_from의 값이 null과 일치하면 k15_from의 값을 "1"로 설정
    String k15_cnt = request.getParameter("cnt");
    //문자열 변수 k15_cnt 생성하여 그 값을 필드 "cnt"에 입력받는 값으로 설정
    if (k15_cnt == null)
    k15_cnt = "10";
    //k15_cnt 값이 null과 일치하면 k15_cnt 값을 "10"으로 설정
    //k15_from, k15_cnt의 값이 각각 null일 때(값을 지정해주지 않았을 때에) 기본 화면을 출력하기 위한 설정
    //따라서 1페이지가 기본 화면으로 출력됨

    int k15_from_int = Integer.parseInt(k15_from);
    //정수 변수 k15_from_int의 값은 문자열 변수 k15_from의 값을 정수형으로 형변환한 값
    int k15_cnt_int = Integer.parseInt(k15_cnt);
    //정수 변수 k15_cnt_int 값은 문자열 변수 k15_cnt_int 값을 정수형으로 형변환한 값
    int k15_page_print_num = 10 * k15_cnt_int;
    //정수 변수 k15_page_print_num를 생성하여 그 값을 10 * k15_cnt_int로 설정(10페이지 동안 출력하는 데이터 양)
    int k15_page_num = 10;
    //정수 변수 k15_page_num를 생성하여 그 값을 10으로 설정(한 화면에 출력하는 페이지 수)
      
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

BufferedReader k15_br_two = new BufferedReader(new FileReader(k15_f));
String k15_readtxt_two;
// BufferedReader 객체 k15_br_break 생성하여 k15_f 파일에 내용을 읽어냄(FileReader 객체를 생성하여 k15_f 대입)
// 문자열 변수 k15_readtxt_break 생성

int k15_LineCnt_two=0;
//정수형 변수 k15_LineCnt_two 생성하여 그 값을 0으로 설정

while ((k15_readtxt_two = k15_br_two.readLine())!=null) {
    k15_LineCnt_two++;
}
k15_br_two.close();
//문자열 k15_readtxt_break 값을 k15_br_break.readLine()(k15_br_break 읽어드린 값)으로 설정하여 그 값이 null이 아닐 때
//k15_LineCnt_two 값이 반복해서 1씩 더해지도록 while문 설정
//k15_br_break.close(); 입력하여 k15_br_break 파일 닫아줌

//out.println(k15_LineCnt_two); 입력하여 출력한 결과값이 데이터의 총 개수 15158보다 1많은 수인 15159가 출력됨(필드명이 입력되어있는 한 줄도 포함되어 count되기 때문에)
//따라서 데이터 총 수를 조건식 등에 이용하기 위해 (k15_LineCnt_two -1)을 대입해야 함
//out.println(k15_LineCnt_two-1); 출력 결과가 데이터 총 개수인 15158이 출력됨을 확인할 수 있음

if (k15_from_int > (k15_LineCnt_two-1)) {
    k15_from_int = (k15_LineCnt_two-1);
        //if조건으로 k15_from_int의 값이 (k15_LineCnt_two-1) 값보다 크면 그 값을 (k15_LineCnt_two-1) 되도록 설정
        //따라서 (k15_LineCnt_two-1) 값이 넘어가는 정수를 k15_from_int의 값으로 입력하더라도 주어진 범위 내에서 페이지 출력하도록 설정
} else if(k15_from_int < 1) {
    k15_from_int = 1;
     //else if조건으로 k15_from_int의 값이 1보다 작으면 그 값을 1이 되도록 설정
    //따라서 1이 되지 않는 0이나 음수인 정수를 k15_from_int의 값으로 입력하더라도 1부터 출력되어 주어진 범위 내에서 페이지 출력하도록 설정
}
%>

<HTML>
<HEAD>
<% 
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

    k15_pw.printf("<table border=0 width=1000 cellspacing=0 cellpadding=5");
    //테이블 border(표 형식)=0 / cellspacing(칸 사이 여백)=0 / cellpadding(칸 안쪽 여백)=0
    k15_pw.printf("<tr>");
    //열 생성
    k15_pw.printf("<td colspan=5 align=left><strong><font size=6>와이파이</font></strong><br><br></td></tr>");
    //행 생성 / 글씨 굵게, font size=6으로 설정
    k15_pw.printf("<tr>");
    k15_pw.printf("<td colspan=5 align=right><strong><font size=3>from : %d / cnt : %d</font></strong><br></td></tr>", k15_from_int, k15_cnt_int);
    //행 생성 / 글씨 굵게, font size=6으로 설정
    k15_pw.printf("<tr>");
    if (k15_cnt_int == 1) {
    k15_pw.printf("<td colspan=5 align=right><strong><font size=3>현재 페이지 : %d</font></strong><br></td></tr></table>", (int)((k15_from_int)/k15_cnt_int));
    } else {
    k15_pw.printf("<td colspan=5 align=right><strong><font size=3>현재 페이지 : %d</font></strong><br></td></tr></table>", ((int)(k15_from_int/k15_cnt_int))+1);
    }

    k15_pw.printf("<table border=1 width=1000 cellspacing=2 cellpadding=5>");
    //테이블 border(표 형식)=1 / width=1000 / cellspacing(칸 사이 여백)=2 / cellpadding(칸 안쪽 여백)=5
    k15_pw.printf("<tr align=center>");
    //align(표 안의 좌우 정렬 방식)=center
    k15_pw.printf("<td>번호</td>");
    k15_pw.printf("<td>주소</td>");
    k15_pw.printf("<td>위도</td>");
    k15_pw.printf("<td>경도</td>");
    k15_pw.printf("<td>거리</td></tr>");
    //각 행 생성하여 목록 값 넣어줌

    int k15_LineCnt=0;
    //정수형 변수 k15_LineCnt 생성하여 초기값을 0으로 설정
    int k15_fromPT=0;
    //정수형 변수 k15_fromPT 생성하여 초기값을 0으로 설정
    while((k15_readtxt = k15_br.readLine())!= null) {
    //while문으로 k15_readtxt의 값이 k15_br을 한 줄 읽어낸 값일 때 그 값이 null과 같지 않으면 반복
    String[] k15_field = k15_readtxt.split("\t");
    //문자열 배열 k15_field 생성하여 k15_readtxt의 값을 \t로 구분

    k15_LineCnt++;
    // while문 조건 만족하는 동안 k15_LineCnt의 값 1씩 늘어나도록 설정
    k15_fromPT=((int)((k15_from_int-1)/k15_cnt_int))*k15_cnt_int+1;
    //k15_fromPT의 값을 k15_from_int에서 1을 뺀 값을 k15_cnt_int의 값으로 나누어 정수형으로 형변한 한 뒤 k15_cnt_int의 값을 곱하고 1을 더한 값으로 설정
    //ex) k15_from_int = 92 k15_cnt_int = 3-> 91/3 = (int)(30.3) = 30*3 = 90+1 = 91
    //따라서 k15_from_int의 수를 임의의 양수 정수로 입력하더라도 k15_cnt_int만큼 한 페이지에 출력할 때 정해진 범위 내라면 어느 수를 입력하더라도 똑같이 출력되도록 설정

    if(k15_LineCnt < k15_fromPT) continue;
    //1씩 더해지는 k15_LineCnt의 값이 k15_fromPT 값보다 작으면 계속 되도록 continue; 실행문 설정
    if(k15_LineCnt > (k15_fromPT + (k15_cnt_int -1))) break;
    //1씩 더해지는 k15_LineCnt의 값이 (k15_fromPT + (k15_cnt_int -1))의 값보다 크면 빠져나오도록 break; 실행문 설정

    k15_pw.printf("<tr align=center>");
    k15_pw.printf("<td>%d</td>", k15_LineCnt);
    k15_pw.printf("<td>%s</td>", k15_field[9]);
    k15_pw.printf("<td>%s</td>", k15_field[12]);
    k15_pw.printf("<td>%s</td>", k15_field[13]);
    //각 행 생성하여 정수(%d), 문자열(%s) 변수, 배열값 대입 받아 값 넣어줌

    double k15_dist = Math.sqrt(Math.pow(Double.parseDouble(k15_field[12])-k15_lat, 2) +
    Math.pow(Double.parseDouble(k15_field[13])-k15_lng,2));
    // Math.sqrt() : 루트 함수
	// Math.pow(Double, 2) : 제곱 함수(Double을 2제곱함)
	// Double.parseDouble() : 실수형으로 강제 형변환
    k15_pw.printf("<td>%f</td></tr>", k15_dist);
    //행 생성하여 실수(%f) 변수 대입 받아 값 넣어줌
}
    k15_pw.printf("</table>");
    k15_br.close();
    //k15_br.close(); 입력하여 k15_br 파일 닫아줌
    k15_pw.printf("<br>");
    //개행 출력
%>
<%
    k15_pw.printf("<table border=0 width=1000 cellspacing=0 cellpadding=5><tr align=center>");
    k15_pw.printf("<td colspan=5><a href=\"freewifidata03.jsp?from=1&cnt=%d\"> << </a>", k15_cnt_int);
    //한 페이지 당 출력되는 수 k15_cnt_int를 정수 변수(%d)로 대입받음
    //"freewifidata03.jsp?from=1&cnt=%d" 주소를 <<에 연결
    //\"주소\" : ""안에 ""를 또 사용할 수 없으므로 사이에 \\를 입력하여 중복되는 것 방지
    k15_pw.printf("<a href=\"freewifidata03.jsp?from=%d&cnt=%d\"> < </a>", ((int)((k15_from_int / k15_page_print_num)-1) * k15_page_print_num+1), k15_cnt_int);
    //한 페이지 당 출력되는 수 k15_cnt_int를 정수 변수(%d)로 대입받음
    //"freewifidata03.jsp?from=%d&cnt=%d" 주소를 <에 연결
    //from=((int)((k15_from_int / k15_page_print_num)-1) * k15_page_print_num+1) : ex) 1001/50 = (int)(20.02) = 20-1 = 19*50 = 950+1 = 951
    //따라서 k15_from_int의 값이 1001이면 <을 클릭한 결과 1001-50*10 = 1001-500 = 501부터 출력되는 11페이지로 돌아감을 확인할 수 있음
    //951페이지는 바로 전인 20페이지이지만 < 클릭하면 출력되는 10페이지 중 가장 처음 페이지로 돌아감
    //\"주소\" : ""안에 ""를 또 사용할 수 없으므로 사이에 \\를 입력하여 중복되는 것 방지
    
    int k15_start = (int) ((k15_from_int / k15_page_print_num) * k15_page_num + 1);
    //정수 변수 k15_start 생성하여 ((k15_from_int / 100) * 10 + 1)의 값을 정수형으로 형변환한 값으로 설정
    //ex)k15_from_int = 14121 -> (14121/100) = 141.21*10 = 1412.1+1=1413.1
    //따라서 k15_from_int의 값이 14121이면 1413페이지에서 시작하도록 k15_start 변수 설정

    for (int i = k15_start; i < (k15_start + k15_page_num) ; i++) {
        // 정수 변수 i의 값을 k15_start로 설정하고, (k15_start + k15_page_num)보다 작은 동안 그 값이 1씩 더해지도록 설정
        //if()

        k15_pw.printf("<strong><a href=\"freewifidata03.jsp?from=%d&cnt=%d\" style=\"margin:0 10px;\">%d</a></strong>" , ((i-1)*k15_cnt_int+1) , k15_cnt_int , i);
        //"freewifidata03.jsp?from=%d&cnt=%d" 주소를 i의 값에 연결
        //from=((i-1)*k15_cnt_int+1) : ex)i = k15_start = 14121 -> 14121-1 = 14120*10 = 141200+1 = 141201
        //따라서 14121페이지에는 141201부터 시작하여 10개의 내용이 입력되도록 설정
        //cnt=k15_cnt_int=10(한 페이지에서 출력되는 데이터 양)
        //style=\"margin:0 10px;\" : margin(바깥쪽 여백)의 값을 10px로 지정

         if ((k15_LineCnt_two-1) % k15_cnt_int == 0 && ((k15_LineCnt_two-1) / k15_cnt_int) == i) {
        break;
        //(k15_LineCnt_two-1) 값을 k15_cnt_int의 값으로 나눈 나머지 값이 0이고(AND &&)
        //(k15_LineCnt_two-1) 값을 k15_cnt_int의 값으로 나눈 값이 i일 때 빠져나오도록 break문 설정
        } else if ((k15_LineCnt_two-1)  % k15_cnt_int != 0 && ((k15_LineCnt_two-1) / k15_cnt_int)+1 == i) {
            break;
            //(k15_LineCnt_two-1) 값을 k15_cnt_int의 값으로 나눈 나머지 값이 0이 아니고(AND &&)
            //(k15_LineCnt_two-1) 값을 k15_cnt_int의 값으로 나눈 값에 1을 더한 값이 i일 때 빠져나오도록 break문 설정
        }
    }

    k15_pw.printf("<a href=\"freewifidata03.jsp?from=%d&cnt=%d\"> > </a>", ((int)((k15_from_int / k15_page_print_num)+1) * k15_page_print_num+1), k15_cnt_int);
    //"freewifidata03.jsp?from=%d&cnt=%d" 주소를 >에 연결
    //from=((int)((k15_from_int / k15_page_print_num)+1) * k15_page_print_num+1) : ex)k15_from_int = 1001 -> 1001/50 = 20.02+1 = int(21.01) = 21*50 = 1050+1 = 1051
    //따라서 k15_from_int의 값이 1001이면 >을 클릭한 결과 1001+50*10 = 1001+500 = 1501부터 출력되는 31페이지로 감을 확인할 수 있음
    
    if ((k15_LineCnt_two-1) % k15_cnt_int == 0) {
       k15_pw.printf("<a href=\"freewifidata03.jsp?from=%d&cnt=%d\"> >> </a>", ((int)((k15_LineCnt_two-1) / k15_cnt_int)-1) * k15_cnt_int+1, k15_cnt_int);
    } 
    else {
      k15_pw.printf("<a href=\"freewifidata03.jsp?from=%d&cnt=%d\"> >> </a>", ((int)((k15_LineCnt_two-1)/ k15_cnt_int)) * k15_cnt_int+1, k15_cnt_int);
    }
    k15_pw.printf("</td></tr></table>");
    //"freewifidata03.jsp?from=%d&cnt=%d" 주소를 >>에 연결
    //if조건으로 ((k15_LineCnt_two-1) % k15_cnt_int == 0) 조건에 일치하면 from=(int)((k15_LineCnt_two-1) / k15_cnt_int)-1) * k15_cnt_int+1로 설정
    //ex)k15_cnt_int = 22 -> (15159-1)/22 = 15158/22 = 689-1 = 688*22 = 15136+1 = 15137
    //따라서 k15_cnt_int 값이 22일 때 >>을 클릭한 결과 15137부터 데이터 끝까지 출력되므로 맨끝 페이지로 이동 가능
    //if조건에 부합하지 않는 경우 from=(int)((k15_LineCnt_two-1) / k15_cnt_int)) * k15_cnt_int+1로 설정
    //ex)k15_cnt_int = 10 -> (15159-1)/10 = 15158/10 = int(1515.8) = 1515*10 = 15150+1 = 15151
    //따라서 k15_cnt_int 값이 10일 때 >>을 클릭한 결과 15151부터 데이터 끝까지 출력되므로 맨끝 페이지로 이동 가능
    //cnt=k15_cnt_int=한 페이지에서 출력되는 데이터 양
%>
</BODY>
</HTML>