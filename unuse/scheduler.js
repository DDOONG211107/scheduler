let yearValue = 0;
let monthValue = 0;
let dateValue = 0;

let currentYear = 0;
let currentMonth = 0;
let currentDate = 0;

let myName = "최민석";
let myRank = "rank1";

const dateNumArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

const createScheduleModal = document.getElementById("createScheduleModal");
const scheduleDetailModal = document.getElementById("scheduleDetailModal");

// 맨 처음 오늘 날짜를 불러온다.
function getCurrentDate() {
  const currentDateObj = new Date();
  yearValue = currentDateObj.getFullYear();
  monthValue = currentDateObj.getMonth();
  dateValue = currentDateObj.getDate();

  currentYear = yearValue;
  currentMonth = monthValue;
  currentDate = dateValue;

  // const current = { year, month, date };
  // document.getElementById("year").innerText = yearValue;
  // document.getElementById("calander").innerText = date;
}

// 월 버튼 만들기
function createMonthBtns() {
  const monthDiv = document.getElementById("monthDiv");
  for (let i = 1; i < 13; i++) {
    const month = document.createElement("div");
    month.innerText = i;
    month.className = "monthBtn";
    month.setAttribute("onclick", `changeMonthEvent(event,${i - 1})`);
    monthDiv.appendChild(month);
  }
}

// 일 버튼 만들기
function createDateBtns() {
  let totalDateNum = 0;
  if (
    monthValue == 0 ||
    monthValue == 2 ||
    monthValue == 4 ||
    monthValue == 6 ||
    monthValue == 7 ||
    monthValue == 9 ||
    monthValue == 11
  ) {
    totalDateNum = 31;
    document.getElementById("calander").className = "calander";
  } else if (
    monthValue == 3 ||
    monthValue == 5 ||
    monthValue == 8 ||
    monthValue == 10
  ) {
    totalDateNum = 30;
    document.getElementById("calander").className = "calander";
  } else if (monthValue == 1) {
    console.log("2월!!!!");
    totalDateNum = 28;
    document.getElementById("calander").className = "feb";
  } else {
    alert("뭔가 잘못되었음");
    return;
  }

  const calander = document.getElementById("calander");
  for (let i = 0; i < totalDateNum; i++) {
    const dateElem = document.createElement("div");
    dateElem.className = "date";
    dateElem.innerText = i + 1;
    dateElem.setAttribute(
      "onclick",
      `scheduleDetailEvent(event,${yearValue}, ${monthValue}, ${i + 1})`
    );
    calander.appendChild(dateElem);
  }

  // alert(totalDateNum);
  return;
}

// 일마다 스케줄 개수 넣어주기
function setScheduleNumOnDate() {
  const scheduleArr = scheduleDataArr;
  for (let i = 0; i < scheduleArr.length; i++) {
    if (scheduleArr[i].year === yearValue) {
      if (scheduleArr[i].month === monthValue + 1) {
        // 화면에 표시된 연도와 월이 모두 일치하는 상황이므로 스케줄을 화면에 출력해야 함
        const scheduleNumElem = document.createElement("div");
        scheduleNumElem.innerText = scheduleArr[i].schedule;
        scheduleNumElem.className = "scheduleNum";
        // console.log("여기!");

        const date = scheduleArr[i].date; // 스케줄의 날짜 (ex.4일이면 4)
        const calander = document.getElementById("calander");
        calander.children[date - 1].appendChild(scheduleNumElem);
      }
    }
  }
}

function removeScheduleNumFromDate() {
  const calander = document.getElementById("calander");
  // console.log(dateNumArr[monthValue]);
  for (let i = 0; i < dateNumArr[monthValue]; i++) {
    // console.log(calander.children[i].children.length);
    if (calander.children[i].children.length == 1) {
      // console.log(calander.children[i].innerText);
      calander.children[i].removeChild(calander.children[i].children[0]);
    }
    // calander.children[i].removeChild(calander.children[i].firstChild);
  }
}

function setToday() {
  console.log(yearValue, monthValue, dateValue);
  console.log(currentYear, currentMonth, currentDate);
  if (yearValue == currentYear && monthValue == currentMonth) {
    console.log(yearValue, monthValue);
    document
      .getElementById("calander")
      .children[currentDate - 1].setAttribute("id", "today");
  }
}

function getScheduleDetail(selectedYear, selectedMonth, selectedDate) {
  const allScheduleArr = scheduleDetailDataArr;
  const selectedScheduleArr = [];

  for (let i = 0; i < allScheduleArr.length; i++) {
    const schedule = allScheduleArr[i];
    if (
      schedule.year == selectedYear &&
      schedule.month == selectedMonth + 1 &&
      schedule.date == selectedDate
    ) {
      selectedScheduleArr.push(schedule);
    }
  }

  return selectedScheduleArr;
}

