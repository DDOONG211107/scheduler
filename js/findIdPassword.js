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

function findId() {
  const nameValue = document.getElementById("nameInput").value.trim();
  const emailValue = document.getElementById("emailInput").value.trim();

  for (let i = 0; i < userArr.length; i++) {
    if (userArr[i].name === nameValue && userArr[i].email === emailValue) {
      const id = userArr[i].id;
      alert(`id는 ${id}입니다.`);
      window.location.href = "../index.html";
      return;
    }
  }
  alert("정보를 정확히 입력해 주세요.");
  return;
}

function findPassword() {
  const idValue = document.getElementById("idInput").value.trim();
  const emailValue = document.getElementById("emailInput").value.trim();

  for (let i = 0; i < userArr.length; i++) {
    if (userArr[i].id === idValue && userArr[i].email === emailValue) {
      const password = userArr[i].password;
      alert(`비밀번호는 ${password}입니다.`);
      window.location.href = "../index.html";
      return;
    }
  }
  alert("정보를 정확히 입력해 주세요.");
  return;
}
