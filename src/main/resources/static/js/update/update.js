const uEmail = document.getElementById("uEmail");
const emailMsg = document.getElementById("emailMsg");
const emailBtn = document.getElementById("emailBtn");
const form = document.querySelector("form");

let emailOk = true;

// 기존 이메일 저장 (내 이메일 체크용 핵심)
const originEmail = uEmail.value;

emailBtn.addEventListener("click", async () => {

    const email = uEmail.value;

    if (!email) return;

    // ✔ 내 이메일이면 무조건 통과
    if (email === originEmail) {
        emailMsg.innerText = "사용 가능한 이메일입니다.";
        emailMsg.style.color = "blue";
        emailOk = true;
        return;
    }

    const res = await fetch("/member/emailCheck", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "memberEmail=" + encodeURIComponent(email)
    });

    const isDuplicate = await res.json();

    if (isDuplicate) {
        emailMsg.innerText = "이미 사용중인 이메일입니다.";
        emailMsg.style.color = "red";
        emailOk = false;
    } else {
        emailMsg.innerText = "사용 가능한 이메일입니다.";
        emailMsg.style.color = "green";
        emailOk = true;
    }
});

form.addEventListener("submit", (e) => {

    if (!emailOk) {
        e.preventDefault();
        alert("이메일을 확인해주세요.");
    }
});
//
const deleteBtn = document.getElementById("deleteImgBtn");
const deleteProfile = document.getElementById("deleteProfile");
const fileInput = document.getElementById("uAttach");
const fileLabel = document.getElementById("uSelectFile");

deleteBtn.addEventListener("click", () => {

    fileInput.value = "";

    fileLabel.innerText = "기본 프로필 사용";

    // 핵심: 삭제 상태만 저장
    deleteProfile.value = "true";
});
// -------------------------------------사진 이름------------------------------------
const attach = document.getElementById("uAttach");

attach.addEventListener("change", (e) => {

    const file = e.target.files[0];

    if (!file) return;

    // 이미지 파일 검사
    if (!file.type.startsWith("image/")) {

        alert("이미지 파일만 업로드 가능합니다.");

        e.target.value = "";

        document.getElementById("uSelectFile").innerText = "사진 선택";

        return;
    }

    document.getElementById("uSelectFile").innerText = file.name;

});