window.addEventListener("DOMContentLoaded", () => {

    const fileInput = document.getElementById("fileInput");
    const previewBox = document.getElementById("previewBox");
    const form = document.querySelector("form");

    let fileStore = [];
    let fileKeySet = new Set();

    // -----------------------------
    // 파일 선택
    // -----------------------------
    fileInput.addEventListener("change", function () {

        const files = Array.from(this.files);

        // 10개 제한 (누적 기준)
        if (fileStore.length + files.length > 10) {
            alert("이미지는 최대 10개까지만 업로드 가능합니다.");
            fileInput.value = "";
            return;
        }

        files.forEach(file => {

            if (!file.type.startsWith("image/")) return;

            const key = file.name + "_" + file.size + "_" + file.lastModified;

            // 중복 방지
            if (fileKeySet.has(key)) return;

            fileKeySet.add(key);
            fileStore.push({ file, key });
        });

        renderPreview();
        fileInput.value = "";
    });

    // -----------------------------
    // 미리보기 렌더링
    // -----------------------------
    function renderPreview() {

        previewBox.innerHTML = "";

        fileStore.forEach((item) => {

            const file = item.file;

            const reader = new FileReader();

            reader.onload = function (e) {

                const wrapper = document.createElement("div");
                wrapper.style.position = "relative";
                wrapper.style.display = "inline-block";
                wrapper.style.marginRight = "10px";
                wrapper.style.marginBottom = "10px";

                const img = document.createElement("img");
                img.src = e.target.result;
                img.style.width = "120px";
                img.style.height = "120px";
                img.style.objectFit = "cover";
                img.style.border = "1px solid #ddd";
                img.style.borderRadius = "8px";

                const btn = document.createElement("button");
                btn.innerText = "X";
                btn.type = "button";
                btn.style.position = "absolute";
                btn.style.top = "0";
                btn.style.right = "0";
                btn.style.background = "red";
                btn.style.color = "white";
                btn.style.border = "none";
                btn.style.borderRadius = "50%";
                btn.style.width = "22px";
                btn.style.height = "22px";
                btn.style.cursor = "pointer";

                // 삭제
                btn.addEventListener("click", () => {

                    fileStore = fileStore.filter(f => f.key !== item.key);
                    fileKeySet.delete(item.key);

                    renderPreview();
                });

                wrapper.appendChild(img);
                wrapper.appendChild(btn);
                previewBox.appendChild(wrapper);
            };

            reader.readAsDataURL(file);
        });
    }

    // submit 전에 실제 파일 주입
    form.addEventListener("submit", () => {

        const dt = new DataTransfer();

        fileStore.forEach(item => {
            dt.items.add(item.file);
        });

        fileInput.files = dt.files;
    });

});

// -------------------카카오 주소 검색 api----------------------------
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 전체 주소
            let fullAddr = data.address;

            // 입력창에 자동 세팅
            document.getElementById("productLocation").value = fullAddr;
        }
    }).open();
}