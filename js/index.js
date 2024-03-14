const userObj = {
  test1: "1111",
  test2: "2222",
  test3: "3333",
};

function loginEvent() {
  const idValue = document.getElementById("idInput").value;
  const passwordValue = document.getElementById("passwordInput").value;
  const idRegex = /^[a-zA-Z0-9]{1,20}$/;
  const passwordRegex = /^[a-zA-Z0-9]{1,20}$/;
  const validId = idRegex.test(idValue);
  const validPassword = passwordRegex.test(passwordValue);

  if (!validId || !validPassword) {
    alert("id와 비밀번호를 올바르게 입력해주세요.");
    return;
  }

  document.getElementById("loginForm").action =
    "/scheduler/action/loginAction.jsp";
  document.getElementById("loginForm").submit();
}

function signupEvent() {
  document.getElementById("loginForm").action = "/scheduler/action/signup.jsp";
  document.getElementById("loginForm").submit();
}

function findIdEvent() {
  window.location.href = "./page/findId.html";
}

function findPasswordEvent() {
  window.location.href = "./page/findPassword.html";
}
