<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>

<%
    ProductDAO dao = new ProductDAO();
    List<Product> listProduct = dao.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product List</title>
</head>
<body>

<h2>Northwind Products</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Stock</th>
    </tr>

    <%
        if (listProduct != null) {
            for (Product p : listProduct) {
    %>
    <tr>
        <td><%= p.getProductID() %></td>
        <td><%= p.getProductName() %></td>
        <td><%= p.getUnitPrice() %></td>
        <td><%= p.getUnitsInStock() %></td>
    </tr>
    <%
            }
        }
    %>

</table>

</body>
</html>