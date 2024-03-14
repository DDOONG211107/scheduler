function findIdEvent() {
  // 이때 바로 value를 받아오는 게 아니라 정규식에 맞는지 체크를 해야 한다
  const nameValue = document.getElementById("nameInput").value;
  const emailValue = document.getElementById("emailInput").value;

  if (!nameValue || !emailValue) {
    alert("이름과 이메일을 모두 올바르게 입력해주세요");
    return;
  }
  document.getElementById("findIdForm").action = "../action/findIdAction.jsp";
  document.getElementById("findIdForm").submit();
}

function findPasswordEvent() {
  const idValue = document.getElementById("idInput").value;
  const emailValue = document.getElementById("emailInput").value;

  if (!idValue || !emailValue) {
    alert("아이디와 이메일을 모두 올바르게 입력해주세요");
    return;
  }

  document.getElementById("findPasswordForm").action =
    "../action/findPasswordAction.jsp";
  document.getElementById("findPasswordForm").submit();
}
