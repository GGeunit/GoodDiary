<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Date Range</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fbe2a5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            display: flex;
            width: 900px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
        }
        .form-section {
            padding: 30px;
            width: 50%;
        }
        .form-section h1 {
            color: #f39c12;
            margin: 0;
            font-size: 24px;
            display: flex;
            align-items: center;
        }
        .form-section h1 img {
            height: 30px;
            margin-right: 10px;
        }
        .form-section p {
            margin-top: 10px;
            font-size: 16px;
            color: #333333;
        }
        .form-section form {
            margin-top: 20px;
        }
        .form-section form label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #555555;
        }
        .form-section form input[type="date"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #dddddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-section form button {
            width: 100%;
            background-color: #f39c12;
            color: #ffffff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .form-section form button:hover {
            background-color: #e67e22;
        }
        .image-section {
            width: 50%;
            background: url('../images/diaryBackground.jpg') no-repeat center;
            background-size: cover;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-section">
            <h1><img src="../images/goodDiary.png" alt="Logo"> Good.Diary</h1>
            <p>분석할 기간을 선택하세요.<br>당신의 감정을 알아보는 여정을 시작하세요.</p>
            <form action="/GoodDiary/Diary" method="get">
                <input type="hidden" name="action" value="analyze">
                
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" required>
                
                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" required>
                
                <button type="submit">Analyze Diaries</button>
            </form>
        </div>
        <div class="image-section"></div>
    </div>
</body>
</html>
