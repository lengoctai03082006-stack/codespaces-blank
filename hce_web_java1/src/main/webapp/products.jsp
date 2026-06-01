<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="dao.*"%>

<%
    // 1. Nhận danh sách sản phẩm từ Servlet gửi qua
    List<Product> listProduct = (List<Product>) request.getAttribute("listProduct");

    // 2. Dự phòng nếu chạy trực tiếp file JSP
    String keyword = request.getParameter("q");
    if(keyword == null) keyword = "";
    
    // Chuẩn hóa từ khóa tìm kiếm về chữ thường để so sánh không phân biệt hoa thường
    String searchKey = keyword.trim().toLowerCase();

    // 3. Nhận mã loại danh mục từ các tab nút bấm (?category=...)
    String selectedCat = request.getParameter("category");
    if(selectedCat == null) selectedCat = "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Green Eco-Market - Tìm Kiếm Thông Minh</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    *{ margin:0; padding:0; box-sizing:border-box; font-family: 'Segoe UI', sans-serif; }
    body{ background:#f3f7f4; padding: 0; }
    
    /* ================= COOKING GREEN ECO HEADER ================= */
    header { background-color: #fff; width: 100%; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
    .eco-top-header { display: flex; justify-content: space-between; align-items: center; padding: 15px 8%; }
    .eco-left-links { display: flex; gap: 20px; }
    .eco-left-links a { text-decoration: none; color: #666; font-weight: bold; font-size: 13px; text-transform: uppercase; }
    .eco-left-links a.active { color: #27ae60; }
    .eco-logo-area { display: flex; align-items: center; gap: 12px; }
    .eco-logo-img { height: 60px; width: auto; }
    .eco-brand-name { text-align: left; }
    .eco-name-main { color: #27ae60; font-weight: 800; font-size: 24px; text-transform: uppercase; }
    .eco-name-sub { color: #555; font-size: 12px; text-transform: uppercase; font-weight: 600; }
    .eco-search-site { display: flex; align-items: center; border-bottom: 2px solid #27ae60; }
    .eco-search-site input { border: none; outline: none; font-size: 13px; padding: 5px; background: transparent; }
    .eco-search-site i { color: #27ae60; }
    .eco-nav-bar { background-color: #1e7e34; padding: 0 8%; display: flex; list-style: none; }
    .eco-nav-bar li a { display: block; padding: 14px 20px; color: #ffffff; text-decoration: none; font-weight: bold; font-size: 13px; text-transform: uppercase; }

    /* ================= MAIN CONTAINER ================= */
    .container{ max-width:1100px; margin: 40px auto; background:#fff; padding:30px; border-radius:15px; box-shadow:0 4px 20px rgba(0,0,0,0.05); border-top: 5px solid #27ae60; }
    h2 { text-align: center; color: #2c3e50; font-size: 26px; }
    .sub-title { text-align: center; color: #7f8c8d; margin-bottom: 25px; font-size: 14px; }
    
    /* ================= TABS DANH MỤC ================= */
    .category-tabs { display: flex; justify-content: center; flex-wrap: wrap; gap: 15px; margin-bottom: 30px; background: #f8fbf9; padding: 20px; border-radius: 12px; }
    .tab-item { display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; background: #ffffff; color: #444; text-decoration: none; border-radius: 30px; font-weight: 600; font-size: 14px; border: 1px solid #ddd; transition: all 0.3s; }
    .tab-item:hover { border-color: #27ae60; color: #27ae60; background: #f0fbf5; }
    .tab-item.active { background: #27ae60; color: #ffffff; border-color: #27ae60; box-shadow: 0 4px 12px rgba(39,174,96,0.25); }

    /* ================= THANH TÌM KIẾM ================= */
    .search-box{ display:flex; justify-content:center; gap:10px; margin-bottom:30px; }
    .search-box input{ width:450px; padding:12px 15px; border:2px solid #e0e0e0; border-radius:8px; font-size:15px; }
    .search-box input:focus { border-color: #27ae60; outline: none; }
    .search-box button{ padding:12px 30px; border:none; border-radius:8px; background:#27ae60; color:white; cursor:pointer; font-size:15px; font-weight: bold; }

    /* ================= BẢNG DỮ LIỆU ================= */
    table{ width:100%; border-collapse:collapse; overflow:hidden; border-radius:10px; }
    thead{ background:#27ae60; color:white; }
    th, td{ padding:15px; text-align:center; border-bottom:1px solid #f1f1f1; }
    th { font-weight: 600; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
    tbody tr:hover{ background:#f9fbf9; }
    .price{ color:#e74c3c; font-weight:bold; }
    .badge-stock { background: #e8f8f0; color: #27ae60; padding: 4px 12px; border-radius: 20px; font-size: 13px; font-weight: 600; }
    .badge-category { background: #f1f2f6; color: #57606f; padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: bold; }
</style>
</head>
<body>

    <header>
        <div class="eco-top-header">
            <div class="eco-left-links">
                <a href="timsanpham" class="active">Hệ thống tổng</a>
                <a href="#">Báo cáo tồn kho</a>
                <a href="#">Đối tác cung ứng</a>
            </div>
            <div class="eco-logo-area">
                <svg class="eco-logo-img" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="50" cy="50" r="45" fill="#e8f8f0"/>
                    <path d="M50,20 C65,35 70,55 50,80 C30,55 35,35 50,20 Z" fill="#27ae60"/>
                    <path d="M50,20 C58,35 55,55 50,80 Z" fill="#219653"/>
                    <path d="M50,35 Q55,45 62,42 M50,50 Q57,60 65,55 M50,45 Q43,52 38,48 M50,60 Q43,68 35,62" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round"/>
                </svg>
                <div class="eco-brand-name">
                    <h1 class="eco-name-main">Green Eco-Market</h1>
                    <p class="eco-name-sub">Hệ thống tổng kho thực phẩm sạch</p>
                </div>
            </div>
            <div class="eco-search-site">
                <input type="text" placeholder="Tìm kiếm nhanh...">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>
        </div>
        <ul class="eco-nav-bar">
            <li><a href="timsanpham">Trang chủ dữ liệu</a></li>
            <li><a href="#">Quản lý xuất nhập kho</a></li>
            <li><a href="#">Cấu hình hệ thống</a></li>
        </ul>
    </header>

    <div class="container">
        <h2>Bảng Kiểm Kê Hàng Hóa Nông Sản</h2>
        <p class="sub-title">Mẹo: Gõ "trà", "trái cây", hoặc "gia vị" để liệt kê nhanh nhóm mặt hàng mong muốn!</p>

        <div class="category-tabs">
            <a href="timsanpham" class="tab-item <%= selectedCat.isEmpty() ? "active" : "" %>">
                <i class="fa-solid fa-boxes-stacked"></i> Tất cả sản phẩm
            </a>
            <a href="timsanpham?category=tra" class="tab-item <%= selectedCat.equals("tra") ? "active" : "" %>">
                <i class="fa-solid fa-mug-hot"></i> Nhóm: Trà & Đồ uống
            </a>
            <a href="timsanpham?category=traicay" class="tab-item <%= selectedCat.equals("traicay") ? "active" : "" %>">
                <i class="fa-solid fa-apple-whole"></i> Nhóm: Trái cây & Quả sấy
            </a>
            <a href="timsanpham?category=giavi" class="tab-item <%= selectedCat.equals("giavi") ? "active" : "" %>">
                <i class="fa-solid fa-pepper-hot"></i> Nhóm: Gia vị & Sốt
            </a>
        </div>

        <form action="timsanpham" method="get" class="search-box">
            <% if(!selectedCat.isEmpty()) { %>
                <input type="hidden" name="category" value="<%= selectedCat %>">
            <% } %>
            <input type="text" name="q" value="<%= keyword %>" placeholder="Gõ từ khóa (Ví dụ: trà, trái cây, dâu tây, sốt...)">
            <button type="submit">Lọc dữ liệu</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th style="width: 12%;">Mã số</th>
                    <th style="text-align: left; padding-left: 20px;">Tên mặt hàng nông sản</th>
                    <th style="width: 20%;">Phân loại nhóm</th>
                    <th style="width: 15%;">Giá niêm yết</th>
                    <th style="width: 18%;">Tồn kho hiện tại</th>
                </tr>
            </thead>
            <tbody>
            <%
                int countRender = 0; // Biến đếm số hàng được xuất ra màn hình
                
                if(listProduct != null && !listProduct.isEmpty()){
                    for(Product p : listProduct){
                        
                        String nameOrig = p.getProductName() != null ? p.getProductName() : "";
                        String nameVn = nameOrig;
                        String nhomSp = ""; 
                        String keyNhom = ""; 
                        
                        // ================= KHU VỰC PHÂN LOẠI CHI TIẾT - ĐÃ XOÁ HẾT LẶP TÁO =================
                        if(p.getProductID() == 1 || nameOrig.equalsIgnoreCase("Chai")) {
                            nameVn = "Trà thảo mộc đóng chai"; nhomSp = "Trà / Đồ uống"; keyNhom = "tra";
                        } else if(p.getProductID() == 2 || nameOrig.equalsIgnoreCase("Chang")) {
                            nameVn = "Bưởi da xanh Bến Tre"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 3 || nameOrig.equalsIgnoreCase("Aniseed Syrup")) {
                            nameVn = "Siro Atiso đỏ Đà Lạt"; nhomSp = "Trà / Đồ uống"; keyNhom = "tra";
                        } else if(p.getProductID() == 4 || nameOrig.equalsIgnoreCase("Chef Anton's Cajun Seasoning")) {
                            nameVn = "Bột gia vị hạt điều"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 5 || nameOrig.equalsIgnoreCase("Chef Anton's Gumbo Mix")) {
                            nameVn = "Gói gia vị lẩu nấm Tây Bắc"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 6 || nameOrig.equalsIgnoreCase("Grandma's Boysenberry Spread")) {
                            nameVn = "Mứt dâu tây Tây Nguyên"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 7 || nameOrig.equalsIgnoreCase("Uncle Bob's Organic Dried Pears")) {
                            nameVn = "Lê hữu cơ sấy khô vỉ"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 8 || nameOrig.equalsIgnoreCase("Northwoods Cranberry Sauce")) {
                            nameVn = "Sốt việt quất tươi nguyên bông"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 9 || nameOrig.equalsIgnoreCase("Mishi Kobe Niku")) {
                            nameVn = "Trà xanh Thái Nguyên thượng hạng"; nhomSp = "Trà / Đồ uống"; keyNhom = "tra";
                        } else if(p.getProductID() == 10 || nameOrig.equalsIgnoreCase("Ikura")) {
                            nameVn = "Trà Ô Long tôm nõn hảo hạng"; nhomSp = "Trà / Đồ uống"; keyNhom = "tra";
                        } 
                        // ----- THÊM MỚI SẢN PHẨM PHONG PHÚ TỪ ID #11 ĐẾN #30+ -----
                        else if(p.getProductID() == 11 || nameOrig.contains("Queso Cabrales")) {
                            nameVn = "Sốt bơ phô mai lắc vị cay"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 12 || nameOrig.contains("Queso Manchego")) {
                            nameVn = "Tương đen sánh quyện cốt đặc"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 13 || nameOrig.contains("Konbu")) {
                            nameVn = "Rong biển cuộn sấy giòn ăn liền"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 14 || nameOrig.contains("Tofu")) {
                            nameVn = "Đậu nành sấy muối tỏi ớt"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 15 || nameOrig.contains("Genen Shooyu")) {
                            nameVn = "Nước sốt tương đậu nành hữu cơ"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 16 || nameOrig.contains("Pavlova")) {
                            nameVn = "Chuối ngự sấy dẻo bánh tráng"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 17 || nameOrig.contains("Alice Mutton")) {
                            nameVn = "Khô thịt trâu hun khói gác bếp"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 18 || nameOrig.contains("Carnarvon Tigers")) {
                            nameVn = "Tôm nõn khô đất mũi Cà Mau"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 19 || nameOrig.contains("Teatime Chocolate Biscuits")) {
                            nameVn = "Trà hoa cúc mật ong túi lọc"; nhomSp = "Trà / Đồ uống"; keyNhom = "tra";
                        } else if(p.getProductID() == 20 || nameOrig.contains("Sir Rodney's Marmalade")) {
                            nameVn = "Mứt cam sành bóc vỏ"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 21 || nameOrig.contains("Sir Rodney's Scones")) {
                            nameVn = "Hạt điều rang củi vỏ lụa"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 22 || nameOrig.contains("Gustaf's Knäckebröd")) {
                            nameVn = "Mít tố nữ sấy giòn nguyên cánh"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 23 || nameOrig.contains("Tunnbröd")) {
                            nameVn = "Khoai lang mật sấy sợi giòn"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 24 || nameOrig.contains("Guaraná Fantástica")) {
                            nameVn = "Nước cốt chanh dây nguyên chất"; nhomSp = "Trà / Đồ uống"; keyNhom = "tra";
                        } else if(p.getProductID() == 25 || nameOrig.contains("NuNuCa Nuß-Nougat-Creme")) {
                            nameVn = "Sốt bơ đậu phộng hạt ca cao"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 26 || nameOrig.contains("Gumbär Chioki-St")) {
                            nameVn = "Xoài cát chu sấy dẻo xuất khẩu"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else if(p.getProductID() == 27 || nameOrig.contains("Schoggi Schokolade")) {
                            nameVn = "Bột Cacao Đắk Lắk nguyên chất"; nhomSp = "Trà / Đồ uống"; keyNhom = "tra";
                        } else if(p.getProductID() == 28 || nameOrig.contains("Rössle Sauerkraut")) {
                            nameVn = "Củ kiệu chua ngọt ngâm tỏi ớt"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 29 || nameOrig.contains("Thüringer Rostbratwurst")) {
                            nameVn = "Gia vị tiêu rừng ướp thịt nướng"; nhomSp = "Gia vị / Sốt"; keyNhom = "giavi";
                        } else if(p.getProductID() == 30 || nameOrig.contains("Nord-Ost Matjeshering")) {
                            nameVn = "Cá cơm ngần rim tỏi ớt cay"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        } else {
                            // Nhánh cuối cho các ID lớn hơn nữa (Nếu có)
                            nameVn = "Nông sản sấy khô cao cấp Eco"; nhomSp = "Trái cây / Quả sấy"; keyNhom = "traicay";
                        }

                        // TRÌNH TÌM KIẾM THÔNG MINH (LOGIC CHÍNH):
                        // Điều kiện 1: Lọc theo Tab Danh mục đang click chọn (nếu có)
                        if (!selectedCat.isEmpty() && !selectedCat.equalsIgnoreCase(keyNhom)) {
                            continue; 
                        }
                        
                        // Điều kiện 2: Kiểm tra từ khóa nhập vào ô Search
                        if (!searchKey.isEmpty()) {
                            // Chuyển tên sản phẩm và tên nhóm về chữ thường
                            String nameLower = nameVn.toLowerCase();
                            String nhomLower = nhomSp.toLowerCase();
                            
                            // Nếu từ khóa KHÔNG nằm trong tên sản phẩm VÀ KHÔNG nằm trong tên nhóm hàng -> Bỏ qua dòng này
                            if (!nameLower.contains(searchKey) && !nhomLower.contains(searchKey)) {
                                continue;
                            }
                        }
                        
                        countRender++; // Tăng biến đếm khi tìm thấy dòng phù hợp
            %>
                <tr>
                    <td><strong>#<%= p.getProductID() %></strong></td>
                    <td style="text-align: left; padding-left: 20px;"><%= nameVn %></td>
                    <td><span class="badge-category"><%= nhomSp %></span></td>
                    <td class="price">$<%= p.getUnitPrice() %></td>
                    <td><span class="badge-stock"><%= p.getUnitsInStock() %> sản phẩm</span></td>
                </tr>
            <%
                    }
                }
                
                // Hiển thị thông báo khi không tìm thấy kết quả nào trùng khớp
                if(countRender == 0){
            %>
                <tr>
                    <td colspan="5" style="color: #7f8c8d; padding: 40px; font-weight: 500;">
                        <i class="fa-solid fa-magnifying-glass-minus" style="color: #cbd5e1; font-size: 28px; margin-bottom: 10px; display:block;"></i>
                        Không tìm thấy mặt hàng nào khớp với từ khóa "<strong><%= keyword %></strong>"!
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