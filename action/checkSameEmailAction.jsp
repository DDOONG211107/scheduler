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

String isEdit = request.getParameter("isEdit");
String year = request.getParameter("year");
String month = request.getParameter("month");
String date = request.getParameter("date");
%>

<script>
  const isSame = <%=isSame%>;
  const checkId = <%=checkId%>;
  const email = <%=email%>;
  const id = <%=id%>;

  const isEdit = <%=isEdit%>;
  const year = "<%=year%>";
  const month = "<%=month%>";
  const date = "<%=date%>";

  if(isEdit){
    if(isSame){
      alert(`해당 이메일은 사용할 수 없습니다.`);
      // window.history.back();
      // window.location.href = "editMypage.jsp?email="+email+"&checkEmail=false";
      window.history.back();
    
    } else {    
      alert('해당 이메일은 사용할 수 있습니다.');
      // window.history.back();
      window.location.href = "editMypage.jsp?email="+email+"&checkEmail=true&year="+year+"&month="+month+"&date="+date;
    }
  }
  else {
    if(isSame){
    alert(`해당 이메일은 사용할 수 없습니다.`);
    // window.history.back();
    window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId="+checkId+"&checkEmail=false";
    
    } else {    
    alert('해당 이메일은 사용할 수 있습니다.');
    // window.history.back();
    window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId="+checkId+"&checkEmail=true";
    }
  }
  
  
  
</script>