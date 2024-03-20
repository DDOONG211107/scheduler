<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.util.ArrayList" %>
<% 
    request.setCharacterEncoding("utf-8"); 

    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String date = request.getParameter("date");
%>

<html>

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../global.css" />
        <link rel="stylesheet" href="../style/scheduler.css?randomString" />
        <title>솔가레오</title>
    </head>

    <body>

        <div id="scheduleDetailModalContent" class="modalContent">
            <div id="clickedDate"></div>
            <div>스케줄 목록</div>
            <ul id="scheduleList"></ul>
        </div>

    </body>

    <script>
        // 이 전에 Date.getHours(), Date.getMinutes()를 처리했다고 가정
        const scheduleArr = [
        // 작성자, 시, 분, 내용, 자신의 것
        [1,"김영선", 11,30, "테스트 스케줄 1", false, "#d9ffc1"],
        [2,"최민석", 11,40, "테스트 스케줄 2", true, "orange"],
        [3,"홍길동", 14,0, "테스트 스케줄 3", false, "#ffd1d1"],
        [4,"최민석", 17, 15, "테스트 스케줄 4", true, "orange"],
        ]

        const dateNumArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

        const year = <%=year%>;
        const month = <%=month%>;
        const date = <%=date%>;
        const myRank = "rank1";
        const dateString = year+"년 "+month+"월 "+date+"일";

        document.getElementById('clickedDate').innerText = dateString;

        function setSchedule(){
            const scheduleUl = document.getElementById('scheduleList')
            for(let i=0; i<scheduleArr.length; i++){
                const scheduleItem = document.createElement("li");
                scheduleItem.className = "schedule";
                
                const schedule = scheduleArr[i]; // 하나의 스케줄

                if (myRank === "rank1") {
                    const name = document.createElement("span");
                    name.innerText = schedule[1];
                    name.className = "scheduleName";
                    scheduleItem.appendChild(name);
                }
                // 시간 부분을 만들어야 함
                const time = document.createElement("span");
                time.innerText = schedule[2]+"시 "+schedule[3]+"분";
                time.className = "scheduleTime";
                scheduleItem.appendChild(time);

                // content부분을 만들어야 함
                const content = document.createElement("span");
                content.innerText = schedule[4];
                content.className = "scheduleContent";
                scheduleItem.appendChild(content);

                // 자신의 스케줄인지 확인 -> 맞다면 수정과 삭제버튼 추가
                if(schedule[5]){
                    // form 만들기
                    const form = document.createElement("form");
                    form.className = "scheduleEditDeleteForm";

                    // 수정과 삭제버튼 만들기
                    const editDeleteBtnDiv = document.createElement("div");
                    editDeleteBtnDiv.className = "editDeleteBtnDiv";
                    
                    const editBtn = document.createElement("div");
                    editBtn.innerText = "수정";
                    editBtn.className = "blueBtn editBtn";
                    editBtn.setAttribute("onclick", "editScheduleEvent(event)");

                    const deleteBtn = document.createElement("div");
                    deleteBtn.innerText = "삭제";
                    deleteBtn.className = "greyBtn deleteBtn";
                    deleteBtn.setAttribute("onclick", "deleteScheduleEvent(event,"+schedule[0]+")");

                    editDeleteBtnDiv.appendChild(editBtn);
                    editDeleteBtnDiv.appendChild(deleteBtn);
                    form.appendChild(editDeleteBtnDiv);

                    // 타임인풋 만들기
                    const scheduleEditTimeInput = document.createElement("div");
                    scheduleEditTimeInput.className = "scheduleEditTimeInput";

                    const yearInput = document.createElement("input");
                    yearInput.setAttribute("type", "number");
                    yearInput.setAttribute("value", year);
                    yearInput.setAttribute("name", "yearInput");
                    yearInput.className = "scheduleFormInput";
                    scheduleEditTimeInput.appendChild(yearInput);

                    const yearSpan = document.createElement("span");
                    yearSpan.innerText = "년";
                    yearSpan.className = "scheduleFormSpan";
                    scheduleEditTimeInput.appendChild(yearSpan);

                    const monthInput = document.createElement("input");
                    monthInput.setAttribute("type", "number");
                    monthInput.setAttribute("value", month);
                    monthInput.setAttribute("name", "nameInput");
                    monthInput.className = "scheduleFormInput";
                    scheduleEditTimeInput.appendChild(monthInput);

                    const monthSpan = document.createElement("span");
                    monthSpan.innerText = "월";
                    monthSpan.className = "scheduleFormSpan";
                    scheduleEditTimeInput.appendChild(monthSpan);

                    const dateInput = document.createElement("input");
                    dateInput.setAttribute("type", "number");
                    dateInput.setAttribute("value", date);
                    dateInput.setAttribute("name", "dateInput");
                    dateInput.className = "scheduleFormInput";
                    scheduleEditTimeInput.appendChild(dateInput);

                    const dateSpan = document.createElement("span");
                    dateSpan.innerText = "일";
                    dateSpan.className = "scheduleFormSpan";
                    scheduleEditTimeInput.appendChild(dateSpan);

                    const hourInput = document.createElement("input");
                    hourInput.setAttribute("type", "number");
                    hourInput.setAttribute("value", schedule[2]);
                    hourInput.setAttribute("name", "hourInput");
                    hourInput.className = "scheduleFormInput";
                    scheduleEditTimeInput.appendChild(hourInput);

                    const hourSpan = document.createElement("span");
                    hourSpan.innerText = "시";
                    hourSpan.className = "scheduleFormSpan";
                    scheduleEditTimeInput.appendChild(hourSpan);

                    const minuteInput = document.createElement("input");
                    minuteInput.setAttribute("type", "number");
                    minuteInput.setAttribute("value", schedule[3]);
                    minuteInput.setAttribute("name", "minuteInput");
                    minuteInput.className = "scheduleFormInput";
                    scheduleEditTimeInput.appendChild(minuteInput);

                    const minuteSpan = document.createElement("span");
                    minuteSpan.innerText = "분";
                    minuteSpan.className = "scheduleFormSpan";
                    scheduleEditTimeInput.appendChild(minuteSpan);

                    scheduleEditTimeInput.style.display = "none";
                    form.appendChild(scheduleEditTimeInput);

                    // 글쓰기 인풋과 저장버튼 출력 
                    const scheduleContentSaveBtnDiv = document.createElement("div");
                    // scheduleContentSaveBtnDiv.setAttribute("id", "scheduleContentSaveBtnDiv");
                    scheduleContentSaveBtnDiv.className = "scheduleContentSaveBtnDiv";

                    const scheduleContentInput = document.createElement("input");
                    // scheduleContentInput.setAttribute("id", "scheduleContentInput");
                    scheduleContentInput.className = "scheduleContentInput";
                    scheduleContentInput.setAttribute("value", schedule[4]);
                    scheduleContentInput.setAttribute("name", "contentInput");
                    scheduleContentInput.setAttribute(
                        "placeholder",
                        "1자 이상 20자 이하로 입력해주세요"
                    );
                    scheduleContentSaveBtnDiv.appendChild(scheduleContentInput);

                    const saveBtn = document.createElement("div");
                    saveBtn.innerText = "저장";
                    saveBtn.className = "blueBtn saveBtn";
                    saveBtn.setAttribute("onclick", "saveScheduleEvent(event,"+schedule[0]+ ")");
                    // saveBtn.setAttribute("id", "saveBtn");
                    scheduleContentSaveBtnDiv.appendChild(saveBtn);

                    scheduleContentSaveBtnDiv.style.display = "none";
                    form.appendChild(scheduleContentSaveBtnDiv);


                    // 해당 스케줄 아이템에 form 추가
                    scheduleItem.appendChild(form);
                }
                // 본인의 스케줄이 아니라면 배경 색깔 추가하기
                else {
                    scheduleItem.style.backgroundColor = schedule[6];
                }
                // 맨 마지막 ul에 item을 추가
                scheduleUl.appendChild(scheduleItem);
            }

            return;
        }

        function checkValue(year, month, date, hour, minute, content) {

            const yearRegex = /^\d{4}$/;
            const monthRegex = /^[1-9]|1[0-2]$/;
            const hourRegex = /^0[1-9]|[1][0-9]|[2][0-3]$/;
            const minuteRegex = /^[0-9]|[12345][0-9]$/;
            const contentRegex = /^.{1,20}$/;

            const yearValue = parseInt(year);
            const monthValue = parseInt(month);
            const dateValue = parseInt(date);
            const hourValue = parseInt(hour);
            const minuteValue = parseInt(minute);

            if(!yearRegex.test(yearValue)){
                return "연도는 네자리 숫자로 입력해주세요.";
            }
            if(!monthRegex.test(monthValue)){
                return "월은 1부터 12까지의 숫자로 입력해주세요.";
            }
            if(monthRegex.test(monthValue)){
                // 월은 통과했으니 일을 검사해야 함
                const totalDateNum = dateNumArr[monthValue-1];
                if( Number.isNaN(dateValue)|| dateValue>totalDateNum || dateValue<1 ){
                    return "일 값을 정확하게 입력해주세요.";
                }
            }
            if(!hourRegex.test(hourValue)){
                return "시 값을 정확하게 입력해주세요.";
            }
            if(!minuteRegex.test(minuteValue)){
                return "분을 정확하게 입력해주세요.";
            }
            if(!contentRegex.test(content)){
                return "스케줄 내용을 1자이상 20자 이하로 입력해주세요.";
            }

            return false;        
        }

        function deleteScheduleEvent (event, idx) {
            
            const scheduleContent = event.target.parentNode.parentNode.parentNode.children[2].innerText;
            const deleteOkay = confirm(scheduleContent + "를 삭제하시겠습니까?");

            if(deleteOkay){
                window.location.href = "./deleteScheduleAction.jsp?year="+year+"&month="+month+"&date="+date+"&idx="+idx;
            }

            return;
        };

        function editScheduleEvent(event) {
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

            return;
        }

        function saveScheduleEvent(event, idx) {
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
                alert(isError);
                return;
            }

            window.location.href = "./saveScheduleAction.jsp?year="+year+"&month="+month+"&date="+date+"&idx="+idx+"&year="+year+"&month="+month+"&date="+date+"&hour="+hour+"&minute="+minute+"&content="+content;
            return;
        }

        setSchedule();

    </script>

</html>

