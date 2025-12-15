<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Danh sách khách hàng</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: Arial, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      padding: 40px 20px;
    }

    .container {
      max-width: 900px;
      margin: 0 auto;
      background: white;
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    }

    h1 {
      text-align: center;
      color: #333;
      margin-bottom: 30px;
      font-size: 32px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
    }

    thead {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
    }

    th {
      padding: 15px;
      text-align: left;
      font-weight: 600;
      font-size: 16px;
    }

    td {
      padding: 20px 15px;
      border-bottom: 1px solid #e0e0e0;
      vertical-align: middle;
    }

    tbody tr {
      transition: all 0.3s ease;
    }

    tbody tr:hover {
      background: #f5f5f5;
      transform: scale(1.01);
    }

    tbody tr:last-child td {
      border-bottom: none;
    }

    .customer-image {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      object-fit: cover;
      border: 3px solid #667eea;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .customer-name {
      font-weight: 600;
      color: #333;
      font-size: 16px;
    }

    .customer-date, .customer-address {
      color: #666;
      font-size: 14px;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Danh sách khách hàng</h1>

  <table>
    <thead>
    <tr>
      <th>Tên</th>
      <th>Ngày sinh</th>
      <th>Địa chỉ</th>
      <th>Ảnh</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="customer" items="${customers}">
      <tr>
        <td class="customer-name">${customer.name}</td>
        <td class="customer-date">${customer.birthDate}</td>
        <td class="customer-address">${customer.address}</td>
        <td>
          <img src="${customer.imageUrl}" alt="${customer.name}" class="customer-image">
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>