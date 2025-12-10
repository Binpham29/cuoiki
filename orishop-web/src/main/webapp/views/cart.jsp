<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-arrow-left me-2"></i> Tiếp tục mua sắm
            </a>
            <span class="navbar-text text-white">Giỏ hàng của bạn</span>
        </div>
    </nav>

    <div class="container">
        <c:if test="${empty sessionScope.cart}">
            <div class="text-center py-5">
                <i class="fa-solid fa-cart-arrow-down fa-4x text-muted mb-3"></i>
                <h3>Giỏ hàng đang trống!</h3>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">Mua sắm ngay</a>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.cart}">
            <div class="row">
                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <table class="table align-middle">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.cart}" var="item">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/image?fname=${item.product.image}" 
                                                         width="60" class="rounded border me-3 img-cart"
                                                         alt="${item.product.name}">
                                                    <div>
                                                        <strong>${item.product.name}</strong>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <fmt:setLocale value="vi_VN"/>
                                                <fmt:formatNumber value="${item.product.price}" type="currency"/>
                                            </td>
                                            <td>
                                                <input type="number" value="${item.quantity}" min="1" class="form-control form-control-sm" style="width: 60px;" readonly>
                                            </td>
                                            <td class="fw-bold text-danger">
                                                <fmt:formatNumber value="${item.totalPrice}" type="currency"/>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}" 
                                                   class="btn btn-sm btn-outline-danger"
                                                   onclick="return confirm('Bạn muốn bỏ sản phẩm này?');">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white fw-bold">Thanh toán</div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3">
                                <span>Tạm tính:</span>
                                <span class="fw-bold">
                                    <fmt:formatNumber value="${totalMoney}" type="currency"/>
                                </span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-4">
                                <span class="h5">Tổng cộng:</span>
                                <span class="h5 text-danger">
                                    <fmt:formatNumber value="${totalMoney}" type="currency"/>
                                </span>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-warning w-100 py-2 fw-bold">
                                TIẾN HÀNH THANH TOÁN
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var images = document.querySelectorAll('.img-cart');
            images.forEach(function(img) {
                img.onerror = function() {
                    this.onerror = null;
                    this.src = 'https://placehold.co/60?text=Error'; 
                };
            });
        });
    </script>

</body>
</html>