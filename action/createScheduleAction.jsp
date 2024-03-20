<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<% 
    request.setCharacterEncoding("utf-8"); 
    String userIdx =  ((String) session.getAttribute("userIdx")) ;

    String year = request.getParameter("newYear");
    String month = request.getParameter("newMonth");
    String date = request.getParameter("newDate");
    String hour = request.getParameter("newHour");
    String minute = request.getParameter("newMinute");
    String content = request.getParameter("newContent");

    String descYear = request.getParameter("descYear");
    String descMonth = request.getParameter("descMonth");
    String descDate = request.getParameter("descDate");

%>

<script>

    const userIdx = <%=userIdx%>;
    if(!userIdx){
        alert("로그인 후 이용해주세요.");
        window.location.href = "../index.html";
    }

    const year = "<%=year%>";
    const month = "<%=month%>";
    const date = "<%=date%>";
    const hour = "<%=hour%>";
    const minute = "<%=minute%>";
    const content = "<%=content%>";

    const descYear = "<%=descYear%>";
    const descMonth = "<%=descMonth%>";
    const descDate = "<%=descDate%>";

    const alertString = year+"년 "+month+"월 "+date+"일 "+hour+"시 "+minute+"분 "+content+"로 새로운 스케줄 생성했다고 가정.";

    // alert(alertString);
    // const s = descYear + descMonth +descDate;
    alert(alertString);
    window.location.href = "../page/scheduler.jsp?year="+descYear+"&month="+descMonth+"&date="+descDate;

</script>