<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.id != null ? 'Chỉnh sửa' : 'Thêm mới'} Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm mx-auto" style="max-width: 600px;">
            <div class="card-header bg-dark text-white">
                <h4 class="mb-0">${product.id != null ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm mới'}</h4>
            </div>
            <div class="card-body">
                
                <form action="${pageContext.request.contextPath}/product-manage" method="post" enctype="multipart/form-data">
                    
                    <input type="hidden" name="id" value="${product.id}">
                    <input type="hidden" name="currentImage" value="${product.image}">

                    <div class="mb-3">
                        <label class="form-label">Tên sản phẩm</label>
                        <input type="text" name="name" class="form-control" value="${product.name}" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Giá gốc (VNĐ)</label>
                                <input type="number" name="price" class="form-control" value="${product.price}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Giảm giá (%)</label>
                                <input type="number" name="discount" class="form-control" value="${product.discount}" min="0" max="100" placeholder="0">
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Danh mục</label>
                        <select name="category" class="form-select">
                            <option value="Technology" ${product.category == 'Technology' ? 'selected' : ''}>Công nghệ</option>
                            <option value="Cosmetics" ${product.category == 'Cosmetics' ? 'selected' : ''}>Mỹ phẩm</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Hình ảnh</label>
                        <input type="file" name="imageFile" class="form-control" accept="image/*">
                        
                        <c:if test="${not empty product.image}">
                            <div class="mt-2">
                                <small>Ảnh hiện tại:</small><br>
                                <img src="${pageContext.request.contextPath}/images/${product.image}" height="50" style="border: 1px solid #ddd; border-radius: 4px;">
                            </div>
                        </c:if>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary">Quay lại</a>
                        <button type="submit" class="btn btn-success">Lưu lại</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>