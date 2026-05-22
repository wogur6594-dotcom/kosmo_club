// -------------------------------기존 이미지 삭제------------------------------
$(document).ready(function() {

    $(document).on("click", ".delete-btn", function() {

        const fileNum = $(this).data("file-num");
        const $box = $(this).closest(".file-box");

        if (!confirm("이미지를 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: "/product/deleteFile",
            type: "POST",
            data: {
                fileNum: fileNum
            },
            success: function(res) {

                if (res === "success") {
                    $box.fadeOut(200, function() {
                        $(this).remove();

                        if ($("#fileBox .file-box").length === 0) {
                            $("#fileBox").html('<div class="empty-image-text">등록된 이미지가 없습니다.</div>');
                        }
                    });
                } else {
                    alert("삭제 실패");
                }
            },
            error: function() {
                alert("서버 오류 발생");
            }
        });
    });
});

// ------------------------------새 이미지 미리보기 + 즉시 추가-------------------------------
$(document).ready(function() {

    const fileInput = document.getElementById("fileInput");
    const previewBox = document.getElementById("previewBox");

    let fileStore = [];
    let fileKeySet = new Set();

    fileInput.addEventListener("change", function() {

        const files = Array.from(this.files);

        files.forEach(file => {

            if (!file.type.startsWith("image/")) {
                return;
            }

            const key = file.name + "_" + file.size + "_" + file.lastModified;

            if (fileKeySet.has(key)) {
                return;
            }

            fileKeySet.add(key);
            fileStore.push({
                file,
                key
            });
        });

        renderPreview();
        fileInput.value = "";
    });

    function renderPreview() {

        previewBox.innerHTML = "";

        fileStore.forEach(item => {

            const reader = new FileReader();

            reader.onload = function(e) {

                const wrapper = document.createElement("div");
                wrapper.className = "preview-item";

                const img = document.createElement("img");
                img.src = e.target.result;
                img.alt = "추가 이미지 미리보기";

                const btn = document.createElement("button");
                btn.type = "button";
                btn.className = "preview-remove";
                btn.innerText = "×";

                btn.addEventListener("click", function() {
                    fileStore = fileStore.filter(f => f.key !== item.key);
                    fileKeySet.delete(item.key);
                    renderPreview();
                });

                wrapper.appendChild(img);
                wrapper.appendChild(btn);
                previewBox.appendChild(wrapper);
            };

            reader.readAsDataURL(item.file);
        });
    }

    $("#addFileBtn").click(function() {

        let productNum = $("#productNum").val();

        if (fileStore.length === 0) {
            alert("파일 선택하세요");
            return;
        }

        let formData = new FormData();

        fileStore.forEach(item => {
            formData.append("file", item.file);
        });

        formData.append("productNum", productNum);

        $.ajax({
            url: "/product/addFile",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(res) {

                if (!res) {
                    alert("업로드 실패");
                    return;
                }

                let html = "";

                res.fileList.forEach(f => {
                    let src = f.fileName.startsWith("http")
                        ? f.fileName
                        : "/files/product/" + f.fileName;

                    html += `
						<div class="current-img-box file-box">
							<img src="${src}" alt="상품 이미지">
							<button type="button"
								class="current-img-delete delete-btn"
								data-file-num="${f.fileNum}">
								<i class="bi bi-x"></i>
							</button>
						</div>
					`;
                });

                $("#fileBox").html(html);

                fileStore = [];
                fileKeySet.clear();
                previewBox.innerHTML = "";
                $("#fileInput").val("");
            },
            error: function() {
                alert("서버 오류");
            }
        });
    });
});

// -------------------카카오 주소 검색 api----------------------------
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("productLocation").value = data.address;
        }
    }).open();
}