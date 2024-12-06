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
    </style>
</head>
<body>
    <h1>Diary Analysis Result</h1>

    <p>Period: <strong>${startDate}</strong> to <strong>${endDate}</strong></p>
    <p class="average-score">Average Emotion Score: ${averageScore}</p>

    <h2>Diaries in Selected Period</h2>
    <c:choose>
        <c:when test="${not empty diaries}">
            <ul>
                <c:forEach var="diary" items="${diaries}">
                    <li>
                        <span class="diary-title">${diary.title}</span> 
                        (<span class="diary-date">${diary.date}</span>)<br>
                        <strong>Emotion:</strong> ${diary.emotion} 
                        (Score: ${diary.emotionScore})<br>
                        <p>${diary.content}</p>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <p class="no-diaries">No diaries found for the selected period.</p>
        </c:otherwise>
    </c:choose>
</body>
</html>
