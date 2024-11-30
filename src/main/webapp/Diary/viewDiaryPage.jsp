<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Diary.Diary" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일기 상세 보기</title>
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

        .diary-detail {
            background-color: #fff8dc;
            border-radius: 10px;
            padding: 20px;
        }

        .diary-title {
            font-size: 24px;
            color: #5c5c5c;
            text-align: center;
        }

        .diary-date {
            font-size: 16px;
            color: #888;
            text-align: right;
        }

        .diary-emotion {
            font-size: 18px;
            color: #ff7070;
        }

        .diary-content {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="main">
            <div class="header">일기 상세 보기</div>
            <div class="diary-detail">
                <%
                    // Controller에서 전달된 diary 속성 가져오기
                    Diary diary = (Diary) request.getAttribute("diary");
                    if (diary != null) {
                %>
                <div class="diary-title"><%= diary.getTitle() %></div>
                <div class="diary-date"><%= diary.getDate() %></div>
                <div class="diary-emotion">감정: <%= diary.getEmotion() %></div>
                <div class="diary-content"><%= diary.getContent() %></div>
                <%
                    } else {
                %>
                <div>해당 일기를 찾을 수 없습니다.</div>
                <%
                    }
                %>
            </div>
        </div>

		<jsp:include page="sidebar.jsp" />
    </div>
</body>
</html>
