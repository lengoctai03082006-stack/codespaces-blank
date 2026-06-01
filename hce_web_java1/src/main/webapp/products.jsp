<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="dao.*"%>

<%
    // 1. Nhận danh sách sản phẩm được chuyển tiếp an toàn từ Servlet
    List<Product> listProduct = (List<Product>) request.getAttribute("listProduct");

    // 2. Đồng bộ hóa từ khóa tìm kiếm "q" để giữ lại nội dung trên thanh nhập liệu
    String keyword = request.getParameter("q");
    if(keyword == null){
        ProductDAO dao = new ProductDAO();
        listProduct = dao.getAllProducts();
        keyword = "";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Northwind Products - HCE</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body{
        background:#f4f6f9;
        padding: 0; /* Xóa padding body để thanh điều hướng HCE full tràn viền góc màn hình */
    }

    /* ================= CSS CHUẨN GIAO DIỆN HEADER HCE ================= */
    header {
        background-color: #fff;
        width: 100%;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }

    .hce-top-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 8%;
        background-color: #ffffff;
    }

    .hce-left-links {
        display: flex;
        gap: 20px;
    }

    .hce-left-links a {
        text-decoration: none;
        color: #777;
        font-weight: bold;
        font-size: 13px;
        text-transform: uppercase;
    }

    .hce-left-links a.active {
        color: #b31f24;
    }

    .hce-logo-area {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    /* Căn chỉnh kích thước khối đồ họa Logo SVG */
    .hce-logo-img {
        height: 75px;
        width: auto;
    }

    .hce-school-name {
        text-align: left;
    }

    .hce-name-vi {
        color: #b31f24;
        font-weight: bold;
        font-size: 20px;
        margin: 0;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }

    .hce-name-en {
        color: #333;
        font-size: 13px;
        margin: 4px 0 0 0;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 500;
    }

    .hce-search-site {
        display: flex;
        align-items: center;
        border-bottom: 1px solid #ccc;
        padding: 3px;
    }

    .hce-search-site input {
        border: none;
        outline: none;
        font-size: 13px;
        padding: 5px;
    }

    .hce-search-site i {
        color: #b31f24;
    }

    /* Thanh Menu màu đỏ thương hiệu HCE bao phủ toàn chiều ngang */
    .hce-nav-bar {
        background-color: #b31f24;
        padding: 0 8%;
        display: flex;
        list-style: none;
        margin: 0;
    }

    .hce-nav-bar li a {
        display: block;
        padding: 14px 18px;
        color: #ffffff;
        text-decoration: none;
        font-weight: bold;
        font-size: 13px;
        text-transform: uppercase;
        transition: background 0.3s;
    }

    .hce-nav-bar li a:hover {
        background-color: #921418;
    }

    .hce-nav-bar li a i {
        font-size: 10px;
        margin-left: 5px;
    }

    /* ================= CSS KHỐI BẢNG HIỂN THỊ SẢN PHẨM ================= */
    .container{
        max-width:1000px;
        margin: 40px auto;
        background:#fff;
        padding:30px;
        border-radius:15px;
        box-shadow:0 4px 15px rgba(0,0,0,0.1);
    }

    h2{
        text-align:center;
        color:#2c3e50;
        margin-bottom:25px;
    }

    .search-box{
        display:flex;
        justify-content:center;
        gap:10px;
        margin-bottom:25px;
    }

    .search-box input{
        width:350px;
        padding:12px 15px;
        border:1px solid #ccc;
        border-radius:8px;
        font-size:15px;
    }

    .search-box button{
        padding:12px 25px;
        border:none;
        border-radius:8px;
        background:#3498db;
        color:white;
        cursor:pointer;
        font-size:15px;
        transition:0.3s;
    }

    .search-box button:hover{
        background:#2980b9;
    }

    table{
        width:100%;
        border-collapse:collapse;
        overflow:hidden;
        border-radius:10px;
    }

    thead{
        background:#3498db;
        color:white;
    }

    th, td{
        padding:12px;
        text-align:center;
        border-bottom:1px solid #eee;
    }

    tbody tr:hover{
        background:#f8f9fa;
    }

    .price{
        color:#e74c3c;
        font-weight:bold;
    }
</style>
</head>
<body>

    <header>
        <div class="hce-top-header">
            <div class="hce-left-links">
                <a href="#" class="active">Trang chủ</a>
                <a href="#">Egov</a>
                <a href="#">Sinh viên</a>
            </div>
            
            <div class="hce-logo-area">
                <svg class="hce-logo-img" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
                    <rect x="25" y="25" width="150" height="150" rx="35" transform="rotate(45 100 100)" fill="none" stroke="#b31f24" stroke-width="10"/>
                    
                    <rect x="32" y="32" width="136" height="136" rx="28" transform="rotate(45 100 100)" fill="none" stroke="#b31f24" stroke-width="2"/>
                    
                    <path d="M 75,130 C 75,95 90,75 115,55 C 95,80 92,105 92,130 Z" fill="#b31f24"/>
                    <path d="M 95,130 C 95,100 105,85 128,70 C 112,90 110,110 110,130 Z" fill="#b31f24"/>
                    <path d="M 113,130 C 113,108 120,98 138,85 C 126,100 125,115 125,130 Z" fill="#b31f24"/>
                    
                    <path d="M 65,133 L 135,133" stroke="#b31f24" stroke-width="4" stroke-linecap="round"/>
                    
                    <text x="100" y="165" font-family="'Impact', 'Arial Black', sans-serif" font-size="24" font-weight="bold" fill="#b31f24" text-anchor="middle" letter-spacing="2">HCE</text>
                    
                    <path d="M 132,153 Q 140,155 145,151 M 134,158 Q 142,160 147,156 M 136,163 Q 144,165 149,161" stroke="#b31f24" stroke-width="2" fill="none" stroke-linecap="round"/>
                </svg>

                <div class="hce-school-name">
                    <h1 class="hce-name-vi">Trường Cao đẳng Kinh tế Thành phố Hồ Chí Minh</h1>
                    <p class="hce-name-en">Ho Chi Minh City College of Economics</p>
                </div>
            </div>
            
            <div class="hce-search-site">
                <input type="text" placeholder="Tìm kiếm...">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>
        </div>
        
        <ul class="hce-nav-bar">
            <li><a href="#">Giới thiệu <i class="fa-solid fa-chevron-down"></i></a></li>
            <li><a href="#">Tin tức - Sự kiện</a></li>
            <li><a href="#">Tuyển sinh <i class="fa-solid fa-chevron-down"></i></a></li>
            <li><a href="#">Công khai giáo dục <i class="fa-solid fa-chevron-down"></i></a></li>
            <li><a href="#">Cơ cấu tổ chức <i class="fa-solid fa-chevron-down"></i></a></li>
            <li><a href="#">Liên kết <i class="fa-solid fa-chevron-down"></i></a></li>
        </ul>
    </header>

    <div class="container">

        <h2>Northwind Products</h2>

        <form action="timsanpham" method="get" class="search-box">
            <input
                type="text"
                name="q"
                value="<%= keyword %>"
                placeholder="Nhập tên sản phẩm..."
            >
            <button type="submit">Tìm kiếm</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Tồn kho</th>
                </tr>
            </thead>

            <tbody>
            <%
                // Thực hiện lặp dữ liệu từ database đổ ra bảng HTML công thức Scriptlet
                if(listProduct != null && !listProduct.isEmpty()){
                    for(Product p : listProduct){
            %>
                <tr>
                    <td><%= p.getProductID() %></td>
                    <td><%= p.getProductName() %></td>
                    <td class="price">$<%= p.getUnitPrice() %></td>
                    <td><%= p.getUnitsInStock() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" style="color: #777; padding: 25px;">Không có dữ liệu sản phẩm nào khớp từ khóa!</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

    </div>

</body>
</html>