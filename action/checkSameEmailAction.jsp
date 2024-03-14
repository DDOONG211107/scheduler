<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<% 
request.setCharacterEncoding("utf-8"); 

// ResultSet result = query.executeQuery(); // select일때는 executeQuery()를 씀
// 실제로는 db에서 값을 받아와야 한다
boolean isSame = false; 

String id = "\""+ request.getParameter("id")+"\"";
String email = "\""+ request.getParameter("email")+"\"";

String checkId = "\"" +request.getParameter("checkId") +"\"";
String checkEmail = "\""+ request.getParameter("checkEmail")+"\"";
%>

<script>
  const isSame = <%=isSame%>;
  const checkId = <%=checkId%>;
  const email = <%=email%>;
  const id = <%=id%>;

  
  if(isSame){
    alert(`해당 이메일은 사용할 수 없습니다.`);
    // window.history.back();
    window.location.href = "signup.jsp?checkId="+checkId+"&checkEmail=false";

  } else {
    // document.getElementById("emailInput").setAttribute('readonly');
    // document.getElementById('checkEmailBtn').style.display = 'none';
    alert('해당 이메일은 사용할 수 있습니다.');
    // window.history.back();
    window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId="+checkId+"&checkEmail=true";


  }
  
  
</script>