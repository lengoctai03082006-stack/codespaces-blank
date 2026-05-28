<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello World JSP</title>
</head>
<body>

    <h1>Hello World!</h1>
    <p>Hệ thống Java Web của bạn đã chạy thành công trên Codespaces.</p>
    
    <%
        // Đoạn code Java nhỏ để hiển thị thời gian hiện tại của hệ thống
        java.util.Date date = new java.util.Date();
    %>
    <p>Thời gian hiện tại trên Server: <b><%= date %></b></p>

</body>
</html>