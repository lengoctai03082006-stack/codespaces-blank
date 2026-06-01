<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>KM to Miles</title>
</head>
<body>

<h2>Convert KM to Miles</h2>

<form action="<%= request.getContextPath() %>/chuyendoi" method="post">
    Enter KM:
    <input type="text" name="km">

    <button type="submit">Convert</button>
</form>

<%
    Object result = request.getAttribute("result");

    if(result != null){
%>

    <h3>Result: <%= result %> miles</h3>

<%
    }
%>

</body>
</html>