<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${user.id != null ? 'Sửa' : 'Thêm'} Khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm mx-auto" style="max-width: 600px;">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">${user.id != null ? 'Cập nhật thông tin' : 'Thêm người dùng mới'}</h4>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/customer-manage" method="post">
                    
                    <input type="hidden" name="id" value="${user.id}">

                    <div class="mb-3">
                        <label class="form-label">Tài khoản (Username)</label>
                        <input type="text" name="username" class="form-control" value="${user.username}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu</label>
                        <input type="text" name="password" class="form-control" value="${user.password}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" name="fullname" class="form-control" value="${user.fullname}" required>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" name="isAdmin" value="true" id="roleCheck" ${user.isAdmin ? 'checked' : ''}>
                        <label class="form-check-label" for="roleCheck">Là Quản trị viên (Admin)</label>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/customer-manage" class="btn btn-secondary">Quay lại</a>
                        <button type="submit" class="btn btn-primary">Lưu lại</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>