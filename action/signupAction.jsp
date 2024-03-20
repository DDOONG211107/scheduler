<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->


<% 
    request.setCharacterEncoding("utf-8"); 

    boolean signup = false;
    boolean isError = true;

    String id =  request.getParameter("id");
    String email = request.getParameter("email");
    String name =  request.getParameter("nameInput");
    String password =  request.getParameter("passwordInput");
    String passwordCheck = request.getParameter("passwordCheckInput");
    String team =   request.getParameter("teamSelect");
    String rank =  request.getParameter("rankSelect");
    String alertString = "";

     try{
        String idReg = "^[a-zA-Z0-9]{1,20}$";
        Pattern pattern  = Pattern.compile(idReg);

        if(!pattern.matcher(id).matches()){
            throw new IllegalArgumentException("서버: 아이디 오류");
        }

        String emailReg = "^(?:[a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*\\.[a-zA-Z0-9]*){1,20}$";
        pattern = Pattern.compile(emailReg);

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

        // 모든 정규식을 통과했으니 이제 db 연결
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        // 이 사이에 select로 아이디와 이메일이 유효한지 한번 더 체크한다.

        String sql = "SELECT * FROM account WHERE id = ? OR email = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,id);
        query.setString(2,email);

        ResultSet result = query.executeQuery();

        if(result.next()){
            throw new Exception("서버: 해당 아이디 또는 이메일은 중복입니다.");
        }

        // 이제 진짜로 insert 가능

        isError = false;

        sql = "INSERT INTO account (id, email, name, password, team, rank) VALUES (?, ?, ?, ?, ?, ?)";
        query = connect.prepareStatement(sql);
        query.setString(1, id);
        query.setString(2, email);
        query.setString(3, name);
        query.setString(4, password);
        query.setString(5, team);
        query.setString(6, rank);

        query.executeUpdate();

        signup = true;

    }catch(Exception e){
        alertString = e.getMessage();
    }


%>

<script>

    const id = "<%=id%>";
    const email = "<%=email%>";
    const name = "<%=name%>";
    const password = "<%=password%>";
    const team = "<%=team%>";
    const rank = "<%=rank%>";

    const signup = <%=signup%>;
    const isError = <%=isError%>;
    const alertString = "<%=alertString%>";

    if(isError){
        alert(alertString);
        window.history.back();
    }else{
        if(signup){
            // alert(id+" "+email+" "+name+" "+password+" "+team+" "+rank+"로 회원가입 했다고 가정. 로그인페이지로 이동");
            window.location.href = "../index.html";
        }else {
            alert("서버: 데이터베이스에 문제가 생겼습니다. 다시 시도해주세요.");
            window.history.back();
        }
    }

    

</script>