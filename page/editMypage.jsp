<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8"); 

    String userIdx =  ((String) session.getAttribute("userIdx"));
    boolean isError = true;

    String id = "";
    String name = "";
    String email = "";
    String password = "";
    String team = "";
    String rank = "";
    String newEmail = "";

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

    String sql = "SELECT * FROM account WHERE idx = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,userIdx);

    ResultSet result = query.executeQuery();
    if(result.next()){
        isError = false;
        id = result.getString(3);
        name = result.getString(4);
        email = result.getString(5);
        password = result.getString(6);
        team = result.getString(7);
        rank = result.getString(8);

    } else {
        isError = true;
    }

    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dateValue = request.getParameter("date");

    String checkEmail = request.getParameter("checkEmail");
    String trueString = "true";

    if(checkEmail!=null &&  checkEmail.equals(trueString)){
        newEmail = request.getParameter("newEmail");
    }

%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../global.css" />
    <link rel="stylesheet" href="../style/signup.css?randomTomcat" />

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
        
    <form id="editForm" method="post">
      
      <div class="normalForm">
        <label>이메일</label>
        <div class="flexDiv">
          <input
            type="email"
            maxlength="20"
            id="emailInput"
            name="email"
          />
          <div
            class="blueBtn"
            id="checkEmailBtn"
            value="email"
            onclick="checkSameEmailEvent(event)"
          >
            이메일 중복확인
          </div>
        </div>
      </div>

      <div class="normalForm">
        <label>이름</label>
        <input type="text" maxlength="10" id="nameInput" name="nameInput" />
      </div>
      
      <div class="normalForm">
        <label>비밀번호</label>
        <input
          type="password"
          maxlength="20"
          id="passwordInput"
          name="passwordInput"
        />
        <span class="blockSpan"
          >비밀번호는 최대 20자까지 입력할 수 있습니다
        </span>
      </div>

      <div class="normalForm">
        <label>비밀번호 확인</label>
        <input
          type="password"
          maxlength="20"
          id="passwordCheckInput"
          name="passwordCheckInput"
        />
      </div>

      <div class="selectOption">
        부서
        <input type="radio" id="team1" name="teamSelect" value="기획팀" />
        <label for="team1">기획팀</label>
        <input type="radio" id="team2" name="teamSelect" value="디자인팀" />
        <label for="team2">디자인팀</label>
      </div>

      <div class="selectOption">
        직급
        <input type="radio" id="rank1" name="rankSelect" value="팀장" />
        <label for="rank1">팀장</label>
        <input type="radio" id="rank2" name="rankSelect" value="팀원" />
        <label for="rank2">팀원</label>
      </div>

      <div class="blueBtn" id="saveMypageBtn" onclick="saveMypageEvent()">정보수정</div>

      <input class="notDisplay" name="checkEmail" id="checkEmail"/>
      <input class="notDisplay" name="year" id="yearValue">
      <input class="notDisplay" name="month" id="monthValue">
      <input class="notDisplay" name="date" id="dateValue">

    </form>
    </main>
    <script>

        const userIdx = <%=userIdx%>;
        if(!userIdx){
            alert("로그인 후 이용해주세요.");
            window.location.href = "../index.html";
        }

        const yearValue = "<%=yearValue%>";
        const monthValue = "<%=monthValue%>";
        const dateValue = "<%=dateValue%>";

        const id = "<%=id%>";
        const name = "<%=name%>";
        const email = "<%=email%>";
        const password = "<%=password%>";
        const team = "<%=team%>";
        const rank = "<%=rank%>";
        const checkEmail = "<%=checkEmail%>";
        const newEmail = "<%=newEmail%>";

        if(checkEmail && checkEmail != "null" && checkEmail != "false") {
            console.log("새 이메일: ",newEmail);
            document.getElementById('emailInput').setAttribute('readonly','true');
            document.getElementById('emailInput').value = newEmail;
            document.getElementById('checkEmailBtn').style.display = 'none';
        } else {
            document.getElementById("emailInput").value = email;

        }

        document.getElementById("yearValue").value = yearValue;
        document.getElementById("monthValue").value = monthValue;
        document.getElementById("dateValue").value = dateValue;

        document.getElementById("nameInput").value = name;
        document.getElementById("passwordInput").value = password;
        document.getElementById("passwordCheckInput").value = password;

        if(team == "기획팀"){
            document.getElementById("team1").setAttribute("checked","true");
        }else if(team == "디자인팀"){
            document.getElementById("team2").setAttribute("checked","true");
        }

        if(rank == "팀장"){
            document.getElementById("rank1").setAttribute("checked","true");
        } else if(rank == "팀원"){
            document.getElementById("rank2").setAttribute("checked", "true");
        }

        function schedulerEvent(event) {
            window.location.href = "./scheduler.jsp?year="+yearValue+"&month="+monthValue+"&date="+dateValue;
        }

        function logoutEvent() {
            window.location.href = "../index.html";
        }

        function checkSameEmailEvent(event) {
            const emailRegex =
                /^([a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*.[a-zA-Z0-9]*){1,20}$/;
            const emailValue = document.getElementById("emailInput").value;
            const validEmail = emailRegex.test(emailValue);

            if (!validEmail) {
                alert("이메일은 올바른 형식으로 1자 이상 20자 이하로 입력해주세요.");
                return;
            }
            document.getElementById("editForm").action =
                "../action/checkSameEmailAction.jsp?email="+emailValue+"&isEdit=true";
            document.getElementById("editForm").submit();
        }

        function saveMypageEvent(event) {
            if(checkEmail=="true")
                {
                    // 이름 정규식 체크하고 안되면 알림 띄우기
                    // 비밀번호 정규식 체크하고 안되면 알림
                    // 비밀번호 확인 정규식 체크하고 안되면 알림
                    // 비밀번호랑 비밀번호 정규식이 일치하지 않으면 알림
                    // 부서 확인하고 안되면 알림
                    // 직급 확인하고 안되면 알림
                    // 모두 통과하면 확인용 알림 띄우고 액션으로 이동하기 (액션에서는 인덱스로 이동시키기)

                    const nameRegex = /^[a-zA-Z가-힣]{1,10}$/;
                    const passwordRegex = /^[a-zA-Z0-9]{1,20}$/;
                    const passwordCheckRegex = /^[a-zA-Z0-9]{1,20}$/;
                    
                    const nameValue = document.getElementById('nameInput').value;
                    const passwordValue = document.getElementById('passwordInput').value;
                    const passwordCheckValue = document.getElementById('passwordCheckInput').value;
                    const team = document.querySelector('input[name="teamSelect"]:checked');
                    const rank = document.querySelector('input[name="rankSelect"]:checked');


                    try{
                    if(!nameRegex.test(nameValue)){
                        throw "이름은 한글 또는 영어로 1글자 이상 10자 이하로 입력해주세요.";
                    }
                    if(!passwordRegex.test(passwordValue)){
                        throw "비밀번호는 영문 또는 숫자 1자 이상 20자 이하로 입력해주세요.";
                    }
                    if(!passwordCheckRegex.test(passwordCheckValue)){
                        throw "비밀번호는 영문 또는 숫자 1자 이상 20자 이하로 입력해주세요.";                    
                    }
                    if(passwordValue != passwordCheckValue){
                        throw "비밀번호가 일치하지 않습니다."
                    }
                    if(team === null || rank === null){
                        throw "부서와 직급을 올바르게 선택해주세요.";
                    }
                    if(team.value != "기획팀" && team.value != "디자인팀"){
                        throw "부서를 올바르게 선택해주세요"
                    }
                    if(rank.value != "팀장" && rank.value != "팀원"){
                        throw "직급을 올바르게 선택해주세요"
                    }

                    // alert(id+" "+email+" "+nameValue+" "+ team.value+"로 회원가입 하기");
                    document.getElementById('editForm').action = "../action/saveMyPageAction.jsp?";
                    document.getElementById('editForm').submit();
                  
                } catch(e){
                  alert(e);
                }

            } else {
                    alert('이메일 중복확인을 해주세요');
            }

            return;
        }

    </script>
  </body>
</html>
