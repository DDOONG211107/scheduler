<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.io.*" %>
<%@ page import = "java.time.LocalDate" %>
<% 
    request.setCharacterEncoding("utf-8"); 

    boolean login = false;
    boolean isError = true;

    String id = request.getParameter("idInput");
    String password = request.getParameter("passwordInput");
    String alertString = "";

    try {
      String idReg = "^[a-zA-Z0-9]{1,20}$";
      Pattern pattern  = Pattern.compile(idReg);

      if(!pattern.matcher(id).matches()){
        throw new IllegalArgumentException("서버: 아디 오류");
      }
      
      String passwordReg = "^[a-zA-Z0-9]{1,20}$";
      pattern = Pattern.compile(passwordReg);

      if(!pattern.matcher(password).matches()){
        throw new IllegalArgumentException("서버: 비밀번호 오류");
      }

      isError = false;

      Class.forName("com.mysql.jdbc.Driver");
      Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

      String sql = "SELECT * FROM account WHERE id = ? AND password = ?";
      PreparedStatement query = connect.prepareStatement(sql);
      query.setString(1,id);
      query.setString(2, password);

      ResultSet result = query.executeQuery();
      
      if(!result.next()){
        throw new Exception("서버: 로그인 실패");
      }

      login = true;
      String userIdx = result.getString(1);
      session.setAttribute("userIdx", userIdx);

      LocalDate today = LocalDate.now();
      int currentYear = today.getYear();
      int currentMonth = today.getMonthValue();
      int currentDate = today.getDayOfMonth();
      response.sendRedirect("scheduler.jsp?year="+currentYear+"&month="+currentMonth+"&date="+currentDate); 
  
    } catch(Exception e){
      alertString = e.getMessage();
    }


%>

<script>
  const isError = <%=isError%>;
  const alertString = "<%=alertString%>";
  const login = <%=login%>;

  if(isError){
    alert(alertString);
    window.history.back();

  }else if(!login){
    alert("id 또는 비밀번호가 올바르지 않습니다.");
      window.location.href='../index.html';
  } else {
    alert("서버: 로그인페이지 문제 생김");
  }
</script>