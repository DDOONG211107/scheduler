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
        <link rel="stylesheet" href="../style/scheduler.css" />
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
        ["김영선", 11,30, "테스트 스케줄 1", false],
        ["최민석", 11,40, "테스트 스케줄 2", true],
        ["홍길동", 14,0, "테스트 스케줄 3", false],
        ["최민석", 17, 15, "테스트 스케줄 4", false],
        ]

        const year = <%=year%>;
        const month = <%=month%>;
        const date = <%=date%>;
        const myRank = "rank1";
        const dateString = year+"년 "+month+"월 "+date+"일";

        document.getElementById('clickedDate').innerText = dateString;


        const scheduleUl = document.getElementById('scheduleList')
        for(let i=0; i<scheduleArr.length; i++)
        {
            const scheduleItem = document.createElement("li");
            scheduleItem.className = "schedule";
            
            const schedule = scheduleArr[i]; // 하나의 스케줄

            if (myRank === "rank1") {
                const name = document.createElement("span");
                name.innerText = schedule[0];
                name.className = "scheduleName";
                scheduleItem.appendChild(name);
            }
            // 시간 부분을 만들어야 함
            const time = document.createElement("span");
            time.innerText = schedule[1]+"시 "+schedule[2]+"분";
            time.className = "scheduleTime";
            scheduleItem.appendChild(time);

            // content부분을 만들어야 함
            const content = document.createElement("span");
            content.innerText = schedule[3];
            content.className = "scheduleContent";
            scheduleItem.appendChild(content);




            // 맨 마지막 ul에 item을 추가
            scheduleUl.appendChild(scheduleItem);
        }


    </script>

</html>

