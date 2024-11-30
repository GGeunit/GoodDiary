<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="/jaewan_free/resources/common.css" type="text/css">
</head>
<body>
    <header>
        로그인
    </header>
    <main>
        <!-- 로그인 폼 -->
        <form action="LoginServlet" method="post">
            <!-- 에러 메시지 표시 -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <p style="color: red;"><%= errorMessage %></p>
            <%
                }
            %>

            <!-- 사용자 ID 입력 -->
            <div>
                <label for="id">ID:</label>
                <input type="text" id="id" name="id" required placeholder="아이디를 입력하세요">
            </div>

            <!-- 비밀번호 입력 -->
            <div>
                <label for="passwd">비밀번호:</label>
                <input type="password" id="passwd" name="passwd" required placeholder="비밀번호를 입력하세요">
            </div>

            <!-- 로그인 버튼 -->
            <div>
                <button type="submit">로그인</button>
            </div>
        </form>

        <!-- 회원가입 링크 -->
        <p>
            계정이 없으신가요? <a href="register.html">회원가입</a>
        </p>
    </main>
</body>
</html>
