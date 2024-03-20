<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.regex.Pattern" %>

<% 
    request.setCharacterEncoding("utf-8"); 

    boolean findPassword = false;
    boolean isError = true;

    String id = request.getParameter("idInput");
    String email = request.getParameter("emailInput");
    String password = "";
    String alertString = "";

    try {
        String idReg = "^[a-zA-Z0-9]{1,20}$";
        Pattern pattern  = Pattern.compile(idReg);

        if(!pattern.matcher(id).matches()){
            throw new IllegalArgumentException("서버: 아디 오류");
        }

        String emailReg = "^(?:[a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*\\.[a-zA-Z0-9]*){1,20}$";
        pattern = Pattern.compile(emailReg);

        if(!pattern.matcher(email).matches()){
            throw new IllegalArgumentException("서버: 이메일 오류");
        }

        isError = false;

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "SELECT * FROM account WHERE id = ? AND email = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,id);
        query.setString(2, email);

        ResultSet result = query.executeQuery();

        if(!result.next()){
            throw new Exception("서버: 해당 비밀번호 없음");
        }

        findPassword = true;
        password = result.getString(6);
    }catch(Exception e){
        alertString = e.getMessage();
    }


%>

<script>
  const findPassword = <%=findPassword%>;
  const password = "<%=password%>";
  const isError = <%=isError%>;
  const alertString = "<%=alertString%>";

  if(isError){
    alert(alertString);
    window.history.back();
  }else {
    if(findPassword){
        alert("비밀번호는 "+ password +"입니다. 로그인 페이지로 이동합니다.");
        window.location.href = "../index.html";
    } else {
        alert("아이디 또는 이메일이 올바르지 않습니다.");
        window.history.back();
    }
  }
  
  
  
</script>