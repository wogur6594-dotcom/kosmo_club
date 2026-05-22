let socket;
let messageQueue = [];

/* =========================
   연결
========================= */
function connectSocket() {

    socket = new WebSocket(
        "ws://" + location.host + "/ws/productChat?chatroomNum=" + chatroomNum
    );

    socket.onopen = function() {
        console.log("채팅 연결 성공");

        messageQueue.forEach(m => socket.send(JSON.stringify(m)));
        messageQueue = [];

        sendReadEvent();
    };

    socket.onmessage = function(event) {

        let msg = JSON.parse(event.data);

        // =========================
        // read 이벤트
        // =========================
        if (msg.type === "read") {
            // 내가 보낸 read 이벤트가 아닐 때만 UI 업데이트
            if (Number(msg.senderNum) !== Number(loginUserNum)) {
                markAsReadUI();
            }
            return;
        }

        renderMessage(msg);
    };

    socket.onclose = function() {
        setTimeout(connectSocket, 2000);
    };
}

/* =========================
   메시지 전송
========================= */
function sendMessage() {

    let input = document.getElementById("message");

    if (!input.value.trim()) return;

    safeSend({
        type: "text",
        chatroomNum: Number(chatroomNum),
        messageContent: input.value
    });

    input.value = "";
}

/* =========================
   read 이벤트
========================= */
function sendReadEvent() {

    safeSend({
        type: "read",
        chatroomNum: Number(chatroomNum)
    });
}

/* =========================
   안전 전송
========================= */
function safeSend(data) {

    if (!socket || socket.readyState !== 1) {
        messageQueue.push(data);
        return;
    }

    socket.send(JSON.stringify(data));
}

/* =========================
   플러스 메뉴 & 추가 기능
========================= */
function togglePlusMenu() {
    const menu = document.getElementById("plusMenu");
    menu.style.display = (menu.style.display === "flex") ? "none" : "flex";
    scrollToBottom();
}

// 사진 업로드
function uploadFile(input) {
    if (!input.files || !input.files[0]) return;

    const formData = new FormData();
    formData.append("file", input.files[0]);

    fetch("/productChat/uploadImage", {
        method: "POST",
        body: formData
    })
    .then(res => res.text())
    .then(filename => {
        safeSend({
            type: "image",
            chatroomNum: Number(chatroomNum),
            messageContent: filename
        });
        input.value = ""; // 초기화
    });
}

// 상태 변경
function updateStatus(status) {
    if (!confirm("상품 상태를 [" + status + "](으)로 변경하시겠습니까?")) return;

    const formData = new URLSearchParams();
    formData.append("productNum", productNum);
    formData.append("productStatus", status);

    fetch("/productChat/updateStatus", {
        method: "POST",
        body: formData
    })
    .then(res => res.text())
    .then(result => {
        if (result === "success") {
            // 시스템 메시지 전송
            safeSend({
                type: "system",
                chatroomNum: Number(chatroomNum),
                messageContent: `${loginUserId}님이 거래를 ${status}으로 변경했습니다.`,
                extra: "status_changed"
            });
        }
    });
}
// 위치 공유 (지도 모달 기반)
let modalMap, marker, geocoder;
let selectedPlaceData = null;

function shareLocation() {
    $('#mapModal').modal('show');

    // 모달이 완전히 열린 후 지도 생성
    $('#mapModal').on('shown.bs.modal', function () {
        initModalMap();
    });
}

function initModalMap() {
    const mapContainer = document.getElementById('modalMap');

    if (!modalMap) {
        const mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 서울시청 기준
            level: 3
        };
        modalMap = new kakao.maps.Map(mapContainer, mapOption);
        marker = new kakao.maps.Marker({ position: modalMap.getCenter() });
        marker.setMap(modalMap);
        geocoder = new kakao.maps.services.Geocoder();

        // 지도를 클릭했을 때 마커 이동 및 주소 획득
        kakao.maps.event.addListener(modalMap, 'click', function(mouseEvent) {
            const latlng = mouseEvent.latLng;
            marker.setPosition(latlng);
            updateAddressFromCoords(latlng);
        });
    } else {
        modalMap.relayout();
    }
}

function searchPlacesInModal() {
    const keyword = document.getElementById('mapSearchKeyword').value;
    if (!keyword.trim()) return;

    const ps = new kakao.maps.services.Places();
    ps.keywordSearch(keyword, (data, status) => {
        if (status === kakao.maps.services.Status.OK) {
            const place = data[0];
            const coords = new kakao.maps.LatLng(place.y, place.x);
            modalMap.setCenter(coords);
            marker.setPosition(coords);

            selectedPlaceData = {
                name: place.place_name,
                lat: place.y,
                lng: place.x
            };
            document.getElementById('selectedAddress').innerText = "선택된 장소: " + place.place_name;
        } else {
            alert("검색 결과가 없습니다.");
        }
    });
}

