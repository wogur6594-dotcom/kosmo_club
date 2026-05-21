const form = document.getElementById("form");

const pw = document.getElementById("pw");
const newPw = document.getElementById("newPw");
const newPwCheck = document.getElementById("newPwCheck");
const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$/;

let pwOk = false;

// 현재 비밀번호 서버 체크
pw.addEventListener("blur", async () => {

    if (!pw.value.trim()) return;

    const res = await fetch("/member/checkPw", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "pw=" + encodeURIComponent(pw.value)
    });

    pwOk = await res.json();

    if (!pwOk) {
        alert("현재 비밀번호가 틀렸습니다");
    }
});

// submit 제어
form.addEventListener("submit", (e) => {

    // 1. 현재 비밀번호 틀림
    if (!pwOk) {
        e.preventDefault();
        alert("현재 비밀번호를 확인하세요");
        return;
    }

    // 2. 새 비밀번호 패턴 체크
    if (!pwRegex.test(newPw.value)) {
        e.preventDefault();
        alert("비밀번호는 8~16자 영문, 숫자, 특수문자를 포함해야 합니다.");
        return;
    }

    // 3. 새 비밀번호 확인
    if (newPw.value !== newPwCheck.value) {
        e.preventDefault();
        alert("새 비밀번호가 일치하지 않습니다");
        return;
    }

    // 4. 빈 값 방지 (@NotBlank 대응)
    if (!newPw.value.trim()) {
        e.preventDefault();
        alert("비밀번호를 입력하세요");
    }
});