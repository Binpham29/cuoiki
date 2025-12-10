<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ Orishop</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* --- CẬP NHẬT PHẦN BACKGROUND Ở ĐÂY --- */
        .hero-section {
            /* Sử dụng một ảnh nền mới từ Unsplash và lớp phủ tối */
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: white;
            padding: 120px 0; /* Tăng padding để banner cao hơn một chút */
            margin-bottom: 40px;
            border-radius: 0 0 20px 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        /* --------------------------------------- */

        .product-card {
            border: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            background: white;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            height: 100%;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .card-img-top {
            height: 220px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }

        .price-tag {
            color: #d63031;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .btn-add-cart {
            background-color: #2d3436;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 15px;
            transition: 0.2s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-add-cart:hover {
            background-color: #fdcb6e;
            color: #2d3436;
        }
        
        .product-link {
            display: block;
            color: inherit;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-uppercase" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-bag-shopping me-2 text-warning"></i>Orishop
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/category?type=Cosmetics">Mỹ phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/category?type=Technology">Công nghệ</a>
                    </li>
                </ul>
                
                <form class="d-flex me-3">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-sm" placeholder="Tìm kiếm...">
                        <button class="btn btn-warning btn-sm" type="button"><i class="fa-solid fa-search"></i></button>
                    </div>
                </form>
                
                <a href="${pageContext.request.contextPath}/cart?action=view" class="btn btn-outline-light position-relative me-3">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        ${sessionScope.cart.size() > 0 ? sessionScope.cart.size() : 0}
                    </span>
                </a>

                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <div class="dropdown">
                            <button class="btn btn-warning dropdown-toggle btn-sm fw-bold" type="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-user me-1"></i> ${sessionScope.currentUser.fullname}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <c:if test="${sessionScope.currentUser.isAdmin}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">
                                        <i class="fa-solid fa-gear me-2"></i>Trang quản trị
                                    </a></li>
                                </c:if>
                                <li><a class="dropdown-item" href="#">Hồ sơ cá nhân</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-light btn-sm fw-bold">
                            <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </nav>

    <div class="container-fluid hero-section text-center">
        <h1 class="display-4 fw-bold">Chào mừng đến với Orishop</h1>
        <p class="lead mb-4">Khám phá bộ sưu tập sản phẩm mới nhất với giá ưu đãi.</p>
        <a href="#list-product" class="btn btn-lg btn-warning fw-bold px-4 rounded-pill">Mua sắm ngay <i class="fa-solid fa-arrow-down ms-2"></i></a>
    </div>

    <div class="container pb-5" id="list-product">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
            <h3 class="fw-bold text-uppercase text-dark"><i class="fa-solid fa-fire text-danger me-2"></i>Sản Phẩm Nổi Bật</h3>
            <a href="#" class="text-decoration-none text-muted">Xem tất cả <i class="fa-solid fa-angle-right"></i></a>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach items="${products}" var="p">
                <div class="col">
                    <div class="card product-card h-100">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="product-link" title="Xem chi tiết">
                            <img src="${pageContext.request.contextPath}/image?fname=${p.image}" 
                                 class="card-img-top img-fallback" 
                                 alt="${p.name}">
                        </a>
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title text-truncate">
                                <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" class="text-decoration-none text-dark" title="${p.name}">${p.name}</a>
                            </h5>
                            
                            <div class="mt-auto">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <c:choose>
                                        <c:when test="${p.discount > 0}">
                                            <div>
                                                <span class="price-tag text-danger fw-bold">
                                                    <fmt:setLocale value="vi_VN"/>
                                                    <fmt:formatNumber value="${p.salePrice}" type="currency"/>
                                                </span>
                                                <br>
                                                <small class="text-decoration-line-through text-muted" style="font-size: 0.9rem;">
                                                    <fmt:formatNumber value="${p.price}" type="currency"/>
                                                </small>
                                            </div>
                                            <span class="badge bg-danger">-${p.discount}%</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="price-tag">
                                                <fmt:setLocale value="vi_VN"/>
                                                <fmt:formatNumber value="${p.price}" type="currency"/>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.id}" class="btn btn-add-cart w-100 fw-bold">
                                    <i class="fa-solid fa-cart-plus me-1"></i> Thêm vào giỏ
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer class="bg-dark text-white pt-4 pb-2 mt-auto">
        <div class="container text-center text-md-start">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <h5 class="text-uppercase text-warning">Orishop</h5>
                    <p>Địa chỉ mua sắm tin cậy cho mọi nhà.</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5 class="text-uppercase">Liên kết</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white text-decoration-none">Chính sách bảo hành</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Về chúng tôi</a></li>
                    </ul>
                </div>
                <div class="col-md-4 mb-3">
                    <h5 class="text-uppercase">Liên hệ</h5>
                    <p><i class="fa-solid fa-phone me-2"></i> 090 185 4572</p>
                    <p><i class="fa-solid fa-envelope me-2"></i> phamductrung06@gmail.com</p>
                </div>
            </div>
            <div class="text-center p-3 border-top border-secondary">
                &copy; 2025 Copyright: <a class="text-white fw-bold" href="#">Orishop.com</a>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var images = document.querySelectorAll('.img-fallback');
            images.forEach(function(img) {
                img.onerror = function() {
                    this.onerror = null;
                    this.src = 'https://placehold.co/400x300?text=No+Image';
                };
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>