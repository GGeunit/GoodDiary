<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Diary Analysis Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }
        h1 {
            color: #333;
        }
        .average-score {
            font-size: 1.2em;
            color: #007BFF;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            background: #f9f9f9;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .diary-title {
            font-weight: bold;
            color: #444;
        }
        .diary-date {
            font-size: 0.9em;
            color: #777;
        }
        .no-diaries {
            color: #FF5722;
            font-style: italic;
        }
        .analysis-message {
            background: #e8f4e8;
            border: 1px solid #d4edda;
            padding: 15px;
            border-radius: 5px;
            color: #155724;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h1>Diary Analysis Result</h1>

    <p>기간: <strong>${startDate}</strong>부터 <strong>${endDate}</strong>까지</p>
    <p class="average-score">평균 감정 점수: ${averageScore}</p>

    <!-- 분석 메시지 섹션 -->
    <c:if test="${not empty analysisMessage}">
        <div class="analysis-message">
            <h2>분석 결과</h2>
            <p>${analysisMessage}</p>
        </div>
    </c:if>

    <h2>선택된 기간 동안의 다이어리</h2>
    <c:choose>
        <c:when test="${not empty diaries}">
            <ul>
                <c:forEach var="diary" items="${diaries}">
                    <li>
                        <span class="diary-title">${diary.title}</span> 
                        (<span class="diary-date">${diary.date}</span>)<br>
                        <strong>감정:</strong> ${diary.emotion} 
                        (점수: ${diary.emotionScore})<br>
                        <p>${diary.content}</p>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <p class="no-diaries">선택된 기간 동안의 다이어리가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</body>
</html>
