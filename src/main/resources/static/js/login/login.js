const form = document.getElementById("loginForm");
const idInput = document.querySelector("input[name='memberId']");
const saveId = document.getElementById("saveId");

// 페이지 로드시 ID 복원
window.addEventListener("DOMContentLoaded", () => {

    const savedId = localStorage.getItem("savedId");

    if (savedId) {
        idInput.value = savedId;
        saveId.checked = true;
    }
});

// 로그인 submit 시 저장/삭제
form.addEventListener("submit", () => {

    const id = idInput.value.trim();

    // ID가 있을 때만 처리
    if (!id) return;

    if (saveId.checked) {
        localStorage.setItem("savedId", id);
    } else {
        localStorage.removeItem("savedId");
    }
});