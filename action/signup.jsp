<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<% 
    request.setCharacterEncoding("utf-8"); 

    String id = "\""+ request.getParameter("id") +"\"";
    String email = "\"" + request.getParameter("email")+"\"";
    String checkId = "\"" +request.getParameter("checkId")+"\"" ;
    String checkEmail ="\"" + request.getParameter("checkEmail")+"\"" ;
%>

<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원가입</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../global.css" />
    <link rel="stylesheet" href="../style/signup.css" />
  </head>
  <body>
    <h1 id="signupLogo">회원가입</h1>

    <form id="signupForm" method="post">

      <div class="normalForm">
        <label>id</label>
        <div class="flexDiv">
          <input type="text" maxlength="20" id="idInput" name="id" />
          <div
            class="blueBtn"
            id="checkIdBtn"
            value="id"
            onclick="checkSameIdEvent(event)">
            id 중복확인
          </div>
        </div>
        <span class="blockSpan">id는 최대 20자까지 입력할 수 있습니다</span>
      </div>

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

      <div class="blueBtn" id="signupBtn" onclick="signupEvent()">회원가입</div>

      <input class="notDisplay" name="checkId" id="checkId"/>
      <input class="notDisplay" name="checkEmail" id="checkEmail"/>
    </form>
    <script>

        const checkId = <%=checkId%>;
        const checkEmail = <%=checkEmail%>;
        const id = <%=id%>;
        const email = <%=email%>;

        document.getElementById('checkId').value = checkId;
        document.getElementById('checkEmail').value = checkEmail;

        if(checkId && checkId!= "null" && checkId!= "false") {
            document.getElementById('idInput').setAttribute('readonly','true');
            document.getElementById('idInput').value = id;
            document.getElementById('checkIdBtn').style.display = 'none';
        }

        if(checkEmail && checkEmail != "null" && checkEmail!= "false") {
            document.getElementById('emailInput').setAttribute('readonly','true');
            document.getElementById('emailInput').value = email;
            document.getElementById('checkEmailBtn').style.display = 'none';
        }

        function checkSameIdEvent(event) {
            const idRegex = /^[a-zA-Z0-9]{1,20}$/;
            const idValue = document.getElementById("idInput").value;
            const validId = idRegex.test(idValue);

            if (!validId) {
                alert("id는 영어 또는 숫자, 1자 이상 20자 이하로 입력해주세요.");
                return;
            }
            document.getElementById("signupForm").action =
                "./checkSameIdAction.jsp?id="+idValue+"&email="+email+"&checkId="+checkId+"&checkEmail"+checkEmail;
            document.getElementById("signupForm").submit();
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
            document.getElementById("signupForm").action =
                "./checkSameEmailAction.jsp?id="+id+"&email="+emailValue+"&checkId="+checkId+"&checkEmail"+checkEmail;
            document.getElementById("signupForm").submit();
        }

        function signupEvent(){
          if(checkId == "true" && checkEmail=="true"){
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
                  document.getElementById('signupForm').action = "./signupAction.jsp";
                  document.getElementById('signupForm').submit();
                  
                }catch(e){
                  alert(e);
                }

          }else {
                alert('id와 이메일 중복확인을 해주세요')
          }
          
          return;
        }

    </script>
  </body>
</html>
