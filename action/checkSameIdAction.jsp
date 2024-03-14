<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<% 
request.setCharacterEncoding("utf-8"); 

// ResultSet result = query.executeQuery(); // select일때는 executeQuery()를 씀
// 실제로는 db에서 값을 받아와야 한다
boolean isSame = false; 

String id = "\""+ request.getParameter("id")+"\"";
String email = "\""+ request.getParameter("email")+"\"";

String checkId = request.getParameter("checkId");
String checkEmail = "\""+ request.getParameter("checkEmail")+"\"";
%>

<script>
  const isSame = <%=isSame%>;
  const checkId = <%=checkId%>;
  const checkEmail = <%=checkEmail%>;
  const id = <%=id%>;
  const email = <%=email%>;
  
  if(isSame){
    alert(`해당 아이디는 사용할 수 없습니다.`);
    // window.history.back();
    window.location.href = "signup.jsp?checkId=false&checkEmail="+checkEmail;
  } else {
    alert('해당 아이디는 사용할 수 있습니다.');
    // window.history.back();
    window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId=true&checkEmail="+checkEmail;
  }
  
  
</script>