function checkValue(year, month, date, hour, minute, content) {
  const yearValue = parseInt(year);
  const monthValue = parseInt(month);
  const dateValue = parseInt(date);
  const hourValue = parseInt(hour);
  const minuteValue = parseInt(minute);

  if (yearValue < 1977 || yearValue > 2099) {
    return "연도";
  }
  if (monthValue < 1 || monthValue > 12) {
    return "월";
  }
  if (
    monthValue == 1 ||
    monthValue == 3 ||
    monthValue == 5 ||
    monthValue == 7 ||
    monthValue == 8 ||
    monthValue == 10 ||
    monthValue == 12
  ) {
    if (dateValue < 1 || dateValue > 31) {
      return "일간";
    }
  }
  if (
    monthValue == 4 ||
    monthValue == 6 ||
    monthValue == 9 ||
    monthValue == 11
  ) {
    if (dateValue < 1 || date > 30) {
      return "일간";
    }
  }
  if (monthValue == 2) {
    if (dateValue < 1 || dateValue > 28) {
      return "일간";
    }
  }
  if (hourValue < 0 || hourValue > 23) {
    return "시간";
  }
  if (minuteValue < 0 || minuteValue > 59) {
    return "분";
  }
  if (content.trim().length < 1 || content.trim().length > 20) {
    return "스케줄 내용";
  }

  return false;
}

window.logoutEvent = function (event) {
  alert("로그아웃 되었습니다. 로그인 페이지로 이동합니다.");
  window.location.href = "../index.html";
};

window.createScheduleEvent = function (event) {
  createScheduleModal.style.display = "block";
};

window.closeWritingScheduleModalEvent = function (event) {
  createScheduleModal.style.display = "none";
};

// 모달 외부 클릭 시 모달 닫기
window.onclick = function (event) {
  if (event.target == createScheduleModal) {
    createScheduleModal.style.display = "none";
  } else if (event.target == scheduleDetailModal) {
    scheduleDetailModal.style.display = "none";
  }
};

window.mypageEvent = function (event) {
  alert("현재 준비중인 기능입니다");
};

window.editScheduleEvent = function (event) {
  // 숨겨둔 거 전부 보이게 하기
  // const saveBtn = document.getElementById("saveBtn");
  // saveBtn.style.display = "flex";

  const timeInput = event.target.parentNode.parentNode.children[1];
  timeInput.style.display = "flex";

  event.target.parentNode.parentNode.children[2].style.display = "flex";

  // 기존꺼 전부 안보이게 하기
  const clickedSchedule = event.target.parentNode.parentNode.parentNode;
  clickedSchedule.className = "formOpenSchedule";
  clickedSchedule.children[0].style.display = "none";
  clickedSchedule.children[1].style.display = "none";
  clickedSchedule.children[2].style.display = "none";

  event.target.parentNode.style.display = "none";
  // document.getElementById("editBtn").style.display = "none";
  // document.getElementById("deleteBtn").style.display = "none";
  // alert("수정 이벤트");
  return;
};

window.deleteScheduleEvent = function (event) {
  alert("삭제 이벤트");
  window.location.href = "../page/scheduler.html";

  return;
};

window.saveScheduleEvent = function (event) {
  const clickedScheduleTimeInput =
    event.target.parentNode.parentNode.children[1];
  const year = clickedScheduleTimeInput.children[0].value;
  const month = clickedScheduleTimeInput.children[2].value;
  const date = clickedScheduleTimeInput.children[4].value;
  const hour = clickedScheduleTimeInput.children[6].value;
  const minute = clickedScheduleTimeInput.children[8].value;
  const content = event.target.parentNode.children[0].value;

  const isError = checkValue(year, month, date, hour, minute, content);
  if (isError) {
    alert(isError + " 정보가 정확하지 않습니다. 다시 입력해주세요.");
    return;
  }
  alert(
    year +
      "년" +
      month +
      "월" +
      date +
      "일" +
      hour +
      "시" +
      minute +
      "분" +
      content +
      "로 db업데이트 필요"
  );
  window.location.href = "../page/scheduler.html";
  return;
};

