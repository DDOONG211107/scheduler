<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%
    request.setCharacterEncoding("utf-8"); 

    // 현재 연도와 월이 그대로 출력됨
    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dateValue = request.getParameter("date");

    String email = "\""+ request.getParameter("email")+"\"";
    String name = "\"" +request.getParameter("nameInput")+"\"";
    String password = "\"" + request.getParameter("passwordInput") + "\"";
    String team = "\"" + request.getParameter("teamSelect") +"\"";
    String rank = "\"" + request.getParameter("rankSelect") + "\"";

    // 성공적으로 저장했다고 가정
    boolean save = true;


%>

<script>
    const yearValue = "<%=yearValue%>";
    const monthValue = "<%=monthValue%>";
    const dateValue = "<%=dateValue%>";
    
    const email = <%=email%>;
    const name = <%=name%>;
    const password = <%=password%>;
    const team = <%=team%>;
    const rank = <%=rank%>;

    const save = <%=save%>

    if(save)
    {
        alert(yearValue+"년"+monthValue+"월"+dateValue+"일");
        alert(email+" "+name+" "+password+" "+team+" "+rank+"로 저장 했다고 가정. 마이페이지로 이동");
        window.location.href = "./mypage.jsp?year="+yearValue+"&month="+monthValue+"&date="+dateValue;
    }else {
        alert("문제가 생겼습니다");
        window.history.back();
    }

</script>