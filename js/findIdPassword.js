function findIdEvent() {
  // 이때 바로 value를 받아오는 게 아니라 정규식에 맞는지 체크를 해야 한다
  const nameValue = document.getElementById("nameInput").value;
  const emailValue = document.getElementById("emailInput").value;

  const nameRegex = /^[a-zA-Z가-힣]{1,10}$/;
  const emailRegex =
    /^([a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*.[a-zA-Z0-9]*){1,20}$/;

  try {
    if (!nameRegex.test(nameValue)) {
      throw "이름은 올바른 형식으로 1자 이상 10자 이하로 입력해주세요.";
    }

    if (!emailRegex.test(emailValue)) {
      throw "이메일은 올바른 형식으로 1자 이상 20자 이하로 입력해주세요.";
    }

    document.getElementById("findIdForm").action = "../action/findIdAction.jsp";
    document.getElementById("findIdForm").submit();
  } catch (e) {
    alert(e);
    return;
  }
}

function findPasswordEvent() {
  const idValue = document.getElementById("idInput").value;
  const emailValue = document.getElementById("emailInput").value;

  const idRegex = /^[a-zA-Z0-9]{1,20}$/;
  const emailRegex =
    /^([a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*.[a-zA-Z0-9]*){1,20}$/;

  try {
    if (!idRegex.test(idValue)) {
      throw "아이디는 올바른 형식으로 1자 이상 20자 이하로 입력해주세요";
    }

    if (!emailRegex.test(emailValue)) {
      throw "이메일은 올바른 형식으로 1자 이상 20자 이하로 입력해주세요.";
    }

    document.getElementById("findPasswordForm").action =
      "../action/findPasswordAction.jsp";
    document.getElementById("findPasswordForm").submit();
  } catch (e) {
    alert(e);
    return;
  }
}
