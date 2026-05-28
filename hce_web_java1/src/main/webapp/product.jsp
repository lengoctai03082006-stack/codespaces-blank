<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.ProductServlet.Product" %>
<html>
<head>
    <title>Hệ Thống Tìm Kiếm Linh Kiện Máy Tính</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 40px;
            background-color: #f3f4f6;
        }
        .container {
            max-width: 950px;
            margin: 0 auto;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        h2 {
            color: #1f2937;
            text-align: center;
            margin-bottom: 8px;
        }
        .subtitle {
            text-align: center;
            color: #6b7280;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .search-form {
            display: flex;
            gap: 12px;
            margin-bottom: 25px;
        }
        .search-form input[type="text"] {
            flex: 1;
            padding: 14px;
            font-size: 15px;
            border: 2px solid #e5e7eb;
            border-radius: 6px;
            outline: none;
        }
        .search-form input[type="text"]:focus { border-color: #3b82f6; }
        .search-form button {
            padding: 14px 30px;
            font-size: 15px;
            background-color: #2563eb;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }
        .search-form button:hover { background-color: #1d4ed8; }
        .btn-all {
            padding: 14px 22px;
            background-color: #4b5563;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            line-height: 20px;
            text-align: center;
        }
        .btn-all:hover { background-color: #374151; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 12px 14px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
            vertical-align: middle;
        }
        th {
            background-color: #f8fafc;
            color: #475569;
            font-weight: 600;
        }
        tr:hover { background-color: #f8fafc; }
        .badge {
            background-color: #dbeafe;
            color: #1e40af;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .product-img {
            width: 65px;
            height: 65px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .no-data {
            text-align: center;
            color: #ef4444;
            font-style: italic;
            padding: 40px;
            font-size: 16px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>DANH SÁCH LINH KIỆN MÁY TÍNH</h2>
    <div class="subtitle">Gợi ý tìm kiếm loại: Chuột, Màn hình, Bàn phím, Tai nghe, Ổ cứng</div>

    <form action="<%= request.getContextPath() %>/products" method="get" class="search-form">
        <input type="text" name="search" placeholder="Nhập loại sản phẩm (ví dụ: chuột) hoặc tên linh kiện cần tìm..." 
               value="<%= request.getAttribute("tuKhoa") != null ? request.getAttribute("tuKhoa") : "" %>">
        <button type="submit">Tìm kiếm</button>
        <a href="<%= request.getContextPath() %>/products" class="btn-all">Xem tất cả</a>
    </form>

    <table>
        <thead>
            <tr>
                <th style="width: 12%">Mã SP</th>
                <th style="width: 15%">Hình Ảnh</th>
                <th style="width: 15%">Phân Loại</th>
                <th style="width: 43%">Tên Chi Tiết Sản Phẩm</th>
                <th style="width: 15%">Giá Bán</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Product> productList = (List<Product>) request.getAttribute("dsSanPham");
                if (productList != null && !productList.isEmpty()) {
                    for (Product p : productList) {
            %>
                        <tr>
                            <td><code><%= p.getId() %></code></td>
                            <td>
                                <img src="<%= p.getImageUrl() %>" 
                                     alt="<%= p.getName() %>" 
                                     class="product-img" 
                                     onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=100&auto=format&fit=crop&q=60';">
                            </td>
                            <td><span class="badge"><%= p.getCategory() %></span></td>
                            <td><b><%= p.getName() %></b></td>
                            <td style="color: #059669; font-weight: bold;"><%= String.format("%,d", (int) p.getPrice()) %> VNĐ</td>
                        </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="5" class="no-data">❌ Không tìm thấy linh kiện nào khớp với từ khóa tìm kiếm!</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>