window.writeScheduleEvent = function (event) {
  const timeInput = document.getElementById("scheduleFormTimeInput");

  const year = timeInput.children[0].value;
  const month = timeInput.children[2].value;
  const date = timeInput.children[4].value;
  const hour = timeInput.children[6].value;
  const minute = timeInput.children[8].value;
  const content = document.getElementById("scheduleFormContentInput")
    .children[1].value;

  const isError = checkValue(year, month, date, hour, minute, content);
  if (isError) {
    alert(isError + " 정보가 정확하지 않습니다. 다시 입력해주세요.");
    return;
  }
  alert(
    year +
      "년" +
      month +
      "월" +
      date +
      "일" +
      hour +
      "시" +
      minute +
      "분 " +
      content +
      " 로 db에 생성 필요"
  );
  window.location.href = "../page/scheduler.html";
  return;
};

window.scheduleDetailEvent = function (event, year, month, date) {
  scheduleDetailModal.style.display = "block";
  document.getElementById("clickedDate").innerText = `${year}년 ${
    month + 1
  }월 ${date}일`;

  // 이 날짜에 해당하는 스케줄을 싹 지워야 함
  const scheduleUl = document.getElementById("scheduleList");
  while (scheduleUl.firstChild) {
    scheduleUl.removeChild(scheduleUl.firstChild);
  }

  // 이 날짜에 해당하는 스케줄을 가져와야 함
  const scheduleArr = getScheduleDetail(year, month, date);

  for (let i = 0; i < scheduleArr.length; i++) {
    // 하나의 li
    const scheduleList = document.createElement("li");
    scheduleList.className = "schedule";
    // schedule 객체
    const schedule = scheduleArr[i];

    // 내가 팀장일 경우 이름 부분을 만들어야 함
    if (myRank === "rank1") {
      const name = document.createElement("span");
      name.innerText = schedule.writer;
      name.className = "scheduleName";
      scheduleList.appendChild(name);
    }

    // 시간 부분을 만들어야 함
    const time = document.createElement("span");
    time.innerText = `${schedule.hour}시 ${schedule.minute}분`;
    time.className = "scheduleTime";
    scheduleList.appendChild(time);

    // content부분을 만들어야 함
    const content = document.createElement("span");
    content.innerText = schedule.content;
    content.className = "scheduleContent";
    scheduleList.appendChild(content);

    // 이 스케줄이 나의 스케줄일 경우 form을 만들어야 함
    // form 안에 타임인풋5개와 글쓰기 인풋, 저장 버튼을 안 보이게 만들어야 함
    // 타임인풋과 글쓰기 인풋에는 미리 값이 들어가 있어야 함
    // 저장 버튼을 누르면 값을 검사해야 함
    // form 안에 삭제와 수정 버튼을 미리 보이게 만들어야 함
    if (myName == schedule.writer) {
      const form = document.createElement("form");
      form.className = "scheduleEditDeleteForm";

      const editDeleteBtnDiv = document.createElement("div");
      editDeleteBtnDiv.className = "editDeleteBtnDiv";
      // editDeleteBtnDiv.style.display = "flex";

      const editBtn = document.createElement("div");
      editBtn.innerText = "수정";
      editBtn.className = "blueBtn editBtn";
      // editBtn.setAttribute("id", "editBtn");
      editBtn.setAttribute("onclick", "editScheduleEvent(event)");

      const deleteBtn = document.createElement("div");
      deleteBtn.innerText = "삭제";
      deleteBtn.className = "greyBtn deleteBtn";
      // deleteBtn.setAttribute("id", "deleteBtn");
      deleteBtn.setAttribute("onclick", "deleteScheduleEvent(event)");

      editDeleteBtnDiv.appendChild(editBtn);
      editDeleteBtnDiv.appendChild(deleteBtn);
      form.appendChild(editDeleteBtnDiv);

      // 여기서부턴 타임인풋
      const scheduleEditTimeInput = document.createElement("div");
      // scheduleEditTimeInput.setAttribute("id", "scheduleEditTimeInput");
      scheduleEditTimeInput.className = "scheduleEditTimeInput";

      const yearInput = document.createElement("input");
      yearInput.setAttribute("type", "number");
      yearInput.setAttribute("value", schedule.year);
      yearInput.setAttribute("name", "yearInput");
      yearInput.className = "scheduleFormInput";
      scheduleEditTimeInput.appendChild(yearInput);

      const yearSpan = document.createElement("span");
      yearSpan.innerText = "년";
      yearSpan.className = "scheduleFormSpan";
      scheduleEditTimeInput.appendChild(yearSpan);

      const monthInput = document.createElement("input");
      monthInput.setAttribute("type", "number");
      monthInput.setAttribute("value", schedule.month);
      monthInput.setAttribute("name", "nameInput");
      monthInput.className = "scheduleFormInput";
      scheduleEditTimeInput.appendChild(monthInput);

      const monthSpan = document.createElement("span");
      monthSpan.innerText = "월";
      monthSpan.className = "scheduleFormSpan";
      scheduleEditTimeInput.appendChild(monthSpan);

      const dateInput = document.createElement("input");
      dateInput.setAttribute("type", "number");
      dateInput.setAttribute("value", schedule.date);
      dateInput.setAttribute("name", "dateInput");
      dateInput.className = "scheduleFormInput";
      scheduleEditTimeInput.appendChild(dateInput);

      const dateSpan = document.createElement("span");
      dateSpan.innerText = "일";
      dateSpan.className = "scheduleFormSpan";
      scheduleEditTimeInput.appendChild(dateSpan);

      const hourInput = document.createElement("input");
      hourInput.setAttribute("type", "number");
      hourInput.setAttribute("value", schedule.hour);
      hourInput.setAttribute("name", "hourInput");
      hourInput.className = "scheduleFormInput";
      scheduleEditTimeInput.appendChild(hourInput);

      const hourSpan = document.createElement("span");
      hourSpan.innerText = "시";
      hourSpan.className = "scheduleFormSpan";
      scheduleEditTimeInput.appendChild(hourSpan);

      const minuteInput = document.createElement("input");
      minuteInput.setAttribute("type", "number");
      minuteInput.setAttribute("value", schedule.minute);
      minuteInput.setAttribute("name", "minuteInput");
      minuteInput.className = "scheduleFormInput";
      scheduleEditTimeInput.appendChild(minuteInput);

      const minuteSpan = document.createElement("span");
      minuteSpan.innerText = "분";
      minuteSpan.className = "scheduleFormSpan";
      scheduleEditTimeInput.appendChild(minuteSpan);

      scheduleEditTimeInput.style.display = "none";
      form.appendChild(scheduleEditTimeInput);

      // 여기서부턴 글쓰기 인풋과 저장 버튼

      const scheduleContentSaveBtnDiv = document.createElement("div");
      // scheduleContentSaveBtnDiv.setAttribute("id", "scheduleContentSaveBtnDiv");
      scheduleContentSaveBtnDiv.className = "scheduleContentSaveBtnDiv";

      const scheduleContentInput = document.createElement("input");
      // scheduleContentInput.setAttribute("id", "scheduleContentInput");
      scheduleContentInput.className = "scheduleContentInput";
      scheduleContentInput.setAttribute("value", schedule.content);
      scheduleContentInput.setAttribute("name", "contentInput");
      scheduleContentInput.setAttribute(
        "placeholder",
        "1자 이상 20자 이하로 입력해주세요"
      );
      scheduleContentSaveBtnDiv.appendChild(scheduleContentInput);

      const saveBtn = document.createElement("div");
      saveBtn.innerText = "저장";
      saveBtn.className = "blueBtn saveBtn";
      saveBtn.setAttribute("onclick", "saveScheduleEvent(event)");
      // saveBtn.setAttribute("id", "saveBtn");
      scheduleContentSaveBtnDiv.appendChild(saveBtn);

      scheduleContentSaveBtnDiv.style.display = "none";
      form.appendChild(scheduleContentSaveBtnDiv);

      // 이제 form완성

      scheduleList.appendChild(form);
    } else {
      scheduleList.style.backgroundColor = schedule.color;
    }

    scheduleUl.appendChild(scheduleList);
  }
};

