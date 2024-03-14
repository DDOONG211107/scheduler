<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import = "java.time.LocalDate" %>
<% 
request.setCharacterEncoding("utf-8"); 
// ResultSet result = query.executeQuery(); // select일때는 executeQuery()를 씀
boolean isCorrect=true; 

// if(result.next()) 
if(isCorrect == true)
{  
    // String userIdx = result.getString(1); 
    // session.setAttribute("userIdx", userIdx);
    LocalDate today = LocalDate.now();
    int currentYear = today.getYear();
    int currentMonth = today.getMonthValue();
    int currentDate = today.getDayOfMonth();
    response.sendRedirect("scheduler.jsp?year="+currentYear+"&month="+currentMonth+"&date="+currentDate); 
} 

%>

<script>
  const login = <%=isCorrect%>;
  console.log('ss');
  if(!login)
  {
    alert("id 또는 비밀번호가 올바르지 않습니다.");
      window.location.href='../index.html';
  }
</script>