<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%
    request.setCharacterEncoding("utf-8"); 

    // 현재 연도와 월이 그대로 출력됨
    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dateValue = request.getParameter("date");

    String id = "testId";
    String name = "테스트이름";
    // String email = request.getParameter("email");
    // if(email.equal(""))
    // {
    //     email = "test@test.com";
    // }
    String email = "test@test.com";
    String password = "1234";
    String team = "기획팀";
    String rank = "팀장";
    String checkEmail = request.getParameter("checkEmail");

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
        <input type="radio" id="team1" name="teamSelect" value="team1" />
        <label for="team1">기획팀</label>
        <input type="radio" id="team2" name="teamSelect" value="team2" />
        <label for="team2">디자인팀</label>
      </div>
      <div class="selectOption">
        직급
        <input type="radio" id="rank1" name="rankSelect" value="rank1" />
        <label for="rank1">팀장</label>
        <input type="radio" id="rank2" name="rankSelect" value="rank2" />
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

        if(checkEmail && checkEmail != "null") {
            document.getElementById('emailInput').setAttribute('readonly','true');
            document.getElementById('emailInput').value = email;
            document.getElementById('checkEmailBtn').style.display = 'none';
        }

        document.getElementById("yearValue").value = yearValue;
        document.getElementById("monthValue").value = monthValue;
        document.getElementById("dateValue").value = dateValue;

        console.log(yearValue);
        console.log(document.getElementById("yearValue").value);

        document.getElementById("nameInput").value = name;
        document.getElementById("emailInput").value = email;
        document.getElementById("passwordInput").value = password;
        document.getElementById("passwordCheckInput").value = password;
        document.getElementById("team1").setAttribute("checked","true");
        document.getElementById("rank1").setAttribute("checked","true");
        
        // document.getElementById("rankSelect").value = "rank1";
        

        function schedulerEvent(event) {
            window.location.href = "./scheduler.jsp?year="+yearValue+"&month="+monthValue+"&date="+dateValue;
        }

        function logoutEvent() {
            window.location.href = "../index.html";
        }


        function deleteAccountEvent(event){
            alert("탈퇴");
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
                "./checkSameEmailAction.jsp?email="+emailValue+"&isEdit=true";
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
                    if(!nameRegex.test(nameValue))
                    {
                        throw "이름은 한글 또는 영어로 1글자 이상 10자 이하로 입력해주세요.";
                    }
                    if(!passwordRegex.test(passwordValue))
                    {
                        throw "비밀번호는 영문 또는 숫자 1자 이상 20자 이하로 입력해주세요.";
                    }
                    if(!passwordCheckRegex.test(passwordCheckValue))
                    {
                        throw "비밀번호는 영문 또는 숫자 1자 이상 20자 이하로 입력해주세요.";                    
                    }
                    if(passwordValue != passwordCheckValue)
                    {
                        throw "비밀번호가 일치하지 않습니다."
                    }
                    if(team === null || rank === null)
                    {
                        throw "부서와 직급을 올바르게 선택해주세요.";
                    }
                    if(team.value != "team1" && team.value != "team2")
                    {
                        throw "부서를 올바르게 선택해주세요"
                    }
                    if(rank.value != "rank1" && rank.value != "rank2")
                    {
                        throw "직급을 올바르게 선택해주세요"
                    }

                    
                    // alert(id+" "+email+" "+nameValue+" "+ team.value+"로 회원가입 하기");
                    document.getElementById('editForm').action = "./saveMyPageAction.jsp?";
                    document.getElementById('editForm').submit();
                  
                }catch(e)
                {
                  alert(e);
                }

            }else {
                    alert('이메일 중복확인을 해주세요');
            }

            return;
        }

    </script>
  </body>
</html>
