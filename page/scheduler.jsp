<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>

<%
    request.setCharacterEncoding("utf-8"); 

    boolean isError = true;

    String userIdx =  ((String) session.getAttribute("userIdx")) ;

    // 현재 연도와 월이 그대로 출력됨
    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dateValue = request.getParameter("date");
    String alertString = "";

    ArrayList<ArrayList<String>> scheduleList = new ArrayList<ArrayList<String>>();


    try{

        // 1. 내 userIdx로 내가 팀장인지 아닌지, 나의 팀을 가져온다.
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "SELECT * FROM account WHERE idx = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,userIdx);

        ResultSet result = query.executeQuery();

        if(!result.next()){
            throw new Exception("로그인 후 이용해주세요.");
        }

        ArrayList<String> account = new ArrayList<String>();
        String rank = result.getString(8);
        String team = result.getString(7);

        // 2-1. 내가 팀장이면 전부 조인시켜서 우리팀의 스케줄, 해당 월에 일치하는 스케줄을 전부 가져온다.
        if(rank.equals("팀장")){
            sql = "SELECT schedule.idx, schedule.start_datetime, schedule.account_idx, account.team FROM schedule JOIN account WHERE account.idx = schedule.account_idx AND account.team = ? AND YEAR(start_datetime) = ? AND MONTH(start_datetime) = ?";
            query = connect.prepareStatement(sql);
            query.setString(1,team);
            query.setString(2,yearValue);
            query.setString(3,monthValue);

            // result를 이제 2차원 배열로 만들기
            result = query.executeQuery();

            while(result.next()){
                ArrayList<String> data = new ArrayList<String>();

                String idx = result.getString(1);
                String start_datetime = result.getString(2);
                String account_idx = result.getString(3);

                data.add("\"" + idx + "\"");
                data.add("\"" + start_datetime + "\"");
                data.add("\"" + account_idx + "\"");

                scheduleList.add(data);
            }

            isError = false;
        }

        // 2-2. 내가 팀원이면 조인 시킬 필요 없이 스케줄테이블에서 해당 월에 일치하는 내 스케줄을 가져온다.
        else if(rank.equals("팀원")){
            sql = "SELECT idx, start_datetime, account_idx FROM schedule WHERE account_idx = ? AND YEAR(start_datetime) = ? AND MONTH(start_datetime) = ? ";
            query = connect.prepareStatement(sql);
            query.setString(1,userIdx);
            query.setString(2,yearValue);
            query.setString(3,monthValue);

            // result를 이제 2차원 배열로 만들기
            result = query.executeQuery();

            while(result.next()){
                ArrayList<String> data = new ArrayList<String>();

                String idx = result.getString(1);
                String start_datetime = result.getString(2);
                String account_idx = result.getString(3);

                data.add("\"" + idx + "\"");
                data.add("\"" + start_datetime + "\"");
                data.add("\"" + account_idx + "\"");

                scheduleList.add(data);
            }

            isError = false;

        }

        // 내가 팀장도 아니고 팀원도 아니면 문제가 있는것
        else{
            throw new Exception("서버: 문제가 생겼습니다.");
        }





        // 3. 그러면 2차원 배열이 나온다. 그걸 그냥 넘겨버리자.
    }catch(Exception e){
        alertString = e.getMessage();    
    }

%>


