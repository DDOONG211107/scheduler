const userObj = {
  test1: "1111",
  test2: "2222",
  test3: "3333",
};

function loginEvent() {
  const idValue = document.getElementById("idInput").value;
  const passwordValue = document.getElementById("passwordInput").value;
  if (userObj[idValue] === passwordValue) {
    window.location.href = "./page/scheduler.html";
  } else {
    alert("로그인 실패");
  }
}

function signupEvent() {
  window.location.href = "./page/signup.html";
}

function findIdEvent() {
  window.location.href = "./page/findId.html";
}

function findPasswordEvent() {
  window.location.href = "./page/findPassword.html";
}
