<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<% 
request.setCharacterEncoding("utf-8"); 

// ResultSet result = query.executeQuery(); // select일때는 executeQuery()를 씀
// 실제로는 db에서 값을 받아와야 한다
boolean isCorrect=true; 
String testId = (String) "testId";
String id = "\""+testId+"\"";
%>

<script>
  const findId = <%=isCorrect%>;
  const id = <%=id%>;
  console.log(id);
  if(findId){
    alert(`id는 ${id}입니다. 로그인 페이지로 이동합니다.`);
    window.location.href = "../index.html";
  }
  else
  {
    alert("이름 또는 이메일이 올바르지 않습니다.");
      window.location.href='../index.html';
  }
  
</script>