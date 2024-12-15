<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Diary.Diary"%>
<%
    Diary diary = (Diary) request.getAttribute("diary");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>감정 점수 확인</title>
<style>
/* 전체 페이지 스타일 */
body {
    font-family: 'Arial', sans-serif;
    background-color: #fffaf0;
    margin: 0;
    padding: 0;
}

/* 메인 컨테이너 */
.container {
    width: 100%;
    max-width: 900px;
    margin: 30px auto;
    background: #ffecb3;
    padding: 20px 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* 헤더 스타일 */
.header {
    font-size: 1.8rem;
    color: #d35400;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
}

/* 설명 텍스트 */
.description {
    font-size: 1rem;
    color: #333;
    text-align: center;
    margin-bottom: 20px;
    line-height: 1.5;
}

/* 일기 내용 */
.info-box {
    background: #ffffff;
    border: 1px solid #f39c12;
    padding: 15px;
    border-radius: 5px;
    margin-bottom: 20px;
    font-size: 1rem;
    color: #555;
}

/* 감정 점수 수정 */
.form-group {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-top: 10px;
    justify-content: center;
}

label {
    font-weight: bold;
    color: #333;
}

input[type="number"] {
    width: 100px;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1rem;
    text-align: center;
}

button {
    background-color: #f39c12;
    color: white;
    border: none;
    padding: 8px 15px;
    font-size: 1rem;
    font-weight: bold;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #e67e22;
}

/* 감정 점수 범위 설명 */
.score-info {
    text-align: center;
    margin-top: 10px;
    font-size: 0.9rem;
    color: #555;
}
</style>
</head>
<body>
    <div class="container">
        <!-- 헤더 -->
        <div class="header">일기 감정 점수 확인</div>
        <!-- 설명 -->
        <div class="description">
            일기 내용을 토대로 분석한 감정 점수입니다.<br>
            수정이 필요하다고 생각되시면 아래에서 점수를 수정해주세요.
        </div>
        <!-- 일기 내용 -->
        <div class="info-box">
            <p><strong>작성된 제목:</strong> <%= diary.getTitle() %></p>
            <p><strong>작성된 날짜:</strong> <%= diary.getDate() %></p>
            <p><strong>작성된 내용:</strong> <%= diary.getContent() %></p>
        </div>
        <!-- 감정 점수 표시 -->
        <div class="description">
            현재 분석된 감정 점수는 <strong><%= diary.getEmotionScore() %>(<%= diary.getEmotion() %>)</strong>입니다.
        </div>
        <!-- 감정 점수 수정 -->
        <form action="/GoodDiary/Diary" method="post">
            <input type="hidden" name="action" value="confirm">
            <input type="hidden" name="title" value="<%= diary.getTitle() %>">
            <input type="hidden" name="date" value="<%= diary.getDate() %>">
            <input type="hidden" name="content" value="<%= diary.getContent() %>">
            <input type="hidden" name="user_id" value="<%= diary.getAid() %>">
            <div class="form-group">
                <label for="emotionScore">감정 점수 수정:</label>
                <input type="number" id="emotionScore" name="emotionScore" step="0.1" min="-1.0" max="1.0"
                       value="<%= diary.getEmotionScore() %>" required>
                <button type="submit">점수 확정</button>
            </div>
        </form>
        <!-- 감정 점수 범위 설명 -->
        <div class="score-info">
            ※ 감정 점수는 -1(매우 부정적)에서 1(매우 긍정적)까지 입력할 수 있습니다.
        </div>
    </div>
</body>
</html>
