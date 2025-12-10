<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Discount Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h2 {
            color: #4CAF50;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
            width: 45%;
        }
        td {
            background-color: white;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .highlight {
            background-color: #e8f5e9 !important;
            font-weight: bold;
            font-size: 1.1em;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            text-align: center;
        }
        .back-link:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>✓ Discount Calculation Result</h2>

    <table>
        <tr>
            <th>Product Description:</th>
            <td>${requestScope.description}</td>
        </tr>
        <tr>
            <th>List Price:</th>
            <td>${requestScope.listPrice}</td>
        </tr>
        <tr>
            <th>Discount Percent:</th>
            <td>${requestScope.discountPercent}%</td>
        </tr>
        <tr>
            <th>Discount Amount:</th>
            <td>${requestScope.discountAmount}</td>
        </tr>
        <tr>
            <th>Final Price:</th>
            <td class="highlight">${requestScope.discountPrice}</td>
        </tr>
    </table>

    <a href="index.jsp" class="back-link">← Calculate Another Product</a>
</div>
</body>
</html>