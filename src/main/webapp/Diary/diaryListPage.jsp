<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Diary.Diary" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일기 목록</title>
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

        .menu {
            list-style: none;
            padding: 0;
        }

        .menu li {
            margin-bottom: 20px;
            font-size: 16px;
            color: #5c5c5c;
            cursor: pointer;
        }

        .menu li:last-child {
            margin-bottom: 0;
        }

        .add-button {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ff7070;
            color: white;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            cursor: pointer;
            font-size: 30px;
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
            color: #5c5c5c;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .diary-list {
            background-color: #fff8dc;
            border-radius: 10px;
            padding: 20px;
        }

        .diary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #ffefd5;
            border-radius: 5px;
        }

        .diary-item:hover {
            background-color: #ffd27d;
        }

        .diary-title {
            font-size: 16px;
            color: #5c5c5c;
        }

        .diary-date {
            font-size: 14px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="main">
            <div class="header"><b>내 일기 목록</b></div>
            <div class="diary-list">
                <%
                    // Controller에서 전달된 diaries 속성 가져오기
                    List<Diary> diaryList = (List<Diary>) request.getAttribute("diaries");
                    if (diaryList != null && !diaryList.isEmpty()) {
                        for (Diary diary : diaryList) {
                %>
                <div class="diary-item">
                    <a href="Diary?action=view&id=<%= diary.getAid() %>" class="diary-title"><%= diary.getTitle() %></a>
                    <div class="diary-date"><%= diary.getDate() %></div>
                </div>
                <%
                        }
                    } else {
                %>
                <div>일기가 없습니다.</div>
                <%
                    }
                %>
            </div>
        </div>

		<div class="sidebar">
		    <ul class="menu">
		        <!-- 각 메뉴 항목에 하이퍼링크 추가 -->
		        <li><a href="/GoodDiary/Diary/diaryPage.jsp" style="text-decoration: none; color: inherit;">일기 작성</a></li>
		        <li><a href="calendar.jsp" style="text-decoration: none; color: inherit;">캘린더</a></li>
		        <li><a href="emotionLog.jsp" style="text-decoration: none; color: inherit;">감정 기록</a></li>
		        <li><a href="dataVisualization.jsp" style="text-decoration: none; color: inherit;">데이터 시각화</a></li>
		        <li><a href="settings.jsp" style="text-decoration: none; color: inherit;">설정</a></li>
		    </ul>
		    <!-- 플러스 버튼도 페이지 이동 -->
		    <div class="add-button">
		        <a href="/GoodDiary/Diary/diaryPage.jsp" style="text-decoration: none; color: white;">+</a>
		    </div>
		</div>

</body>
</html>