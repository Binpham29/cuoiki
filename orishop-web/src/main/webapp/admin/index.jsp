<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Trị - Orishop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; }
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; }
        .sidebar a { color: #adb5bd; text-decoration: none; padding: 15px; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; }
        .content { padding: 20px; background-color: #f8f9fa; flex-grow: 1; }
        .img-thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 5px; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            
            <div class="col-md-2 sidebar p-0 d-flex flex-column">
                <h4 class="text-center py-3 border-bottom border-secondary">ADMIN</h4>
                
                <div class="text-center py-3 border-bottom border-secondary bg-secondary text-white">
                    <small>Xin chào,</small><br>
                    <strong>${sessionScope.currentUser.fullname}</strong>
                </div>

                <a href="${pageContext.request.contextPath}/admin" class="active"><i class="fa-solid fa-box me-2"></i> Quản lý Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/customer-manage"><i class="fa-solid fa-users me-2"></i> Quản lý Khách hàng</a>
                
                <a href="${pageContext.request.contextPath}/order-manage"><i class="fa-solid fa-file-invoice me-2"></i> Đơn hàng</a>
                
                <a href="${pageContext.request.contextPath}/home" class="mt-5 text-warning"><i class="fa-solid fa-arrow-left me-2"></i> Về trang chủ</a>
                
                <a href="${pageContext.request.contextPath}/logout" class="text-danger mt-auto border-top border-secondary">
                    <i class="fa-solid fa-power-off me-2"></i> Đăng xuất
                </a>
            </div>

            <div class="col-md-10 content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Danh sách sản phẩm</h2>
                    
                    <a href="${pageContext.request.contextPath}/product-manage?action=create" class="btn btn-success">
                        <i class="fa-solid fa-plus"></i> Thêm mới
                    </a>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Hình ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá tiền</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${products}" var="p">
                                    <tr>
                                        <td>#${p.id}</td>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/image?fname=${p.image}" 
                                                 class="img-thumb" 
                                                 alt="${p.name}">
                                        </td>
                                        <td class="fw-bold">${p.name}</td>
                                        <td class="text-danger">
                                            <fmt:setLocale value="vi_VN"/>
                                            <fmt:formatNumber value="${p.price}" type="currency"/>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/product-manage?action=edit&id=${p.id}" class="btn btn-primary btn-sm me-1">
                                                <i class="fa-solid fa-pen"></i> Sửa
                                            </a>
                                            
                                            <a href="${pageContext.request.contextPath}/product-manage?action=delete&id=${p.id}" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm: ${p.name}?');">
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

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var images = document.querySelectorAll('.img-thumb');
            images.forEach(function(img) {
                img.onerror = function() {
                    this.onerror = null;
                    this.src = 'https://placehold.co/50?text=Error'; 
                };
            });
        });
    </script>
</body>
</html>