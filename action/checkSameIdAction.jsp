<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.io.*" %>

<% 
    request.setCharacterEncoding("utf-8"); 

    boolean isSame = true; 
    boolean isError = true;

    String email = request.getParameter("email");
    String id = request.getParameter("id");
    String checkId = request.getParameter("checkId");
    String checkEmail = request.getParameter("checkEmail");
    String alertString = "";
    // String alertString = "서버:id는 영어 또는 숫자, 1자 이상 20자 이하로 입력해주세요.";

    try{
        String idReg = "^[a-zA-Z0-9]{1,20}$";
        Pattern pattern  = Pattern.compile(idReg);

        if(!pattern.matcher(id).matches()){
            throw new IllegalArgumentException("서버: 입력한 아이디 오류");
        }

        isError = false;
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "SELECT * FROM account WHERE id = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,id);

        ResultSet result = query.executeQuery();

        if(result.next()){
            throw new Exception("서버: 해당 아이디를 사용할 수 없음");
        }

        isSame = false;
        
    } catch(Exception e) {
        alertString = e.getMessage();
    }

%>

<script>
  const isSame = <%=isSame%>;
  const isError = <%=isError%>;
  const checkId = "<%=checkId%>";
  const checkEmail = "<%=checkEmail%>";
  const alertString = "<%=alertString%>";

  const id = "<%=id%>";
  const email = "<%=email%>";
  
  if(isError){
    alert(alertString);
    window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId=false&checkEmail="+checkEmail;
  }else{

    if(isSame){
        alert(alertString);
        // window.history.back();
        window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId=false&checkEmail="+checkEmail;
    } else {
        alert('해당 아이디는 사용할 수 있습니다.');
        // window.history.back();
        window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId=true&checkEmail="+checkEmail;
    }
  }
  
</script>