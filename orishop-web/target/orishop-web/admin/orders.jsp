<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; }
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; }
        .sidebar a { color: #adb5bd; text-decoration: none; padding: 15px; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; }
        .content { padding: 20px; background-color: #f8f9fa; flex-grow: 1; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 sidebar p-0">
                <h4 class="text-center py-3 border-bottom border-secondary">ADMIN CP</h4>
                <a href="${pageContext.request.contextPath}/admin"><i class="fa-solid fa-box me-2"></i> Quản lý Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/customer-manage"><i class="fa-solid fa-users me-2"></i> Quản lý Khách hàng</a>
                <a href="#" class="active"><i class="fa-solid fa-file-invoice me-2"></i> Đơn hàng</a>
                <a href="${pageContext.request.contextPath}/home" class="mt-5 text-warning"><i class="fa-solid fa-arrow-left me-2"></i> Về trang chủ</a>
            </div>

            <div class="col-md-10 content">
                <h2 class="mb-4">Danh sách đơn hàng</h2>
                <div class="card shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã ĐH</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <td>#${o.id}</td>
                                        <td>
                                            <strong>${o.fullname}</strong><br>
                                            <small class="text-muted">${o.phone}</small>
                                        </td>
                                        <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td class="text-danger fw-bold">
                                            <fmt:setLocale value="vi_VN"/>
                                            <fmt:formatNumber value="${o.totalMoney}" type="currency"/>
                                        </td>
                                        <td>
                                            <span class="badge ${o.status == 'Đang xử lý' ? 'bg-warning text-dark' : (o.status == 'Đã giao' ? 'bg-success' : 'bg-danger')}">
                                                ${o.status}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/order-manage?action=detail&id=${o.id}" class="btn btn-info btn-sm text-white">
                                                <i class="fa-solid fa-eye"></i> Xem
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>