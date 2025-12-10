<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${p.name} - Orishop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; font-family: sans-serif; }
        .detail-img { width: 100%; border-radius: 10px; border: 1px solid #ddd; }
        .price-new { color: #d63031; font-size: 1.8rem; font-weight: bold; }
        .price-old { text-decoration: line-through; color: #6c757d; font-size: 1.1rem; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-uppercase" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-arrow-left me-2"></i> Quay lại
            </a>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto"></ul> 
                
                <a href="${pageContext.request.contextPath}/cart?action=view" class="btn btn-outline-light position-relative">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        ${sessionScope.cart.size() > 0 ? sessionScope.cart.size() : 0}
                    </span>
                </a>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="card shadow-sm">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-5">
                        <img src="${pageContext.request.contextPath}/image?fname=${p.image}" 
                             class="detail-img img-fallback" 
                             alt="${p.name}">
                    </div>

                    <div class="col-md-7">
                        <h2 class="fw-bold mb-3">${p.name}</h2>
                        
                        <div class="mb-4">
                            <c:if test="${p.discount > 0}">
                                <span class="badge bg-danger mb-2">Giảm ${p.discount}%</span><br>
                                <span class="price-new me-2">
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${p.salePrice}" type="currency"/>
                                </span>
                                <span class="price-old">
                                    <fmt:formatNumber value="${p.price}" type="currency"/>
                                </span>
                            </c:if>
                            <c:if test="${p.discount <= 0}">
                                <span class="price-new">
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${p.price}" type="currency"/>
                                </span>
                            </c:if>
                        </div>

                        <p class="text-muted">
                            <strong>Danh mục:</strong> 
                            <c:choose>
                                <c:when test="${p.category == 'Technology'}">Công nghệ</c:when>
                                <c:when test="${p.category == 'Cosmetics'}">Mỹ phẩm</c:when>
                                <c:otherwise>Khác</c:otherwise>
                            </c:choose>
                        </p>

                        <p>
                            <strong>Mô tả:</strong><br>
                            Đây là sản phẩm chính hãng được phân phối bởi Orishop. 
                            Sản phẩm được bảo hành 12 tháng và hỗ trợ đổi trả trong vòng 7 ngày.
                        </p>

                        <hr>

                        <div class="d-flex gap-3 mt-4">
                            <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.id}" class="btn btn-warning btn-lg fw-bold flex-grow-1">
                                <i class="fa-solid fa-cart-plus me-2"></i> THÊM VÀO GIỎ
                            </a>
                            <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.id}" class="btn btn-primary btn-lg fw-bold flex-grow-1">
                                MUA NGAY
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="mt-5">
            <h4>Có thể bạn cũng thích</h4>
            <div class="alert alert-info">Tính năng sản phẩm liên quan đang được phát triển...</div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p>&copy; 2025 Orishop. All rights reserved.</p>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var images = document.querySelectorAll('.img-fallback');
            images.forEach(function(img) {
                img.onerror = function() {
                    this.onerror = null;
                    this.src = 'https://placehold.co/500x500?text=No+Image';
                };
            });
        });
    </script>

</body>
</html>