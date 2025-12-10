<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Discount Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            background-color: #ffe6e6;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            border: 1px solid #ffcccc;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Product Discount Calculator</h2>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% if (request.getAttribute("error") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <%-- Form gửi dữ liệu bằng POST - Sử dụng relative URL --%>
    <form method="POST" action="display-discount">
        <label for="description">Product Description:</label>
        <input type="text"
               id="description"
               name="description"
               value="<%= request.getAttribute("description") != null ? request.getAttribute("description") : "" %>"
               required>

        <label for="price">List Price ($):</label>
        <input type="text"
               id="price"
               name="price"
               placeholder="e.g., 100.00"
               value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : "" %>"
               required>

        <label for="discount_percent">Discount Percent (%):</label>
        <input type="text"
               id="discount_percent"
               name="discount_percent"
               placeholder="e.g., 15"
               value="<%= request.getAttribute("discount_percent") != null ? request.getAttribute("discount_percent") : "" %>"
               required>

        <input type="submit" value="Calculate Discount">
    </form>
</div>
</body>
</html>