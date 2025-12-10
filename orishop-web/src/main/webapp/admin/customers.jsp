<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khách hàng - Orishop</title>
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
                <a href="#" class="active"><i class="fa-solid fa-users me-2"></i> Quản lý Khách hàng</a>
                <a href="#"><i class="fa-solid fa-file-invoice me-2"></i> Đơn hàng</a>
                <a href="${pageContext.request.contextPath}/home" class="mt-5 text-warning"><i class="fa-solid fa-arrow-left me-2"></i> Về trang chủ</a>
            </div>

            <div class="col-md-10 content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Danh sách người dùng</h2>
                    <a href="${pageContext.request.contextPath}/customer-manage?action=create" class="btn btn-success">
                        <i class="fa-solid fa-user-plus"></i> Thêm người dùng
                    </a>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Tài khoản</th>
                                    <th>Họ và tên</th>
                                    <th>Vai trò</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customers}" var="u">
                                    <tr>
                                        <td>#${u.id}</td>
                                        <td class="fw-bold">${u.username}</td>
                                        <td>${u.fullname}</td>
                                        <td>
                                            <c:if test="${u.isAdmin}">
                                                <span class="badge bg-danger">Admin</span>
                                            </c:if>
                                            <c:if test="${!u.isAdmin}">
                                                <span class="badge bg-primary">Khách hàng</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/customer-manage?action=edit&id=${u.id}" class="btn btn-primary btn-sm me-1">
                                                <i class="fa-solid fa-pen"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/customer-manage?action=delete&id=${u.id}" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Xóa người dùng này?');">
                                                <i class="fa-solid fa-trash"></i> Xóa
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