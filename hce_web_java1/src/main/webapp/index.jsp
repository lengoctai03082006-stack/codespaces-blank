<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="dao.*"%>

<%
    List<Product> listProduct =
            (List<Product>) request.getAttribute("listProduct");

    String keyword = request.getParameter("q");
    if(keyword == null){
        
        ProductDAO dao = new ProductDAO();
        listProduct=dao.getAllProducts();
        keyword = "";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Northwind Products</title>

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body{
        background:#f4f6f9;
        padding:40px;
    }

    .container{
        max-width:1000px;
        margin:auto;
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

<div class="container">

    <h2>Northwind Products</h2>

    <form action="timsanpham" method="post" class="search-box">
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
            if(listProduct != null){
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
            }
        %>
        </tbody>
    </table>

</div>

</body>
</html>