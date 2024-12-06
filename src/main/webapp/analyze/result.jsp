<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Diary.Diary" %>
<%@ page import="com.google.gson.Gson" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>감정 분석 결과</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>감정 분석 결과</h1>
    <h2>기간: <%= request.getAttribute("startDate") %> ~ <%= request.getAttribute("endDate") %></h2>

    <div>
        <h3>분석 메시지</h3>
        <p><%= request.getAttribute("analysisMessage") %></p>
    </div>

    <div id="chart-container">
        <canvas id="emotionChart"></canvas>
    </div>

    <script>
        const diaries = <%= request.getAttribute("diariesJson") %>;
        const labels = diaries.map(diary => diary.date);
        const data = diaries.map(diary => diary.emotionScore);

        new Chart(document.getElementById("emotionChart"), {
            type: "line",
            data: {
                labels: labels,
                datasets: [{
                    label: "감정 점수 변화",
                    data: data,
                    borderColor: "rgba(75, 192, 192, 1)",
                    backgroundColor: "rgba(75, 192, 192, 0.2)"
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        min: -1,
                        max: 1
                    }
                }
            }
        });
    </script>
</body>
</html>
