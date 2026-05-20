const style = document.createElement("style");

style.innerHTML = `
.category-box {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 20px;
}

.category-box label {
    border: 1px solid #ddd;
    padding: 6px 12px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
    transition: 0.2s;
    background: #fff;
}

.category-box input {
    margin-right: 5px;
}

.category-box label:hover {
    background: #f5f5f5;
}

.card-img-top {
    width: 100%;
    height: 200px;   /* 원하는 고정 높이 */
    object-fit: cover; /* 핵심 */
}
`;

document.head.appendChild(style);

const checkboxes = document.querySelectorAll(
    'input[name="productType"]'
);

checkboxes.forEach((checkbox) => {
    checkbox.addEventListener("change", () => {
        checkbox.form.submit();
    });
});

const filters = document.querySelectorAll(
    'input[name="productType"], input[name="productLocation"]'
);

filters.forEach((filter) => {
    filter.addEventListener("change", () => {
        resetAndLoad();
    });
});

// 검색 처리 (엔터 키)
document.querySelector('input[name="search"]').addEventListener("keypress", (e) => {
    if (e.key === 'Enter') {
        e.preventDefault();
        resetAndLoad();
    }
});

// 검색 버튼 처리
document.querySelector("form button[type='submit']").addEventListener("click", (e) => {
    e.preventDefault();
    resetAndLoad();
});

function resetAndLoad() {
    $("#productContainer").empty();
    page = 1;
    loading = false;
    end = false;
    loadMore();
}

// ---------------------------------무한 스크롤--------------------------------------------
let page = 1;
let loading = false;
let end = false;

function loadMore() {

    if (loading || end) return;

    loading = true;

    // 현재 선택된 필터값들 가져오기
    const formData = $("form").serializeArray();
    const data = { page: page };
    formData.forEach(item => {
        data[item.name] = item.value;
    });

    $.ajax({
        url: "/product/myListAjax",
        type: "GET",
        data: data,
        success: function (html) {

            const data = $.trim(html);

            if (data.length === 0) {
                end = true;
                return;
            }

            $("#productContainer").append(data);

            page++;

        },
        complete: function () {
            loading = false;
        }
    });
}

// ⭐ 핵심 수정
const observer = new IntersectionObserver((entries) => {

    const entry = entries[0];

    if (entry.isIntersecting && !loading && !end) {
        loadMore();
    }

}, {
    root: null,
    threshold: 0
});

$(document).ready(function () {

    $("#productContainer").empty();

    page = 1;
    loading = false;
    end = false;

    loadMore();

    observer.observe(document.querySelector("#scrollTrigger"));
});