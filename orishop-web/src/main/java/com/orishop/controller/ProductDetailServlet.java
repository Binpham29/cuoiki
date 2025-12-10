package com.orishop.controller;

import com.orishop.entity.Product;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");

        // Nếu không có ID thì về trang chủ
        if (idStr == null) {
            resp.sendRedirect("home");
            return;
        }

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("OrishopPU");
        EntityManager em = emf.createEntityManager();

        try {
            // Tìm sản phẩm theo ID
            Product product = em.find(Product.class, Integer.parseInt(idStr));

            if (product != null) {
                req.setAttribute("p", product);
                // Chuyển hướng sang trang giao diện chi tiết
                req.getRequestDispatcher("/views/product-detail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("home"); // Không tìm thấy sản phẩm
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }
}