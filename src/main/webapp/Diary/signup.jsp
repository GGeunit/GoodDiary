<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Good.Diary</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #FFEDC2; /* 배경색을 따뜻한 톤으로 설정 */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .signup-container {
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 400px;
            padding: 30px;
            text-align: center;
        }

        .signup-container img {
            width: 50px;
            height: 50px;
            margin-bottom: 10px;
        }

        .signup-container h1 {
            color: #f8b400;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .signup-container p {
            color: #555;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #777;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .form-group input:focus {
            outline: none;
            border-color: #f8b400;
        }

        .signup-btn {
            background-color: #f8b400;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        .signup-btn:hover {
            background-color: #e09d00;
        }

        .footer-text {
            margin-top: 20px;
            font-size: 12px;
            color: #888;
        }

        .footer-text a {
            color: #f8b400;
            text-decoration: none;
        }

        .footer-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <img src="../images/goodDiary.png" alt="Logo"> <!-- 로고 이미지 -->
        <h1>Good.Diary</h1>
        <p>Welcome! <br> Join The Community</p>

        <form action="signupProcess.jsp" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="goodDiary@gmail.com" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
            </div>
            <button type="submit" class="signup-btn">Sign Up</button>
        </form>

        <div class="footer-text">
            Already a member? <a href="login.jsp">Login here →</a>
        </div>
        
        
        asdfa
    </div>
</body>
</html>
