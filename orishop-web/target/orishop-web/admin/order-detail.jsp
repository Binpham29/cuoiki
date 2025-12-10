<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #${order.id}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Chi tiết đơn hàng #${order.id}</h4>
                <a href="${pageContext.request.contextPath}/order-manage" class="btn btn-light btn-sm">Quay lại</a>
            </div>
            <div class="card-body">
                
                <div class="row mb-4 border-bottom pb-3">
                    <div class="col-md-6">
                        <h5>Thông tin người nhận</h5>
                        <p><strong>Họ tên:</strong> ${order.fullname}</p>
                        <p><strong>Điện thoại:</strong> ${order.phone}</p>
                        <p><strong>Địa chỉ:</strong> ${order.address}</p>
                        <p><strong>Ghi chú:</strong> ${order.note}</p>
                    </div>
                    <div class="col-md-6 text-end">
                        <h5>Cập nhật trạng thái</h5>
                        <form action="${pageContext.request.contextPath}/order-manage" method="get" class="d-inline-flex">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${order.id}">
                            
                            <select name="status" class="form-select me-2">
                                <option value="Đang xử lý" ${order.status == 'Đang xử lý' ? 'selected' : ''}>Đang xử lý</option>
                                <option value="Đang giao hàng" ${order.status == 'Đang giao hàng' ? 'selected' : ''}>Đang giao hàng</option>
                                <option value="Đã giao" ${order.status == 'Đã giao' ? 'selected' : ''}>Đã giao</option>
                                <option value="Đã hủy" ${order.status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </form>
                        <p class="mt-2 text-muted">Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                    </div>
                </div>

                <h5>Sản phẩm đã mua</h5>
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá mua</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${details}" var="item">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/images/${item[2]}" width="50" class="border rounded">
                                </td>
                                <td>${item[1]}</td>
                                <td>
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${item[3]}" type="currency"/>
                                </td>
                                <td>${item[4]}</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${item[3] * item[4]}" type="currency"/>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="4" class="text-end fw-bold">TỔNG CỘNG:</td>
                            <td class="text-danger fw-bold fs-5">
                                <fmt:formatNumber value="${order.totalMoney}" type="currency"/>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</body>
</html>