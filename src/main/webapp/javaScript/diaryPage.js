document.addEventListener("DOMContentLoaded", () => {
    const cancelButton = document.querySelector('button[type="reset"]');
    
    if (cancelButton) {
        cancelButton.addEventListener("click", (event) => {
            // 폼 리셋 방지
            event.preventDefault();

            // 확인창 띄우기
            const userConfirmed = confirm("이전 페이지로 돌아가시겠습니까?");
            if (userConfirmed) {
                // 페이지 이동
                window.location.href = "diaryListPage.jsp";
            }
        });
    }
});
