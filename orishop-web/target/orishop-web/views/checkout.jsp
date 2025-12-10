<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="text-center mb-4">THÔNG TIN THANH TOÁN</h2>
        
        <form action="${pageContext.request.contextPath}/checkout" method="post">
            <div class="row">
                <div class="col-md-7">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-white"><strong>Thông tin người nhận</strong></div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control" 
                                       value="${sessionScope.currentUser.fullname}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" name="phone" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ giao hàng</label>
                                <input type="text" name="address" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ghi chú (Tùy chọn)</label>
                                <textarea name="note" class="form-control" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="card shadow-sm">
                        <div class="card-header bg-dark text-white">
                            <strong>Đơn hàng của bạn</strong>
                        </div>
                        <ul class="list-group list-group-flush">
                            <c:forEach items="${sessionScope.cart}" var="item">
                                <li class="list-group-item d-flex justify-content-between lh-sm">
                                    <div>
                                        <h6 class="my-0">${item.product.name}</h6>
                                        <small class="text-muted">SL: ${item.quantity}</small>
                                    </div>
                                    <span class="text-muted">
                                        <fmt:formatNumber value="${item.totalPrice}" type="currency"/>
                                    </span>
                                </li>
                            </c:forEach>
                            <li class="list-group-item d-flex justify-content-between fw-bold bg-light">
                                <span>Tổng tiền (VNĐ)</span>
                                <span class="text-danger">
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${totalMoney}" type="currency"/>
                                </span>
                            </li>
                        </ul>
                        <div class="card-body">
                            <button type="submit" class="btn btn-success w-100 py-2">XÁC NHẬN ĐẶT HÀNG</button>
                            <a href="${pageContext.request.contextPath}/cart?action=view" class="btn btn-link w-100 text-decoration-none mt-2">Quay lại giỏ hàng</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>