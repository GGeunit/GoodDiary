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
		    display: flex; /* 플렉스 박스 사용 */
		    justify-content: space-between; /* 요소 간 간격 균등 분배 */
		    align-items: center; /* 세로 중앙 정렬 */
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
		    flex: 1; /* 제목이 가능한 공간을 차지하도록 설정 */
		    text-decoration: none;
		}
		
		.diary-date {
		    font-size: 14px;
		    color: #888;
		    margin-right: 10px; /* 날짜와 이모지 간 간격 추가 */
		}
		
		.emoji {
		    font-size: 16px;
		    margin-left: 10px; /* 이모지가 날짜와 간격을 유지하도록 설정 */
		}
    </style>
</head>
<body>
    <div class="container">
        <div class="main">
            <div class="header"><b>내 일기 목록</b></div>
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