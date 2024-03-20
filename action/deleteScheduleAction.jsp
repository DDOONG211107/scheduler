<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.util.ArrayList" %>
<% 
    request.setCharacterEncoding("utf-8"); 
    String userIdx =  ((String) session.getAttribute("userIdx")) ;


    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String date = request.getParameter("date");

    String idx = request.getParameter("idx");
    
%>

<script>
    const userIdx = <%=userIdx%>;
    if(!userIdx){
        alert("로그인 후 이용해주세요.");
        window.location.href = "../index.html";
    }

    const year = <%=year%>;
    const month = <%=month%>;
    const date = <%=date%>;
    const idx = <%=idx%>;
    const alertString = "스케줄 idx가 전달되어 "+idx+"번 스케줄이 삭제되었다고 가정. ";

    alert(alertString);
    // window.close();
    window.location.href = "../page/scheduleDetail.jsp?year="+year+"&month="+month+"&date="+date;

</script>