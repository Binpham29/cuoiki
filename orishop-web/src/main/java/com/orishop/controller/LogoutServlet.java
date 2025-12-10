package com.orishop.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy phiên làm việc hiện tại (nếu có)
        HttpSession session = req.getSession(false);

        if (session != null) {
            // 2. Hủy session (Xóa sạch thông tin currentUser đã lưu)
            session.invalidate();
        }

        // 3. Chuyển hướng về trang đăng nhập (hoặc trang chủ tùy bạn)
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}