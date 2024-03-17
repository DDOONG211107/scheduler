<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%
    request.setCharacterEncoding("utf-8"); 

    // 현재 연도와 월이 그대로 출력됨
    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dateValue = request.getParameter("date");

    String id = "testId";
    String name = "테스트이름";
    String email = "test@test.com";
    String password = "1234";
    String team = "기획팀";
    String rank = "팀장";

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
            alert("탈퇴");
            window.location.href = "../index.html";
        }

        setMypageContentData();
    </script>
  </body>
</html>
