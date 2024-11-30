document.addEventListener("DOMContentLoaded", () => {
	const cancelButton = document.querySelector('button[type="reset]');
	
	if (cancelButton) {
	        cancelButton.addEventListener("click", (event) => {
	            // 폼이 리셋되는 기본 동작 막기
	            event.preventDefault();

	            // 사용자에게 확인 창 띄우기
	            const userConfirmed = confirm("이전 페이지로 돌아가시겠습니까?");
	            if (userConfirmed) {
	                // 사용자가 확인을 눌렀을 때 이동
	                window.location.href = "diaryListPage.jsp"; // 이동할 페이지 경로
	            }
	        });
	    }
});