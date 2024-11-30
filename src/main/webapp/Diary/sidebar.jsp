<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="sidebar">
    <ul class="menu">
        <!-- 각 메뉴 항목에 하이퍼링크 추가 -->
        <li>
            <a class="btn">
                반가워요 `<c:out value="${user.username}" default=" " />`님 😍
            </a>
        </li>
        <li><a href="/GoodDiary/Diary/diaryPage.jsp" class="btn">일기 작성 ✏️</a></li>
        <li><a href="/GoodDiary/Diary" class="btn">일기 목록 📚</a></li>
        <li><a href="/GoodDiary/Diary/calendar.jsp" class="btn">캘린더 🗓️</a></li>
        <li><a href="dataVisualization.jsp" class="btn">데이터 시각화 🔍</a></li>
        <li><a href="/GoodDiary/user/login.jsp" class="btn">로그인</a></li>
        <li><a href="/GoodDiary/logout" class="btn">로그아웃</a></li>
    </ul>
    <!-- 플러스 버튼도 페이지 이동 -->
    <div class="add-button">
        <a href="/GoodDiary/Diary/diaryPage.jsp" style="text-decoration: none; color: white;">+</a>
    </div>
</div>

<style>
    .menu {
        list-style: none;
        padding: 0;
        margin: 0;
        text-align: center;
        font-weight: bold;
    }

    .btn {
        display: inline-block;
        text-align: center;
        border-radius: 5px;
        padding: 10px 20px;
        text-decoration: none;
        box-sizing: border-box;
        width: 230px;
        background-color: orange;
        color: black;
        font-size: 16px;
        transition: all 0.3s ease;
    }

    .btn:hover {
        background-color: lightcoral;
        color: black;
        transform: scale(1.05);
        font-size: 17px;
    }

    .add-button {
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: Orange;
        color: white;
        border-radius: 50%;
        width: 50px;
        height: 50px;
        font-size: 30px;
        margin: 20px auto 0;
        transition: background-color 0.3s ease, transform 0.3s ease;
    }

    .add-button a {
        color: white;
        text-decoration: none;
    }

    .add-button:hover {
        background-color: #ff5050;
        transform: scale(1.1);
    }
</style>
        <div class="sidebar">
		    <ul class="menu">
		        <!-- 각 메뉴 항목에 하이퍼링크 추가 -->
		        <li><a href="/GoodDiary/Diary/diaryPage.jsp" style="text-decoration: none; color: inherit;">일기 작성 ✏️</a></li>
		        <li><a href="emotionLog.jsp" style="text-decoration: none; color: inherit;">일기 목록 📚</a></li>
		        <li><a href="calendar.jsp" style="text-decoration: none; color: inherit;">캘린더 🗓️</a></li>
		        <li><a href="dataVisualization.jsp" style="text-decoration: none; color: inherit;">데이터 시각화 🔍</a></li>
		        <li><a href="settings.jsp" style="text-decoration: none; color: inherit;">설정 ⚙️</a></li>
		    </ul>
		    <!-- 플러스 버튼도 페이지 이동 -->
		    <div class="add-button">
		        <a href="/GoodDiary/Diary/diaryPage.jsp" style="text-decoration: none; color: white;">+</a>
		    </div>
		</div>
		<style>
		.menu {
			text-align: center;
			font-weight: bold;
		}
		a {
			display: inline-block;
			text-align: center;
			border: solid black 3px;
			border-radius: 5px;
			padding: 5px 10px;
			text-decoration: none;
			box-sizing: border-box;
			width: 180px;
			background-color: orange;
			color: black;
		}
		a:hover {
			background-color: lightcoral;
			color: black;
			transfrom: scale(1.02);
			font-size: larger;
		}
		</style>
