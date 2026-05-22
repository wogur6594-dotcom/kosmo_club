window.addEventListener("DOMContentLoaded", () => {

    const fileInput = document.getElementById("fileInput");
    const previewBox = document.getElementById("previewBox");
    const form = document.querySelector("form");

    let fileStore = [];
    let fileKeySet = new Set();

    fileInput.addEventListener("change", function() {

        const files = Array.from(this.files);

        if (fileStore.length + files.length > 10) {
            alert("이미지는 최대 10개까지만 업로드 가능합니다.");
            fileInput.value = "";
            return;
        }

        files.forEach(file => {

            if (!file.type.startsWith("image/")) {
                return;
            }

            const key = file.name + "_" + file.size + "_" + file.lastModified;

            if (fileKeySet.has(key)) {
                return;
            }

            fileKeySet.add(key);
            fileStore.push({ file, key });
        });

        renderPreview();
        fileInput.value = "";
    });

    function renderPreview() {

        previewBox.innerHTML = "";

        fileStore.forEach((item) => {

            const file = item.file;
            const reader = new FileReader();

            reader.onload = function(e) {

                const wrapper = document.createElement("div");
                wrapper.className = "preview-item";

                const img = document.createElement("img");
                img.src = e.target.result;
                img.alt = "상품 이미지 미리보기";

                const btn = document.createElement("button");
                btn.innerText = "×";
                btn.type = "button";
                btn.className = "preview-remove";

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

    form.addEventListener("submit", () => {

        const dt = new DataTransfer();

        fileStore.forEach(item => {
            dt.items.add(item.file);
        });

        fileInput.files = dt.files;
    });
});

function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("productLocation").value = data.address;
        }
    }).open();
}