function updateAddressFromCoords(coords) {
    geocoder.coord2Address(coords.getLng(), coords.getLat(), (result, status) => {
        if (status === kakao.maps.services.Status.OK) {
            const addr = result[0].address.address_name;
            selectedPlaceData = {
                name: addr,
                lat: coords.getLat(),
                lng: coords.getLng()
            };
            document.getElementById('selectedAddress').innerText = "선택된 주소: " + addr;
        }
    });
}

function confirmLocation() {
    if (!selectedPlaceData) {
        alert("장소를 선택하거나 검색해 주세요.");
        return;
    }

    safeSend({
        type: "map",
        chatroomNum: Number(chatroomNum),
        messageContent: `${selectedPlaceData.name}|${selectedPlaceData.lat},${selectedPlaceData.lng}`
    });

    $('#mapModal').modal('hide');
    selectedPlaceData = null;
    document.getElementById('mapSearchKeyword').value = "";
}

/* =========================
   메시지 렌더링
========================= */
function renderMessage(data) {

    let box = document.getElementById("chatBox");

    let div = document.createElement("div");

    const isSystem = data.type === "system";
    const isMe = Number(data.senderNum) === Number(loginUserNum);

    div.className = "msg " + (isSystem ? "system" : (isMe ? "me" : "other"));
    
    if (isSystem && data.extra === "status_changed") {
        setTimeout(() => location.reload(), 1000);
    }

    const time = formatTime(data.createtime);

    let contentHtml = "";
    if (data.type === "image") {
        let imgSrc = data.messageContent.startsWith("http") ? data.messageContent : "/files/chat/" + data.messageContent;
        contentHtml = `<img src="${imgSrc}" alt="사진" style="max-width:200px; border-radius:8px; cursor:pointer" onclick="window.open(this.src)">`;
    } else if (data.type === "map") {
        const [addr, coord] = data.messageContent.split("|");
        contentHtml = `
            <div><strong>[장소 공유]</strong></div>
            <div>${addr}</div>
            <a href="https://map.kakao.com/link/map/${addr},${coord}" target="_blank" class="map-btn">
                <i class="bi bi-geo-alt"></i> 지도 보기
            </a>
        `;
    } else {
        contentHtml = data.messageContent ?? "";
    }

    div.innerHTML = `
        ${!isSystem ? `<div class="sender">${data.senderName ?? ""}</div>` : ""}

        <div class="content">${contentHtml}</div>

        ${!isSystem ? `
        <div class="meta">
            <span class="time">${time}</span>
            ${isMe && !data.isRead ? `<span class="unread-badge">1</span>` : ``}
        </div>
        ` : ""}
    `;

    box.appendChild(div);
    scrollToBottom();
}

/* =========================
   read UI 처리
========================= */
function markAsReadUI() {

    document.querySelectorAll(".msg.me .unread-badge")
        .forEach(el => el.remove());
}

/* =========================
   시간
========================= */
function formatTime(time) {

    if (!time) return "";

    if (typeof time === "string") {
        time = time.split(".")[0];
        const [date, t] = time.split("T");
        if (t) {
            const [h, m] = t.split(":");
            return `${h}:${m}`;
        }
    }

    let d = new Date(time);
    if (!isNaN(d.getTime())) {
        return String(d.getHours()).padStart(2, '0') + ":" + String(d.getMinutes()).padStart(2, '0');
    }

    return "";
}

function initMessageTimes() {

    document.querySelectorAll(".msg .time").forEach(el => {
        const raw = el.dataset.time;
        if (raw) {
            el.innerText = formatTime(raw);
        }
    });
}

function scrollToBottom() {

    let box = document.getElementById("chatBox");

    if (!box) return;

    box.scrollTop = box.scrollHeight;
    setTimeout(() => {
        box.scrollTop = box.scrollHeight;
    }, 150);
}

/* =========================
   이벤트
========================= */
document.getElementById("message").addEventListener("keydown", e => {
    if (e.key === "Enter") sendMessage();
});

window.addEventListener("focus", sendReadEvent);

/* =========================
   시작
========================= */
window.onload = function() {

    connectSocket();

    initMessageTimes();
    scrollToBottom();
};
