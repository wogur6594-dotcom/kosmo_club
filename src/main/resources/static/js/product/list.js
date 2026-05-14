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
`;

document.head.appendChild(style);