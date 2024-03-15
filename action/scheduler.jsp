<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%
request.setCharacterEncoding("utf-8"); 

// 현재 연도와 월이 그대로 출력됨
String yearValue = request.getParameter("year");
String monthValue = request.getParameter("month");
String dateValue = request.getParameter("date");

%>


<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../global.css" />
    <%-- <link rel="stylesheet" href="../style/scheduler.css" /> --%>
    <link rel="stylesheet" href="../style/scheduler.css?randomString" />

    <title>솔가레오</title>
  </head>
  <body>

    <header>

      <div id="headerLogo">솔가레오</div>
      <div id="headerNav">
        <span onclick="createScheduleEvent(event)" class="spanBtn"
          >스케줄쓰기</span
        >
        <span onclick="mypageEvent(event)" class="spanBtn">마이페이지</span>
        <span onclick="logoutEvent()" class="spanBtn">로그아웃</span>
      </div>
      
    </header>

    <main>

    <div id="createScheduleModal" class="modal" onclick="clickModalOverlay(event)">
        <div class="modalContent">
          <form id="createScheduleForm">
            <div id="scheduleFormTimeInput">
              <input type="number" maxlength="4" class="scheduleFormInput" name="newYear" />
              <span class="scheduleFormSpan">년</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newMonth" />
              <span class="scheduleFormSpan">월</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newDate" />
              <span class="scheduleFormSpan">일</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newHour" />
              <span class="scheduleFormSpan">시</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newMinute" />
              <span class="scheduleFormSpan">분</span>
            </div>
            <div id="scheduleFormContentInput">
              <label>스케줄 내용</label>
              <input
                type="text"
                placeholder="1자이상 20자 이하로 입력해 주세요."
                name="newContent"
              />
            </div>
            <input class="notDisplay" name="descYear" id="descYear">
            <input class="notDisplay" name="descMonth" id="descMonth">
            <input class="notDisplay" name="descDate" id="descDate">

            <div id="scheduleFormBtnSection">
              <div
                class="greyBtn"
                onclick="closeCreatingScheduleModalEvent(event)"
              >
                닫기
              </div>
              <div class="blueBtn" onclick="saveScheduleEvent(event)">
                스케줄 저장
              </div>
            </div>
          </form>
        </div>
      </div>

      <form id="yearMonthForm">
        <div id="yearDiv">
          <div id="yearMinusBtn" onclick="changeYearEvent(event,-1)"><</div>
          <div id="year"></div>
          <div id="yearPlusBtn" onclick="changeYearEvent(event,1)">></div>
        </div>
        <div id="monthDiv"></div>
        <input class="notDisplay" name="year" id="yearInput">
        <input class="notDisplay" name="month" id="monthInput">
        <input class="notDisplay" name="date" id="dateInput">
      </form>

      <div id="calander" class="calander"></div>
    </main>

    <script>
        const scheduleNumArr = [
            [0],
            [0,2,0,0,0,
            0,0,0,0,0,
            0,1,0,0,0,
            0,0,0,0,4,
            0,0,0,0,0,
            1,2,3],
            [0,0,0,0,0,
            0,0,0,3,0,
            0,0,0,0,0,
            0,0,5,0,4,
            0,0,0,0,0,
            0,0,0,0,0,
            2],
            [0,0,0,5,0,
            0,0,0,0,0,
            0,14,0,0,0,
            0,0,6,0,4,
            0,0,0,0,0,
            0,0,7,0,0],
            [0],
            [0],
            [0],
            [0],
            [0],
            [0],
            [0],
            [0],
        ]

        const dateNumArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        const yearValue = "<%=yearValue%>";
        const monthValue = "<%=monthValue%>";
        const dateValue = "<%=dateValue%>";       
        const createScheduleModal = document.getElementById("createScheduleModal");


        // alert(yearValue+" "+monthValue);
        document.getElementById('year').innerText = yearValue;

        function createMonthBtns() {

            const monthDiv = document.getElementById("monthDiv");
            for (let i = 1; i < 13; i++) {
                const month = document.createElement("div");
                month.innerText = i;
                month.className = "monthBtn";
                month.setAttribute("onclick", "changeMonthEvent(event)");
                monthDiv.appendChild(month);
            }   
        }

        function createDateBtns(monthValue) {

            const calander = document.getElementById("calander");
            const dateNum = dateNumArr[monthValue-1];
            for(let i=0;i<dateNum;i++){
                const dateElem = document.createElement("div");
                dateElem.className = "date";
                dateElem.innerText = i + 1;
                dateElem.setAttribute(
                    "onclick", "scheduleDetailEvent(event,"+(i+1)+")"
                );
                calander.appendChild(dateElem);
            }
        }

        function setSchedule() {
            const month = monthValue;
            const schedule = scheduleNumArr[month-1];
            for(let i=0;i<schedule.length;i++) {
                if(schedule[i] == 0)
                {
                    continue;
                }else {
                const scheduleNumElem = document.createElement("div");
                scheduleNumElem.innerText = schedule[i];
                scheduleNumElem.className = "scheduleNum"
                calander.children[i].appendChild(scheduleNumElem);
                }
            }
        }

        function setToday() {
            const Today = new Date();
            const currentYear = Today.getFullYear();
            const currentMonth = Today.getMonth()+1;
            const currentDate = Today.getDate();

            if(currentYear == yearValue && currentMonth == monthValue){
                document.getElementById("calander")
                    .children[currentDate - 1].setAttribute("id", "today");
            }
            
        }

        function createScheduleEvent(event) {
            createScheduleModal.style.display = 'block';
        }

        function closeCreatingScheduleModalEvent(event) {
            createScheduleModal.style.display = 'none';
        }

        function clickModalOverlay(event) {
            if(event.target == createScheduleModal) {
                createScheduleModal.style.display = 'none';
            }
        }
        function mypageEvent(event) {
            window.location.href = "./mypage.jsp?year="+yearValue+"&month="+monthValue+"&date="+dateValue;
        }
            
        function changeMonthEvent(event) {
            // window.location.href = `scheduler.jsp?year=${year}&month=${clickedMonth}&date=${date}`;
            const clickedMonth = event.target.innerText;
            console.log(yearValue, clickedMonth, dateValue);

            document.getElementById('yearInput').value = yearValue;
            document.getElementById('monthInput').value = clickedMonth;
            document.getElementById('dateInput').value = dateValue;

            document.getElementById('yearMonthForm').action = "./scheduler.jsp";              
            document.getElementById('yearMonthForm').submit();
        }

        function changeYearEvent(event,num) {
            const changedYear = (+yearValue) + (+num);

            document.getElementById('yearInput').value = changedYear;
            document.getElementById('monthInput').value = monthValue;
            document.getElementById('dateInput').value = dateValue;

            document.getElementById('yearMonthForm').action = "./scheduler.jsp";              
            document.getElementById('yearMonthForm').submit();
        }

        function saveScheduleEvent(event) {
            document.getElementById('descYear').value = yearValue;
            document.getElementById('descMonth').value = monthValue;
            document.getElementById('descDate').value = dateValue;

            document.getElementById('createScheduleForm').action = "./createScheduleForm.jsp";
            document.getElementById('createScheduleForm').submit();
        }

        function scheduleDetailEvent(event, clickedDate) {

            const detailUrl = `./scheduleDetail.jsp?year=` + yearValue + `&month=` + monthValue + `&date=` + clickedDate;

            window.open(detailUrl,"","left=300, top=250");
            
        }

        function logoutEvent() {
            window.location.href = "../index.html";
        }

            
        createMonthBtns();
        createDateBtns(monthValue);
        setSchedule();
        setToday();

    </script>
  </body>
</html>

