<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Good Diary Login</title>
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
        .form-section form input[type="email"],
        .form-section form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #dddddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-section form .checkbox-container {
            display: flex;
            align-items: center;
        }
        .form-section form .checkbox-container input[type="checkbox"] {
            margin-right: 10px;
        }
        .form-section form .btn {
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
        .form-section form .btn:hover {
            background-color: #e67e22;
        }
        .form-section .links {
            margin-top: 15px;
            font-size: 14px;
        }
        .form-section .links a {
            color: #f39c12;
            text-decoration: none;
            margin-right: 10px;
        }
        .image-section {
            width: 50%;
            background: url('../images/loginPage.jpg') no-repeat center;
            background-size: cover;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-section">
            <h1><img src="../images/goodDiary.png" alt="Logo"> Good.Diary</h1>
            <p>당신의 감정이 이야기가 됩니다.<br>오늘의 일기를 작성해 보세요.</p>
            <p>환영합니다! 계정에 로그인하세요.</p>
            <form action="loginAction.jsp" method="post">
                <input type="text" name="name" placeholder="User name" required>
                <input type="password" name="password" placeholder="Password" required>
                <div class="checkbox-container">
                    <input type="checkbox" name="rememberMe" id="rememberMe">
                    <label for="rememberMe">Remember me</label>
                </div>
                <button type="submit" class="btn">Login</button>
                <div class="links">
                    <a href="#">Forgot password?</a>
                    <a href="signup.jsp">Sign Up</a>
                </div>
                <p style="margin-top: 10px;">Or, login with 
                    <a href="#">Facebook</a> 
                    <a href="#">LinkedIn</a> 
                    <a href="#">Google</a>
                </p>
            </form>
        </div>
        <div class="image-section"></div>
    </div>
</body>
</html>