<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../global.css" />
    <link rel="stylesheet" href="../style/scheduler.css?randomString" />

    <title>솔가레오</title>
  </head>
  <body>

    <header>

      <div id="headerLogo">솔가레오</div>
      <div id="headerNav">
        <span onclick="createScheduleEvent(event)" class="spanBtn">스케줄쓰기</span>
        <span onclick="mypageEvent(event)" class="spanBtn">마이페이지</span>
        <span onclick="logoutEvent(event)" class="spanBtn">로그아웃</span>
      </div>
      
    </header>

    <main>

    <div id="createScheduleModal" class="modal" onclick="clickModalOverlay(event)">
        <div class="modalContent" id = "createModalContent">

          <form id="createScheduleForm">

            <div id="scheduleFormTimeInput">
              <input type="number" maxlength="4" class="scheduleFormInput" name="newYear" id="createYearInput" />
              <span class="scheduleFormSpan">년</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newMonth" id="createMonthInput" />
              <span class="scheduleFormSpan">월</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newDate" id="createDateInput" />
              <span class="scheduleFormSpan">일</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newHour" id="createHourInput" />
              <span class="scheduleFormSpan">시</span>

              <input type="number" maxlength="2" class="scheduleFormInput" name="newMinute" id="createMinuteInput" />
              <span class="scheduleFormSpan">분</span>
            </div>

            <div id="scheduleFormContentInput">
              <label>스케줄 내용</label>
              <input
                type="text"
                placeholder="1자이상 20자 이하로 입력해 주세요."
                name="newContent"
                id = "createContentInput"
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

        const userIdx = "<%=userIdx%>";
        if(userIdx == "null"){
            alert("로그인 후 이용해주세요.");
            window.location.href = "../index.html";
        }
        console.log('확인용 세션 출력: ',  userIdx);

        const dateNumArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        const yearValue = "<%=yearValue%>";
        const monthValue = "<%=monthValue%>";
        const dateValue = "<%=dateValue%>";       
        const createScheduleModal = document.getElementById("createScheduleModal");

        document.getElementById('year').innerText = yearValue;

        function createMonthBtns() {
            const monthDiv = document.getElementById("monthDiv");
            for (let i = 1; i < 13; i++) {
                const month = document.createElement("div");
                month.innerText = i;
                month.className = "monthBtn";
                month.setAttribute("onclick", "changeMonthEvent(event)");
                if(i == monthValue){
                    month.style.backgroundColor = "#bdd4ff";
                    month.style.color = "black";
                }
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

        function getScheduleNum(){
            const scheduleNumList = <%=scheduleList%>;
            const scheduleNumArr = Array.from({length:31}, () => 0);
            let start_datetime = "";
            let dateParts = "";
            let date = "";
            let dateValue = 0;

            for(let i=0; i<scheduleNumList.length; i++){
                start_datetime = scheduleNumList[i][1];
                dateParts = start_datetime.split("-");
                date = dateParts[2].split(" ")[0];
                dateValue = parseInt(date) - 1;
                scheduleNumArr[dateValue]++;
            }

            console.log(scheduleNumArr);
            return scheduleNumArr;
        }

        function setSchedule(scheduleNumArr) {
            const month = monthValue;
            // const schedule = scheduleNumArr[month-1];
            const schedule = scheduleNumArr;
            for(let i=0;i<dateNumArr[month];i++) {
                if(schedule[i] == 0){
                    continue;
                } else {
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

            const current = new Date();

            // 1. 날짜에는 기본적으로 현재시간을 넣어주기
            document.getElementById('createYearInput').value = current.getFullYear();
            document.getElementById('createMonthInput').value = +(current.getMonth()) + 1;
            document.getElementById('createDateInput').value = current.getDate();
            document.getElementById('createHourInput').value = current.getHours();
            document.getElementById('createMinuteInput').value = current.getMinutes();
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

            // 1. 빈칸 예외처리 해주기 (정규식으로)
            const yearRegex = /^\d{4}$/;
            const monthRegex = /^[1-9]|1[0-2]$/;
            const hourRegex = /^[0-9]|[1][0-9]|[2][0-3]$/;
            const minuteRegex = /^[0-9]|[12345][0-9]$/;
            const contentRegex = /^.{1,20}$/;

            const yearValue = document.getElementById('createYearInput').value;
            const monthValue = document.getElementById('createMonthInput').value;
            const dateValue = document.getElementById('createDateInput').value;
            const hourValue = document.getElementById('createHourInput').value;
            const minuteValue = document.getElementById('createMinuteInput').value;
            const contentValue = document.getElementById('createContentInput').value;

            try{
                if(!yearRegex.test(yearValue)){
                    throw "연도는 네자리 숫자로 입력해주세요.";
                }
                if(!monthRegex.test(monthValue)){
                    throw "월은 1부터 12까지의 숫자로 입력해주세요.";
                }
                if(monthRegex.test(monthValue)){
                    // 월은 통과했음 일을 검사해야 함
                    const totalDateNum = dateNumArr[monthValue-1];
                    if( Number.isNaN(dateValue)|| dateValue>totalDateNum || dateValue<1 ){
                        throw "일 값을 정확하게 입력해주세요.";
                    }
                }
                if(!hourRegex.test(hourValue)){
                    throw "시 값을 정확하게 입력해주세요.";
                }
                if(!minuteRegex.test(minuteValue)){
                    throw "분을 정확하게 입력해주세요.";
                }
                if(!contentRegex.test(contentValue)){
                    throw "스케줄 내용을 1자이상 20자 이하로 입력해주세요.";
                }

                document.getElementById('descYear').value = yearValue;
                document.getElementById('descMonth').value = monthValue;
                document.getElementById('descDate').value = dateValue;

                document.getElementById('createScheduleForm').action = "../action/createScheduleAction.jsp";
                document.getElementById('createScheduleForm').submit();

            }catch(e){
                alert(e);
            }
            
        }

        function scheduleDetailEvent(event, clickedDate) {
            const detailUrl = `./scheduleDetail.jsp?year=` + yearValue + `&month=` + monthValue + `&date=` + clickedDate;
            window.open(detailUrl,"","left=300, top=250");    
        }

        function logoutEvent() {
            window.location.href = "../action/logoutAction.jsp";
        }
            
        createMonthBtns();
        createDateBtns(monthValue);
        const scheduleList = getScheduleNum();
        setSchedule(scheduleList);
        setToday();

    </script>
  </body>
</html>

