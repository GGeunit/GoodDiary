<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
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
            <div class="header">내 일기 목록</div>
            <div class="diary-list">
                <%
                    // 서버에서 가져온 일기 데이터를 가정
                    List<Map<String, String>> diaryList = new ArrayList<>();
                    Map<String, String> diary1 = new HashMap<>();
                    diary1.put("title", "첫 번째 일기");
                    diary1.put("date", "2024-11-01");
                    diaryList.add(diary1);

                    Map<String, String> diary2 = new HashMap<>();
                    diary2.put("title", "두 번째 일기");
                    diary2.put("date", "2024-11-02");
                    diaryList.add(diary2);

                    Map<String, String> diary3 = new HashMap<>();
                    diary3.put("title", "세 번째 일기");
                    diary3.put("date", "2024-11-03");
                    diaryList.add(diary3);

                    // 일기 목록 출력
                    for (Map<String, String> diary : diaryList) {
                %>
                <div class="diary-item">
                    <div class="diary-title"><%= diary.get("title") %></div>
                    <div class="diary-date"><%= diary.get("date") %></div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="sidebar">
            <ul class="menu">
                <li>일기 작성</li>
                <li>캘린더</li>
                <li>감정 기록</li>
                <li>데이터 시각화</li>
                <li>설정</li>
            </ul>
            <div class="add-button">+</div>
        </div>
    </div>
</body>
</html>
