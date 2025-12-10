package com.orishop.controller;

import com.orishop.entity.*;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // 1. Hiển thị trang điền thông tin
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Nếu giỏ hàng trống thì đá về trang chủ
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("home");
            return;
        }

        // Tính tổng tiền lại để hiển thị
        double totalMoney = 0;
        for (CartItem item : cart) {
            totalMoney += item.getTotalPrice();
        }
        req.setAttribute("totalMoney", totalMoney);

        req.getRequestDispatcher("/views/checkout.jsp").forward(req, resp);
    }

    // 2. Xử lý khi bấm nút "XÁC NHẬN ĐẶT HÀNG"
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ Form
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");

        // Lấy giỏ hàng
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        User currentUser = (User) session.getAttribute("currentUser");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("home");
            return;
        }

        // Tính tổng tiền
        double totalMoney = 0;
        for (CartItem item : cart) {
            totalMoney += item.getTotalPrice();
        }

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            // 1. Lưu đơn hàng (Order)
            Order order = new Order();
            if (currentUser != null) {
                order.setUserId(currentUser.getId());
            }
            order.setFullname(fullname);
            order.setPhone(phone);
            order.setAddress(address);
            order.setNote(note);
            order.setTotalMoney(totalMoney);
            order.setOrderDate(new Date());
            order.setStatus("Đang xử lý");

            em.persist(order); // Lưu và tự sinh ID

            // 2. Lưu chi tiết đơn hàng (Order Details)
            for (CartItem item : cart) {
                OrderDetail detail = new OrderDetail(
                        order.getId(), // Lấy ID của đơn hàng vừa tạo
                        item.getProduct().getId(),
                        item.getProduct().getPrice(),
                        item.getQuantity());
                em.persist(detail);
            }

            em.getTransaction().commit();

            // 3. Xóa giỏ hàng sau khi đặt thành công
            session.removeAttribute("cart");

            // 4. Thông báo thành công (Có thể tạo trang success.jsp riêng)
            resp.getWriter().println("<h1>Dat hang thanh cong! Cam on ban.</h1>");
            resp.getWriter().println("<a href='home'>Ve trang chu</a>");

        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
            resp.getWriter().println("Loi dat hang: " + e.getMessage());
        } finally {
            em.close();
            emf.close();
        }
    }
}