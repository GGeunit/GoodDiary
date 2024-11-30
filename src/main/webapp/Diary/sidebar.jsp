<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <div class="sidebar">
		    <ul class="menu">
		        <!-- 각 메뉴 항목에 하이퍼링크 추가 -->
		        <li><a href="/GoodDiary/Diary/diaryPage.jsp" style="text-decoration: none; color: inherit;">일기 작성</a></li>
		        <li><a href="calendar.jsp" style="text-decoration: none; color: inherit;">캘린더</a></li>
		        <li><a href="/GoodDiary/Diary" style="text-decoration: none; color: inherit;">일기 목록</a></li>
		        <li><a href="dataVisualization.jsp" style="text-decoration: none; color: inherit;">데이터 시각화</a></li>
		        <li><a href="settings.jsp" style="text-decoration: none; color: inherit;">설정</a></li>
		        <li><a href="settings.jsp" style="text-decoration: none; color: inherit;"><c:out value="${user.userId}" default=" " />님 안녕하세용</a></li>
		        <li><a href="/GoodDiary/user/login.jsp" style="text-decoration: none; color: inherit;">로그인</a></li>
		        <li><a href="/GoodDiary/logout" style="text-decoration: none; color: inherit;">로그아웃</a></li>
		    </ul>
		    <!-- 플러스 버튼도 페이지 이동 -->
		    <div class="add-button">
		        <a href="/GoodDiary/Diary/diaryPage.jsp" style="text-decoration: none; color: white;">+</a>
		    </div>
		</div>