window.yearMinusEvent = function (event) {
  // alert('연도를 하나 줄여야 함');
  yearValue--;
  document.getElementById("year").innerText = yearValue;
  // removeScheduleNumFromDate();
  // setScheduleNumOnDate();
  // setToday();
  // return;
  const calander = document.getElementById("calander");
  while (calander.firstChild) {
    calander.removeChild(calander.firstChild);
  }

  createDateBtns();
  setScheduleNumOnDate();
  setToday();
  return;
};

window.yearPlusEvent = function (event) {
  yearValue++;
  document.getElementById("year").innerText = yearValue;
  // removeScheduleNumFromDate();
  // setScheduleNumOnDate();
  // setToday();

  // return;
  const calander = document.getElementById("calander");
  while (calander.firstChild) {
    calander.removeChild(calander.firstChild);
  }

  createDateBtns();
  setScheduleNumOnDate();
  setToday();
  return;
};

window.changeMonthEvent = function (event, month) {
  monthValue = month;
  const calander = document.getElementById("calander");
  while (calander.firstChild) {
    calander.removeChild(calander.firstChild);
  }

  createDateBtns();
  setScheduleNumOnDate();
  setToday();
  return;
};

getCurrentDate();
createMonthBtns();
createDateBtns();
setScheduleNumOnDate();
setToday();
