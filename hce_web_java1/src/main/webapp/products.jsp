<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="dao.*"%>

<%
    // Nhận danh sách sản phẩm được chuyển tiếp an toàn từ Servlet
    List<Product> listProduct = (List<Product>) request.getAttribute("listProduct");

    // Đồng bộ hóa từ khóa tìm kiếm "q" để giữ lại nội dung trên thanh nhập liệu
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
<title>Northwind Eco-Market Management</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body{
        background:#f0f4f1; /* Nền xám xanh dịu mắt chủ đề nông sản */
        padding: 0; 
    }

    /* ================= GIAO DIỆN HEADER GREEN ECO-MARKET ================= */
    header {
        background-color: #fff;
        width: 100%;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    }

    .eco-top-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 8%;
        background-color: #ffffff;
    }

    .eco-left-links {
        display: flex;
        gap: 20px;
    }

    .eco-left-links a {
        text-decoration: none;
        color: #666;
        font-weight: bold;
        font-size: 13px;
        text-transform: uppercase;
    }

    .eco-left-links a.active {
        color: #27ae60; /* Đổi sang màu xanh lá chủ đạo */
    }

    .eco-logo-area {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    /* Căn chỉnh kích thước khối đồ họa Logo SVG mới */
    .eco-logo-img {
        height: 65px;
        width: auto;
    }

    .eco-brand-name {
        text-align: left;
    }

    .eco-name-main {
        color: #27ae60; /* Màu xanh hệ thống thực phẩm sạch */
        font-weight: 800;
        font-size: 22px;
        margin: 0;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .eco-name-sub {
        color: #555;
        font-size: 12px;
        margin: 2px 0 0 0;
        text-transform: uppercase;
        letter-spacing: 1px;
        font-weight: 600;
    }

    .eco-search-site {
        display: flex;
        align-items: center;
        border-bottom: 2px solid #27ae60;
        padding: 3px;
    }

    .eco-search-site input {
        border: none;
        outline: none;
        font-size: 13px;
        padding: 5px;
        background: transparent;
    }

    .eco-search-site i {
        color: #27ae60;
    }

    /* Thanh Menu màu xanh lá cây đậm sang trọng */
    .eco-nav-bar {
        background-color: #1e7e34;
        padding: 0 8%;
        display: flex;
        list-style: none;
        margin: 0;
    }

    .eco-nav-bar li a {
        display: block;
        padding: 14px 20px;
        color: #ffffff;
        text-decoration: none;
        font-weight: bold;
        font-size: 13px;
        text-transform: uppercase;
        transition: background 0.3s;
    }

    .eco-nav-bar li a:hover {
        background-color: #155d24;
    }

    .eco-nav-bar li a i {
        font-size: 10px;
        margin-left: 5px;
    }

    /* ================= CSS KHỐI BẢNG SẢN PHẨM ================= */
    .container{
        max-width:1000px;
        margin: 40px auto;
        background:#fff;
        padding:30px;
        border-radius:15px;
        box-shadow:0 4px 20px rgba(0,0,0,0.05);
        border-top: 4px solid #27ae60; /* Vạch xanh định hình khối */
    }

    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 5px;
        font-size: 24px;
    }

    .sub-title {
        text-align: center;
        color: #7f8c8d;
        margin-bottom: 25px;
        font-size: 14px;
    }

    .search-box{
        display:flex;
        justify-content:center;
        gap:10px;
        margin-bottom:25px;
    }

    .search-box input{
        width:380px;
        padding:12px 15px;
        border:2px solid #e0e0e0;
        border-radius:8px;
        font-size:15px;
        transition: 0.3s;
    }

    .search-box input:focus {
        border-color: #27ae60;
        outline: none;
    }

    .search-box button{
        padding:12px 30px;
        border:none;
        border-radius:8px;
        background:#27ae60;
        color:white;
        cursor:pointer;
        font-size:15px;
        font-weight: bold;
        transition:0.3s;
    }

    .search-box button:hover{
        background:#219653;
    }

    table{
        width:100%;
        border-collapse:collapse;
        overflow:hidden;
        border-radius:10px;
    }

    thead{
        background:#27ae60;
        color:white;
    }

    th, td{
        padding:14px;
        text-align:center;
        border-bottom:1px solid #f1f1f1;
    }

    th {
        font-weight: 600;
        text-transform: uppercase;
        font-size: 13px;
        letter-spacing: 0.5px;
    }

    tbody tr:hover{
        background:#f9fbf9;
    }

    .price{
        color:#e74c3c;
        font-weight:bold;
    }

    .badge-stock {
        background: #e8f8f0;
        color: #27ae60;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
    }
</style>
</head>
<body>

    <header>
        <div class="eco-top-header">
            <div class="eco-left-links">
                <a href="#" class="active">Hệ thống tổng</a>
                <a href="#">Báo cáo kho</a>
                <a href="#">Nhân viên</a>
            </div>
            
            <div class="eco-logo-area">
                <svg class="eco-logo-img" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="50" cy="50" r="45" fill="#e8f8f0"/>
                    <path d="M50,20 C65,35 70,55 50,80 C30,55 35,35 50,20 Z" fill="#27ae60"/>
                    <path d="M50,20 C58,35 55,55 50,80 Z" fill="#219653"/>
                    <path d="M50,35 Q55,45 62,42 M50,50 Q57,60 65,55 M50,45 Q43,52 38,48 M50,60 Q43,68 35,62" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round"/>
                </svg>

                <div class="eco-brand-name">
                    <h1 class="eco-name-main">Northwind Eco-Market</h1>
                    <p class="eco-name-sub">Hệ thống quản lý chuỗi nông sản sạch</p>
                </div>
            </div>
            
            <div class="eco-search-site">
                <input type="text" placeholder="Tra cứu nhanh...">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>
        </div>
        
        <ul class="eco-nav-bar">
            <li><a href="#">Danh mục kho <i class="fa-solid fa-chevron-down"></i></a></li>
            <li><a href="#">Trái cây & Rau củ</a></li>
            <li><a href="#">Thực phẩm tươi sống <i class="fa-solid fa-chevron-down"></i></a></li>
            <li><a href="#">Hàng tiêu dùng bách hóa</a></li>
            <li><a href="#">Nhập kho / Xuất kho</a></li>
            <li><a href="#">Nhà cung ứng <i class="fa-solid fa-chevron-down"></i></a></li>
        </ul>
    </header>

    <div class="container">

        <h2>Bảng Kiểm Kê Hàng Hóa Nông Sản</h2>
        <p class="sub-title">Dữ liệu kết nối trực tiếp cơ sở dữ liệu hệ thống kho hàng Northwind</p>

        <form action="timsanpham" method="get" class="search-box">
            <input
                type="text"
                name="q"
                value="<%= keyword %>"
                placeholder="Tìm mặt hàng bằng tên sản phẩm..."
            >
            <button type="submit">Lọc dữ liệu</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th style="width: 10%;">Mã mặt hàng</th>
                    <th style="text-align: left; padding-left: 20px;">Tên sản phẩm nông sản</th>
                    <th style="width: 20%;">Giá niêm yết</th>
                    <th style="width: 20%;">Số lượng tồn kho</th>
                </tr>
            </thead>

            <tbody>
            <%
                if(listProduct != null && !listProduct.isEmpty()){
                    for(Product p : listProduct){
            %>
                <tr>
                    <td><strong>#<%= p.getProductID() %></strong></td>
                    <td style="text-align: left; padding-left: 20px;"><%= p.getProductName() %></td>
                    <td class="price">$<%= p.getUnitPrice() %></td>
                    <td><span class="badge-stock"><%= p.getUnitsInStock() %> sản phẩm</span></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" style="color: #7f8c8d; padding: 30px; font-weight: 500;">
                        <i class="fa-solid fa-triangle-exclamation" style="color: #f39c12; margin-right: 8px;"></i>
                        Không tìm thấy mặt hàng nông sản nào khớp với từ khóa tìm kiếm của bạn!
                    </td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

    </div>

</body>
</html>