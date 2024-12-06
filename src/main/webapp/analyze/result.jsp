<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Diary.Diary"%>
<%@ page import="com.google.gson.Gson"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>감정 분석 결과</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #fbe2a5;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.container {
	display: flex;
	width: 900px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
	background-color: #ffffff;
	border-radius: 10px;
	overflow: hidden;
	flex-direction: column;
}

.header {
	background-color: #f39c12;
	color: white;
	text-align: center;
	padding: 20px;
	font-size: 24px;
	border-radius: 10px 10px 0 0;
}

.content {
	padding: 30px;
}

.content h2 {
	color: #f39c12;
	margin-bottom: 20px;
}

.content p {
	margin: 10px 0;
	font-size: 16px;
	color: #333333;
}

.chart-container {
	margin-top: 30px;
}

canvas {
	max-width: 100%;
}

.diary-list {
	margin-top: 40px;
}

.diary-list h3 {
	color: #f39c12;
	margin-bottom: 20px;
}

.diary-list table {
	width: 100%;
	border-collapse: collapse;
}

.diary-list th, .diary-list td {
	border: 1px solid #dddddd;
	padding: 10px;
	text-align: left;
}

.diary-list th {
	background-color: #f9d99a;
	color: #333;
}

.btn-back {
    display: inline-block;
    padding: 10px 20px;
    margin-top: 20px;
    text-align: center;
    color: #ffffff;
    background-color: #f39c12;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.btn-back:hover {
    background-color: #e67e22;
    text-decoration: none;
}


</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<div class="container">
		<div class="header">감정 분석 결과</div>
		<div class="content">
			<h2>
				기간:
				<%= request.getAttribute("startDate") %>
				~
				<%= request.getAttribute("endDate") %></h2>
			<div>
				<h3>분석 메시지</h3>
				<p><%= request.getAttribute("analysisMessage") %></p>
			</div>
			<div class="chart-container">
				<canvas id="emotionChart"></canvas>
			</div>
			<div class="diary-list">
				<h3>읽어들인 데이터</h3>
				<table>
					<thead>
						<tr>
							<th>작성 날짜</th>
							<th>내용</th>
						</tr>
					</thead>
					<tbody>
						<%
    // JSP에서 전달된 데이터 리스트를 출력
    List<Diary> diaries = (List<Diary>) request.getAttribute("diaries");

    if (diaries != null && !diaries.isEmpty()) { // 데이터가 비어있지 않을 때만 출력
        for (Diary diary : diaries) {
%>
						<tr>
							<td><%= diary.getDate() %></td>
							<td><%= diary.getContent() %></td>
						</tr>
						<%
        }
    } else { // 데이터가 없을 경우
%>
						<tr>
							<td colspan="2" style="text-align: center; color: gray;">데이터가
								없습니다.</td>
						</tr>
						<%
    }
%>
					</tbody>
				</table>
			</div>
			<a href="/GoodDiary/Diary?action=list" class="btn-back">목록으로</a>

		</div>
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
                    backgroundColor: "rgba(75, 192, 192, 0.2)",
                    tension: 0.3
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
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
