<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<% 
request.setCharacterEncoding("utf-8"); 

String id = "\""+ request.getParameter("id")+"\"";
String email = "\""+ request.getParameter("email")+"\"";
String name = "\"" +request.getParameter("nameInput")+"\"";
String password = "\"" + request.getParameter("passwordInput") + "\"";
String team = "\"" + request.getParameter("teamSelect") +"\"";
String rank = "\"" + request.getParameter("rankSelect") + "\"";

// 성공적으로 회원가입 했다고 가정
boolean signup = true;


%>

<script>

const id = <%=id%>;
const email = <%=email%>;
const name = <%=name%>;
const password = <%=password%>;
const team = <%=team%>;
const rank = <%=rank%>;

const signup = <%=signup%>

if(signup)
{
    alert(id+" "+email+" "+name+" "+password+" "+team+" "+rank+"로 회원가입 했다고 가정. 로그인페이지로 이동");
    window.location.href = "../index.html";
}else {
    alert("문제가 생겼습니다");
    window.history.back();
}

</script>