<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>

<%
    request.setCharacterEncoding("utf-8");

    String userIdx =  ((String) session.getAttribute("userIdx"));
    boolean isError = false;
    String id = "";
    String name = "";
    String email = "";
    String password = "";
    String team = "";
    String rank = "";

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

    String sql = "SELECT * FROM account WHERE idx = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,userIdx);

    ResultSet result = query.executeQuery();
    if(result.next()){
        id = result.getString(3);
        name = result.getString(4);
        email = result.getString(5);
        password = result.getString(6);
        team = result.getString(7);
        rank = result.getString(8);
    } else {
        isError = true;
    }

    // 현재 연도와 월이 그대로 출력됨
    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dateValue = request.getParameter("date");

%>

<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../global.css" />
    <link rel="stylesheet" href="../style/scheduler.css" />
    <link rel="stylesheet" href = "../style/mypage.css?randomCss" />
    <title>솔가레오</title>
  </head>

  <body>
    <header>
      <div id="headerLogo"><span onclick="schedulerEvent(event)" class="spanBtn">솔가레오</span></div>
      <div id="headerNav">      
        <span onclick="logoutEvent(event)" class="spanBtn">로그아웃</span>
      </div>
    </header>

    <main>
        
        <h1 id="mypageTitle">마이페이지</h1>
        
        <form id="mypage">

            <div id="mypageContent">

                <div id="mypageContentLabel">
                    <span class="blockSpan">아이디</span>
                    <span class="blockSpan">이름</span>
                    <span class="blockSpan">이메일</span>
                    <span class="blockSpan">비밀번호</span>
                    <span class="blockSpan">부서</span>
                    <span class="blockSpan">직급</span>
                </div>

                <div id="mypageContentData">
                    <span class="blockSpan boldSpan" id="id"></span>
                    <span class="blockSpan boldSpan" id="name"></span>
                    <span class="blockSpan boldSpan" id="email"></span>
                    <span class="blockSpan boldSpan" id="password"></span>
                    <span class="blockSpan boldSpan" id="team"></span>
                    <span class="blockSpan boldSpan" id="rank"></span>
                </div>        
            </div>

            <div id="mypageBtns">
                <div class="blueBtn" id="editProfileBtn" onclick="editProfileEvent(event)">정보 수정</div>
                <div class="greyBtn" id="deleteAccountBtn" onclick="deleteAccountEvent(event)">회원 탈퇴</div>
            </div>
        </form>

    </main>
    <script>
    
        const yearValue = "<%=yearValue%>";
        const monthValue = "<%=monthValue%>";
        const dateValue = "<%=dateValue%>";

        const id = "<%=id%>";
        const name = "<%=name%>";
        const email = "<%=email%>";
        const password = "<%=password%>";
        const team = "<%=team%>";
        const rank = "<%=rank%>";

        // 마이페이지 내용 채우기
        function setMypageContentData(){
            document.getElementById("id").innerText = id;
            document.getElementById("name").innerText = name;
            document.getElementById("email").innerText = email;
            document.getElementById("password").innerText = password;
            document.getElementById("team").innerText = team;
            document.getElementById("rank").innerText = rank;
        }

        function schedulerEvent(event) {
            window.location.href = "./scheduler.jsp?year="+yearValue+"&month="+monthValue+"&date="+dateValue;
        }

        function logoutEvent() {
            window.location.href = "../index.html";
        }

        function editProfileEvent(event) {
            window.location.href = "./editMypage.jsp?year="+yearValue+"&month="+monthValue+"&date="+dateValue;
            return;
        }

        function deleteAccountEvent(event){
            window.location.href = "./deleteAccountAction.jsp";
        }

        setMypageContentData();
    </script>
  </body>
</html>
