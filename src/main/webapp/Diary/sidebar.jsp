<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="sidebar">
    <div class="toplogo">
    	<img src="../images/goodDiary.png" width="55px" height="55px">
    </div>
    <ul class="menu">
        <!-- 각 메뉴 항목에 하이퍼링크 추가 -->
        <li><a href="/GoodDiary/Diary/diaryPage.jsp" class="btn">일기 작성 ✏️</a></li>
        <li><a href="/GoodDiary/Diary" class="btn">일기 목록 📚</a></li>
        <li><a href="calendar.jsp" class="btn">캘린더 🗓️</a></li>
        <li><a href="dataVisualization.jsp" class="btn">데이터 시각화 🔍</a></li>
        <li><a href="/GoodDiary/logout" class="btn">로그아웃</a></li>
    </ul>
</div>

<style>
	.toplogo {
		margin: 0 auto;
	}
    .menu {
        list-style: none;
        padding: 0;
        margin: 0;
        text-align: center;
        font-weight: bold;
        margin-bottom: 190px;;
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
</style>