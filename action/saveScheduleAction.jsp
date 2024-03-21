<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.util.regex.Pattern" %>
<% 
    request.setCharacterEncoding("utf-8"); 
    String userIdx =  ((String) session.getAttribute("userIdx"));

    boolean update = false;
    boolean isError = true;

    String idx = request.getParameter("idx");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String date = request.getParameter("date");
    String hour = request.getParameter("hour");
    String minute = request.getParameter("minute");
    String content = request.getParameter("content");
    String startDatetime = year + "-" + month + "-" + date + " " + hour + ":" + minute + ":00";
    String alertString = "";

    String descYear = request.getParameter("descYear");
    String descMonth = request.getParameter("descMonth");
    String descDate = request.getParameter("descDate");

    try{
        String yearReg = "^\\d{4}$";
        Pattern pattern  = Pattern.compile(yearReg);

        if(!pattern.matcher(year).matches()){
            throw new IllegalArgumentException("서버: 연도 오류");
        }

        String monthReg = "^[1-9]|1[0-2]$"; 
        pattern  = Pattern.compile(monthReg);

        if(!pattern.matcher(month).matches()){
            throw new IllegalArgumentException("서버: 월 오류");
        }

        String dateReg = "^(0?[1-9]|[12]\\d|3[01])$";
        pattern = Pattern.compile(dateReg);

        if(!pattern.matcher(date).matches()){
            throw new IllegalArgumentException("서버: 일 오류");
        }

        String hourReg = "^0[0-9]|[1][0-9]|[2][0-3]$";
        pattern  = Pattern.compile(hourReg);

        if(!pattern.matcher(hour).matches()){
            throw new IllegalArgumentException("서버: 시간 오류");
        }

        String minuteReg = "^0[0-9]|[12345][0-9]$";
        pattern  = Pattern.compile(minuteReg);

        if(!pattern.matcher(minute).matches()){
            throw new IllegalArgumentException("서버: 분 오류");
        }

        String contentReg = "^.{1,20}$";
        pattern  = Pattern.compile(contentReg);

        if(!pattern.matcher(content).matches()){
            throw new IllegalArgumentException("서버: 스케줄 내용 오류");
        }

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "UPDATE schedule SET start_datetime = ?, content = ? WHERE idx = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,startDatetime);
        query.setString(2,content);
        query.setString(3,idx);

        query.executeUpdate();

        update = true;
        isError = false;

    }catch(Exception e){
        alertString = e.getMessage();
    }

    
%>

<script>
    const userIdx = <%=userIdx%>;
    if(!userIdx){
        alert("로그인 후 이용해주세요");
        window.location.href = "../index.html";
    }

    const year = <%=year%>;
    const month = <%=month%>;
    const date = <%=date%>;
    const idx = "<%=idx%>";
    const content = "<%=content%>";

    const descYear = "<%=descYear%>";
    const descMonth = "<%=descMonth%>";
    const descDate = "<%=descDate%>";

    const isError = <%=isError%>;
    const alertString = "<%=alertString%>";
    if(isError){
        alert(alertString);
    }

    // alert(alertString);
    // window.close();
    window.location.href = "../page/scheduleDetail.jsp?year="+descYear+"&month="+descMonth+"&date="+descDate;

</script>