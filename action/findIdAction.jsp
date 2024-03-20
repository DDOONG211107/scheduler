<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.sql.ResultSet" %> 


<% 
    request.setCharacterEncoding("utf-8"); 

    boolean findId = false;
    boolean isError = true;

    String name = request.getParameter("nameInput");
    String email = request.getParameter("emailInput");
    String id = "";
    String alertString = "";

    try {
        String nameReg = "^[a-zA-Z가-힣]{1,10}$";
        Pattern pattern = Pattern.compile(nameReg);

        if(!pattern.matcher(name).matches()){
            throw new IllegalArgumentException("서버: 이름 오류");
        }

        String emailReg = "^(?:[a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*\\.[a-zA-Z0-9]*){1,20}$";
        pattern = Pattern.compile(emailReg);

        if(!pattern.matcher(email).matches()){
            throw new IllegalArgumentException("서버: 이메일 오류");
        }

        isError = false;

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "SELECT * FROM account WHERE name = ? AND email = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,name);
        query.setString(2, email);

        ResultSet result = query.executeQuery();

        if(!result.next()){
            throw new Exception("서버: 해당 아이디 없음");
        }

        findId = true;
        id = result.getString(3);

    }catch(Exception e){
        alertString = e.getMessage();
    }

%>

<script>
  const findId = <%=findId%>;
  const id = "<%=id%>";
  const isError = <%=isError%>;
  const alertString = "<%=alertString%>";
  
  if(isError) {
    alert(alertString);
    window.history.back();
  } else{
    if(findId) {
        alert("id는 "+ id +"입니다. 로그인 페이지로 이동합니다.");
        window.location.href = "../index.html";
    } else {
        alert("이름 또는 이메일이 올바르지 않습니다.");
      window.history.back();
    }
  }
  
  
</script>