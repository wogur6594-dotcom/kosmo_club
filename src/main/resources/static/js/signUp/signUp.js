//-------- ID 중복검사---------------------------
const checkBtn = document.getElementById("checkBtn");
const memberId = document.getElementById("memberId");
const form = document.getElementById("form");

let isIdChecked = false;
let isIdAvailable = false;

// 아이디 변경하면 다시 체크해야 하게 초기화
memberId.addEventListener("change", () => {
    isIdChecked = false;
    isIdAvailable = false;
    document.getElementById("idStatus").innerText = "";
});

memberId.addEventListener("input", () => {
    const regex = /^[a-zA-Z0-9]*$/;

    if (!regex.test(memberId.value)) {
        alert("영어와 숫자만 입력 가능합니다");
        memberId.value = memberId.value.replace(/[^a-zA-Z0-9]/g, "");
    }
});

checkBtn.addEventListener("click", () => {
    const idValue = memberId.value;

    if (!idValue) {
        alert("아이디를 입력하세요");
        return;
    }

    fetch(`/member/checkId?memberId=${idValue}`)
        .then(res => res.json())
        .then(data => {
            isIdChecked = true;
            isIdAvailable = !data; // true면 중복

            if (data) {
                idStatus.style.color = "red";
                document.getElementById("idStatus").innerText = "사용 불가능";
            } else {
                idStatus.style.color = "green";
                document.getElementById("idStatus").innerText = "사용 가능";
            }
        });
});
//------------------- PW 확인---------------------------
const pw = document.getElementById("pw");
const pwCheck = document.getElementById("pwCheck");
const pwInputBox = document.getElementById("pwInputBox");
const pwStatus = document.getElementById("pwStatus");

let isPwChecked = false;

pw.addEventListener("input", () => {
    if (pw.value) {
        pwInputBox.classList.remove("d-none");
    } else {
        pwInputBox.classList.add("d-none");
        pwCheck.value = "";
        pwStatus.innerText = "";
        isPwChecked = false;
    }
});

pw.addEventListener("change", () => {
    pwCheck.value = "";
    pwStatus.innerText = "";
    isPwChecked = false;
})

pwCheck.addEventListener("blur", () => {

    if (!pwCheck.value) {
        alert("확인할 비밀번호를 입력하세요");
        return;
    }

    if (pw.value === pwCheck.value) {
        pwStatus.innerText = "비밀번호 일치";
        pwStatus.style.color = "green";
        isPwChecked = true;
    } else {
        pwStatus.innerText = "비밀번호 불일치";
        pwStatus.style.color = "red";
        isPwChecked = false;
    }
});

//------------------- 이메일 중복 확인---------------------------
const emailCheckBtn = document.getElementById("emailCheckBtn");
const email = document.getElementById("email")
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

let isEmailChecked = false;
let isEmailAvailable = false;

email.addEventListener("change", () => {
    isEmailChecked = false;
    isEmailAvailable = false;
    document.getElementById("emailStatus").innerText = "";
})


emailCheckBtn.addEventListener("click", () => {
    const eValue = email.value;

    if (!eValue) {
        alert("이메일을 입력하세요.");
        return;
    }
	
	if (!emailRegex.test(eValue)) {
	    isEmailChecked = false;
	    isEmailAvailable = false;

	    emailStatus.style.color = "red";
	    document.getElementById("emailStatus").innerText = "올바른 이메일 형식이 아닙니다.";

	    return;
	}

    fetch(`/member/checkEmail?memberEmail=${eValue}`)
        .then(res => res.json())
        .then(data => {
            isEmailChecked = true;
            isEmailAvailable = !data; // true면 중복

            if (data) {
                emailStatus.style.color = "red";
                document.getElementById("emailStatus").innerText = "사용 불가능";
            } else {
                emailStatus.style.color = "green";
                document.getElementById("emailStatus").innerText = "사용 가능";
            }
        });

})







// ----------------------------------- submit 버튼 ----------------------------------

form.addEventListener("submit", (e) => {

    if (!isIdChecked) {
        alert("아이디 중복체크를 해주세요");
        e.preventDefault();
        return;
    }

    if (!isIdAvailable) {
        alert("이미 사용중인 아이디입니다");
        e.preventDefault();
        return;
    }

    if (!isPwChecked) {
        alert("비밀번호 확인을 해주세요");
        e.preventDefault();
        return;
    }

    if (!isEmailChecked) {
        alert("이메일 중복체크를 해주세요");
        e.preventDefault();
        return;
    }

    if (!isEmailAvailable) {
        alert("이미 사용중인 아이디입니다");
        e.preventDefault();
        return;
    }

});

// -------------------------------------사진 이름------------------------------------
const attach = document.getElementById("attach");

attach.addEventListener("change", (e) => {

    const file = e.target.files[0];

    if (!file) return;

    // 이미지 파일 검사
    if (!file.type.startsWith("image/")) {

        alert("이미지 파일만 업로드 가능합니다.");

        e.target.value = "";

        document.getElementById("selectFile").innerText = "사진 선택";

        return;
    }

    document.getElementById("selectFile").innerText = file.name;

});