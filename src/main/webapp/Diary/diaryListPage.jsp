<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Diary.Diary" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일기 목록</title>
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
            color: black;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .diary-list {
            background-color: #fff8dc;
            border-radius: 10px;
            padding: 20px;
        }

		.diary-item {
		    display: flex; /* 플렉스 박스 사용 */
		    justify-content: space-between; /* 요소 간 간격 균등 분배 */
		    align-items: center; /* 세로 중앙 정렬 */
		    padding: 10px;
		    margin-bottom: 10px;
		    background-color: #ffefd5;
		    border-radius: 5px;
		}

        .diary-item:hover {
            background-color: #ffd27d;
        }

		.diary-title {
		    font-size: 16px;
		    color: black;
		    flex: 1; /* 제목이 가능한 공간을 차지하도록 설정 */
		    text-decoration: none;
		}
		
		.diary-date {
		    font-size: 14px;
		    color: #888;
		    margin-right: 10px; /* 날짜와 이모지 간 간격 추가 */
		}
		
		.emoji {
		    font-size: 16px;
		    margin-left: 10px; /* 이모지가 날짜와 간격을 유지하도록 설정 */
		}
		
		.delete-form {
		    margin: 0;
		    padding: 0;
		    display: inline; /* 버튼이 한 줄로 정렬되도록 설정 */
		}
		
		.delete-button {
		    background-color: #ff7070; /* 빨간색 계열 배경 */
		    color: white; /* 흰색 글자 */
		    border: none; /* 테두리 제거 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    padding: 5px 10px; /* 안쪽 여백 */
		    font-size: 14px; /* 글자 크기 */
		    cursor: pointer; /* 커서를 포인터로 변경 */
		    transition: background-color 0.3s ease; /* 호버 시 부드러운 전환 효과 */
		}
		
		.delete-button:hover {
		    background-color: #ff4949; /* 호버 시 더 어두운 빨간색 */
		}
		
		.emotion-score {
		    margin-left: 3px; /* 왼쪽 간격 */
		    margin-right: 10px; /* 오른쪽 간격 */
		    font-size: 15px; /* 글자 크기 */
		    color: #333; /* 더 진한 색상 */
		    display: inline-block; /* 고정된 폭 적용 */
		    width: 30px; /* 숫자 영역의 고정된 폭 */
		    text-align: center; /* 숫자 값을 중앙 정렬 */
		}

				
		
    </style>
</head>
<body>
    <div class="container">
        <div class="main">
            <div class="header">내 일기 목록</div>
            <div class="diary-list">
  				<c:if test="${not empty diaries}">
			    <c:forEach var="diary" items="${diaries}">
			        <div class="diary-item">
			            <a href="/GoodDiary/Diary?action=view&id=${diary.recordId}" class="diary-title">${diary.title}</a>
						<div class="diary-date">${diary.date}</div>
    			        <c:choose>
                            <c:when test="${diary.emotion == 'Very Positive'}"><span class="emoji">😁</span></c:when>
                            <c:when test="${diary.emotion == 'Positive'}"><span class="emoji">😊</span></c:when>
                            <c:when test="${diary.emotion == 'Neutral'}"><span class="emoji">😐</span></c:when>
                            <c:when test="${diary.emotion == 'Negative'}"><span class="emoji">😔</span></c:when>
                            <c:when test="${diary.emotion == 'Very Negative'}"><span class="emoji">😡</span></c:when>
                            <c:otherwise><span class="emoji">🤔</span></c:otherwise>
			            </c:choose>
			            <span class="emotion-score">(${diary.emotionScore})</span>

			            
                         <!-- 삭제 버튼 -->
		                <form action="/GoodDiary/Diary" method="get" class="delete-form" onsubmit="return confirmDelete();">
		                    <input type="hidden" name="action" value="delete">
		                    <input type="hidden" name="id" value="${diary.recordId}">
		                    <button type="submit" class="delete-button">삭제</button>
		                </form>
			        </div>
			    </c:forEach>
				</c:if>
				<c:if test="${empty diaries}">
				    <div>일기가 없습니다.</div>
				</c:if>
			  				
            </div>
        </div>
		<jsp:include page="sidebar.jsp" />
		
		<script>
		    // 삭제 확인 함수
		    function confirmDelete() {
		        return confirm("정말로 이 일기를 삭제하시겠습니까?");
		    }
		</script>
</body>
</html>