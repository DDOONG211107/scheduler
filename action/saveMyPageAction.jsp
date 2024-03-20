<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.util.regex.Pattern" %>

<%
    request.setCharacterEncoding("utf-8"); 
    String userIdx =  ((String) session.getAttribute("userIdx"));
    boolean save = false;
    boolean isError = true;
    boolean samePassword = false; // 필요 없을수도 있음

    String email = request.getParameter("email");
    String name = request.getParameter("nameInput");
    String password = request.getParameter("passwordInput");
    String passwordCheck = request.getParameter("passwordCheckInput");
    String team = request.getParameter("teamSelect");
    String rank = request.getParameter("rankSelect");
    String alertString = "";

    // 현재 연도와 월이 그대로 출력됨
    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dateValue = request.getParameter("date");

    try{
        String emailReg = "^(?:[a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*\\.[a-zA-Z0-9]*){1,20}$";
        Pattern pattern = Pattern.compile(emailReg);

        if(!pattern.matcher(email).matches()){
            throw new IllegalArgumentException("서버: 이메일 오류");
        }

        String nameReg = "^[a-zA-Z가-힣]{1,10}$";
        pattern = Pattern.compile(nameReg);
        
        if(!pattern.matcher(name).matches()){
            throw new IllegalArgumentException("서버: 이름 오류");
        }

        String passwordReg = "^[a-zA-Z0-9]{1,20}$";
        pattern = Pattern.compile(passwordReg);

        if(!pattern.matcher(password).matches()){
            throw new IllegalArgumentException("서버: 비밀번호 오류");
        }

        if(!pattern.matcher(passwordCheck).matches()){
            throw new IllegalArgumentException("서버: 비밀번호 확인칸 오류");
        }

        if(!password.equals(passwordCheck)){
            throw new Exception("서버: 비밀번호 불일치");
        }

        if(!team.equals("기획팀") && !team.equals("디자인팀")){
            throw new IllegalArgumentException("서버: 부서 오류");
        }

        if(!rank.equals("팀장") && !rank.equals("팀원")){
            throw new IllegalArgumentException("서버: 직급 오류");
        }

        // 모든걸 통과했으니 이제 db 연결

        isError = false;
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "UPDATE account SET email = ?, name = ?, password = ?, team = ?, rank= ? WHERE idx = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, email);
        query.setString(2, name);
        query.setString(3, password);
        query.setString(4, team);
        query.setString(5, rank);
        query.setString(6, userIdx);

        query.executeUpdate();

        save = true;

    }catch(Exception e){
        alertString = e.getMessage();
    }

%>

<script>
    const userIdx = <%=userIdx%>;
    if(!userIdx){
        alert("로그인 후 이용해주세요");
        window.location.href = "../index.html";
    }
    const yearValue = "<%=yearValue%>";
    const monthValue = "<%=monthValue%>";
    const dateValue = "<%=dateValue%>";

    const ArrayList = "<%=alertString%>";
    const isError = <%=isError%>;
    const save = <%=save%>;

    if(isError){
        alert(alertString);
        window.history.back();
    }else if(save){
        alert('저장되었습니다');
        window.location.href = "./mypage.jsp?year="+yearValue+"&month="+monthValue+"&date="+dateValue;
    }else {
        alert("서버: 데이터베이스에 문제가 생겼습니다. 다시 시도해주세요.");
        window.history.back();
    }
   

</script>