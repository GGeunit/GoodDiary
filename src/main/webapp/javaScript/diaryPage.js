document.addEventListener("DOMContentLoaded", () => {
    const cancelButton = document.querySelector('button[type="reset"]');
    
    if (cancelButton) {
        cancelButton.addEventListener("click", (event) => {
            event.preventDefault();
            const userConfirmed = confirm("이전 페이지로 돌아가시겠습니까?");
            if (userConfirmed) {
                window.location.href = "diaryListPage.jsp";
            }
        });
    }
});
