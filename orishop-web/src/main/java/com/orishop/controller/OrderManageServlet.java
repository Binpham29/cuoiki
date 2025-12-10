package com.orishop.controller;

import com.orishop.entity.Order;
import com.orishop.entity.OrderDetail;
import com.orishop.entity.Product;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order-manage")
public class OrderManageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idStr = req.getParameter("id");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            if ("detail".equals(action) && idStr != null) {
                // --- XEM CHI TIẾT ĐƠN HÀNG ---
                int orderId = Integer.parseInt(idStr);
                Order order = em.find(Order.class, orderId);

                // Lấy danh sách sản phẩm trong đơn hàng này
                // (Cách thủ công dùng SQL Native hoặc JPQL join bảng)
                String sql = "SELECT d.product_id, p.name, p.image, d.price, d.quantity " +
                        "FROM OrderDetails d JOIN Products p ON d.product_id = p.id " +
                        "WHERE d.order_id = :oid";

                Query query = em.createNativeQuery(sql);
                query.setParameter("oid", orderId);
                List<Object[]> details = query.getResultList();

                req.setAttribute("order", order);
                req.setAttribute("details", details);
                req.getRequestDispatcher("/admin/order-detail.jsp").forward(req, resp);

            } else if ("update".equals(action) && idStr != null) {
                // --- CẬP NHẬT TRẠNG THÁI ---
                String status = req.getParameter("status");
                em.getTransaction().begin();
                Order order = em.find(Order.class, Integer.parseInt(idStr));
                if (order != null) {
                    order.setStatus(status);
                }
                em.getTransaction().commit();
                resp.sendRedirect(req.getContextPath() + "/order-manage");

            } else {
                // --- HIỂN THỊ DANH SÁCH ĐƠN HÀNG ---
                // Sắp xếp đơn mới nhất lên đầu
                TypedQuery<Order> query = em.createQuery("SELECT o FROM Order o ORDER BY o.orderDate DESC",
                        Order.class);
                List<Order> list = query.getResultList();

                req.setAttribute("orders", list);
                req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }
}