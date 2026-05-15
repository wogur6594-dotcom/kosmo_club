// -------------------------------이미지 삭제------------------------------
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
            data: { fileNum: fileNum },
            success: function(res) {
                if (res === "success") {
                    $box.fadeOut(200, function() {
                        $(this).remove();
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

//------------------------------이미지 추가-------------------------------
$(document).ready(function() {

    $("#addFileBtn").click(function() {

        let files = $("#fileInput")[0].files;
        let productNum = $("#productNum").val();

        if (files.length === 0) {
            alert("파일 선택하세요");
            return;
        }

        let formData = new FormData();

        for (let i = 0;i < files.length;i++) {
            formData.append("file", files[i]); // 👈 같은 key로 여러개
        }

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
                    html += `
                        <div class="position-relative mr-2 file-box">
                            <img src="/files/product/${f.fileName}"
                                 style="width:80px;height:80px;object-fit:cover;">
                            <button type="button"
                                    class="btn btn-sm btn-danger delete-btn"
                                    data-file-num="${f.fileNum}"
                                    style="position:absolute;top:0;right:0;">
                                <i class="bi bi-x"></i>
                            </button>
                        </div>
                    `;
                });

                $("#fileBox").html(html);

                // input 초기화
                $("#fileInput").val("");

            },
            error: function() {
                alert("서버 오류");
            }
        });
    });

});