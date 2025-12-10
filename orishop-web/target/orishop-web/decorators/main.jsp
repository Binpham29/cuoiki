<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="dec" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><dec:title default="Orishop Mỹ Phẩm" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <dec:head />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">ORISHOP</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="#">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Giỏ hàng</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container" style="min-height: 600px;">
        <dec:body />
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="m-0">&copy; 2025 Orishop Cosmetics</p>
    </footer>
</body>
</html>