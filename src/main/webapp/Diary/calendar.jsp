<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>캘린더</title>
    <!-- JavaScript 파일 경로 설정 -->
    <script src="../javaScript/diaryPage.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fbecee;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 20%;
            background-color: #f8d66b;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .main {
            width: 80%;
            padding: 20px;
        }
        .header {
            background-color: #f8d66b;
            text-align: center;
            padding: 10px;
            font-size: 20px;
            color: black;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        /* 캘린더 스타일 */
        .calendar {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            grid-gap: 5px;
            text-align: center;
            margin-top: 10px;
        }
        .calendar .day {
            padding: 18px;
            background-color: #fff;
            border-radius: 5px;
            cursor: pointer;
            color: black;
        }
        .calendar .day:hover {
            background-color: #ffd27d;
        }
        .calendar .day-name {
            font-weight: bold;
            background-color: #f8d66b;
            color: black;
            margin-bottom: 8px;
        }
        .calendar .day a {
        	text-decoration: none;
        	color: black;
        	font-weight: bold;
    	}
    	.calendar .day a:hover {
        	color: #ff9800;
    	}
        .form-container {
            background-color: #f8d66b;
            border-radius: 10px;
            padding: 20px;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .form-group input {
            flex: 1;
            margin-right: 10px;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
        }
        .form-group input:last-child {
            margin-right: 0;
        }
        li {
        	margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="main">
            <div class="header" id="monthHeader">캘린더</div>
            <div class="form-container">
                <!-- 캘린더 표시 -->
                <div class="calendar" id="calendar"></div>
            </div>
        </div>
        <jsp:include page="sidebar.jsp" />
    </div>

    <script>
        // 현재 월 텍스트 가져오기
        function getMonthName(month) {
            const monthNames = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
            return monthNames[month];
        }

        // 날짜를 YYYY-MM-DD 형식으로 변환
        function formatDate(year, month, day) {
            const paddedMonth = String(month).padStart(2, '0'); // 1월 -> 01월
            const paddedDay = String(day).padStart(2, '0');     // 1일 -> 01일
            return `${year}-${paddedMonth}-${paddedDay}`;
        }

        // 캘린더 동작 구현
        function generateCalendar(month, year) {
            const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
            const calendar = document.getElementById("calendar");

            // 캘린더의 첫 번째 일요일 날짜 구하기
            const firstDay = new Date(year, month, 1);
            const firstDayIndex = firstDay.getDay(); // 0: 일요일, 1: 월요일, ...

            // 해당 월의 마지막 날짜
            const lastDate = new Date(year, month + 1, 0);
            const totalDays = lastDate.getDate();

            // 달력 헤더 (요일 표시)
            calendar.innerHTML = "";
            for (let i = 0; i < 7; i++) {
                const dayName = document.createElement("div");
                dayName.classList.add("day-name");
                dayName.textContent = daysOfWeek[i];
                calendar.appendChild(dayName);
            }

            // 날짜 표시
            for (let i = 0; i < firstDayIndex; i++) {
                calendar.appendChild(document.createElement("div")); // 빈 칸
            }

            for (let day = 1; day <= totalDays; day++) {
                const dayElement = document.createElement("div");
                dayElement.classList.add("day");

                // 날짜 클릭 시 diaryListPage.jsp로 이동
                const link = document.createElement("a");
                const formattedDate = formatDate(year, month + 1, day); // YYYY-MM-DD 형식
                link.href = "diaryListPage.jsp?date=${formattedDate}";
                link.textContent = day;
                dayElement.appendChild(link);

                calendar.appendChild(dayElement);
            }
        }

        // 현재 월을 표시하고 캘린더 생성
        const today = new Date();
        const monthHeader = document.getElementById("monthHeader");
        monthHeader.textContent = getMonthName(today.getMonth()) + " 캘린더";
        generateCalendar(today.getMonth(), today.getFullYear());
    </script>
</body>
</html>
