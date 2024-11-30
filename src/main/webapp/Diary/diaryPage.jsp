<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>감정 기록</title>
    <!-- JavaScript 파일 경로 설정 -->
    <script src="../javaScript/diaryPage.js"></script>
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
        .form-container {
            background-color: #f8d66b;
            border-radius: 10px;
            padding: 20px;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .form-group input {
            flex: 1;
            margin-right: 10px;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
        }
        .form-group input:last-child {
            margin-right: 0;
        }
        .textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
        }
        .button {
            padding: 10px 20px;
            font-size: 16px;
            color: #5c5c5c;
            background-color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #ffd27d;
        }
        .emoji {
        font-size: 24px;
        transition: transform 0.3s, color 0.3s;
    	}
	    .emoji:hover {
    	    transform: scale(1.2);
        	color: orange;
    	}
    </style>
</head>
<body>
    <div class="container">
        <div class="main">
            <div class="header">오늘 하루 나의 감정을 적어보아요</div>
            <div class="form-container">
                <form action="/GoodDiary/Diary?action=add" method="post">
                	<input type="hidden" name="user_id" value="${user.userId}">
                    <div class="form-group">
                        <input type="text" name="title" placeholder="제목">
                        <input type="date" name="date">
        				<div style="display: flex; justify-content: space-between; margin-top: 10px;">
    						<label style="display: flex; align-items: center; margin-right: 10px; cursor: pointer;">
        						<input type="radio" name="emotion" value="기쁨" required style="margin-right: 5px;">
        						<span class="emoji">😊</span>
    						</label>
    						<label style="display: flex; align-items: center; margin-right: 10px; cursor: pointer;">
        						<input type="radio" name="emotion" value="슬픔" required style="margin-right: 5px;">
        						<span class="emoji">😭</span>
    						</label>
    						<label style="display: flex; align-items: center; cursor: pointer;">
        						<input type="radio" name="emotion" value="화남" required style="margin-right: 5px;">
        						<span class="emoji">😠</span>
    						</label>
						</div>
                    </div>
                    <textarea class="textarea" name="content" placeholder="감정 기록"></textarea>
                    <div class="button-group">
                        <button type="reset" class="button">취소</button>
                        <button type="submit" class="button">저장</button>
                    </div>
                </form>
            </div>
        </div>
		<jsp:include page="sidebar.jsp" />
    </div>
</body>
</html>
