const userArr = [
  {
    name: "테스트이름1",
    email: "test1@test.com",
    id: "test1",
    password: "1111",
  },
  {
    name: "테스트이름2",
    email: "test2@test.com",
    id: "test2",
    password: "2222",
  },
  {
    name: "테스트이름3",
    email: "test3@test.com",
    id: "test3",
    password: "3333",
  },
];

function checkSameValue(event, num) {
  if (num === 1) {
    const id = document.getElementById("idInput").value;
    for (let i = 0; i < userArr.length; i++) {
      if (userArr[i].id === id) {
        alert("중복 id");
        return;
      }
    }
    alert("사용 가능 id");
    return;
  } else if (num === 2) {
    const email = document.getElementById("emailInput").value;
    for (let i = 0; i < userArr.length; i++) {
      if (userArr[i].email === email) {
        alert("해당 이메일은 사용할 수 없습니다");
        return;
      }
    }
    alert("해당 이메일은 사용할 수 있습니다");
  } else if (num === 3) {
    const id = document.getElementById("idInput").value;
    const email = document.getElementById("emailInput").value;
    for (let i = 0; i < userArr.length; i++) {
      if (userArr[i].id === id) {
        // alert("해당 id로는 회원가입 할 수 없습니다. id 중복확인을 해주세요.");
        // return true;
        return "해당 id로는 회원가입 할 수 없습니다. id 중복확인을 해주세요.";
      }
      if (userArr[i].email === email) {
        // alert(
        //   "해당 이메일로는 회원가입 할 수 없습니다. 이메일 중복확인을 해주세요."
        // );
        // return true;
        return "해당 이메일로는 회원가입 할 수 없습니다. 이메일 중복확인을 해주세요.";
      }
    }
    return false;
  } else {
    alert("여긴 안돼");
  }
  return;
}

function signup(event) {
  const sameValue = checkSameValue(event, 3);
  if (sameValue) {
    alert(sameValue);
    return;
  } else {
    const id = document.getElementById("idInput").value.trim();
    const name = document.getElementById("nameInput").value.trim();
    const email = document.getElementById("emailInput").value.trim();
    const password = document.getElementById("passwordInput").value.trim();
    const passwordCheck = document
      .getElementById("passwordCheckInput")
      .value.trim();
    const team = document.querySelector('input[name="teamSelect"]:checked');
    const rank = document.querySelector('input[name="rankSelect"]:checked');

    try {
      if (id.length <= 0 || id.length > 20) {
        throw "id는 1자 이상, 20자 이하로 작성해주세요.";
      }
      if (name.length <= 0 || id.length > 10) {
        throw "이름은 1자 이상, 10자 이하로 작성해주세요.";
      }
      if (email.length <= 0 || email.length > 20 || !email.includes("@")) {
        throw "이메일은 1자 이상, 20자 이하로 작성해주세요.";
      }
      if (password.length <= 0 || password.length > 20) {
        throw "비밀번호는 1자 이상, 20자 이하로 작성해주세요.";
      }
      if (password != passwordCheck) {
        throw "비밀번호가 일치하지 않습니다.";
      }
      if (team === null || rank === null) {
        throw "부서와 직급을 올바르게 선택해주세요.";
      }
      if (team.value != "team1" && team.value != "team2") {
        throw "부서를 올바르게 선택해주세요.";
      }
      if (rank.value != "rank1" && rank.value != "rank2") {
        throw "직급을 올바르게 선택해주세요.";
      }

      alert("회원가입이 완료되었습니다. 로그인창으로 이동합니다.");
      window.location.href = "../index.html";
    } catch (e) {
      alert(e);
      return;
    }
  }
}
