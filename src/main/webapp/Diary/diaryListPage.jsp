<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Diary.Diary" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
            color: black;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: bold;
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
            color: black;
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
  				<c:if test="${not empty diaries}">
			    <c:forEach var="diary" items="${diaries}">
			        <div class="diary-item">
			            <a href="/GoodDiary/Diary?action=view&id=${diary.recordId}" class="diary-title">${diary.title}</a>
			            <div class="diary-date">${diary.date}</div>
    			        <c:choose>
			                <c:when test="${diary.emotion == '기쁨'}"><span class="emoji">😊</span></c:when>
			                <c:when test="${diary.emotion == '슬픔'}"><span class="emoji">😭</span></c:when>
			                <c:when test="${diary.emotion == '화남'}"><span class="emoji">😠</span></c:when>
			                <c:otherwise>🤔</c:otherwise>
			            </c:choose>
			        </div>
			    </c:forEach>
				</c:if>
				<c:if test="${empty diaries}">
				    <div>일기가 없습니다.</div>
				</c:if>
			  				
            </div>
        </div>
		<jsp:include page="sidebar.jsp" />
</body>
</html>